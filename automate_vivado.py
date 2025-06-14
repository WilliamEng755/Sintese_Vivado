import os
import subprocess
import shutil
import re
from datetime import datetime

# Configurações
VIVADO_PATH = "C:\XilinxVivado\Vivado\2024.2\bin\vivado.bat"  # Ajuste para o seu caminho do Vivado
PROJECT_NAME = "auto_synth_project"
OUTPUT_BASE_DIR = "vivado_results"
LOG_FILE = "automation_log.txt"

def create_tcl_script(verilog_file, output_dir):
    """Cria um script TCL temporário para síntese no Vivado"""
    tcl_script = f"""
# Cria projeto
create_project -force {PROJECT_NAME} {output_dir}/{PROJECT_NAME} -part xc7a35ticsg324-1L
set_property target_language Verilog [current_project]

# Adiciona arquivos Verilog
add_files -norecurse {verilog_file}

# Configura o top module (assume que o nome do módulo é o mesmo do arquivo sem extensão)
set top_module [file rootname [file tail {verilog_file}]]
set_property top $top_module [current_fileset]

# Executa síntese
synth_design -top $top_module

# Gera arquivo result.v
write_verilog -force {output_dir}/result.v

# Relatório de utilização
report_utilization -hierarchical -file {output_dir}/utilization.rpt

# Fecha projeto
close_project
exit
"""
    tcl_file = os.path.join(output_dir, "synth_script.tcl")
    with open(tcl_file, 'w') as f:
        f.write(tcl_script)
    return tcl_file

def extract_luts_from_report(report_file):
    """Extrai informações de LUTs do relatório de utilização"""
    with open(report_file, 'r') as f:
        content = f.read()
    
    # Procura por padrão de LUTs no relatório
    pattern = r"\|\s*Slice LUTs\s*\|\s*(\d+)\s*\|\s*(\d+)\s*\|\s*(\d+\.\d+)\s*\|"
    match = re.search(pattern, content)
    
    if match:
        used = match.group(1)
        available = match.group(2)
        percentage = match.group(3)
        return {
            'used': int(used),
            'available': int(available),
            'percentage': float(percentage)
        }
    return None

def process_verilog_file(verilog_file, output_dir):
    """Processa um único arquivo Verilog"""
    # Cria diretório de saída para este arquivo
    file_name = os.path.splitext(os.path.basename(verilog_file))[0]
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    specific_output_dir = os.path.join(output_dir, f"{file_name}_{timestamp}")
    os.makedirs(specific_output_dir, exist_ok=True)
    
    # Cria script TCL
    tcl_script = create_tcl_script(verilog_file, specific_output_dir)
    
    # Executa Vivado
    log_file = os.path.join(specific_output_dir, "vivado_log.txt")
    with open(log_file, 'w') as log:
        cmd = [VIVADO_PATH, "-mode", "batch", "-source", tcl_script]
        subprocess.run(cmd, stdout=log, stderr=subprocess.STDOUT)
    
    # Extrai LUTs do relatório
    report_file = os.path.join(specific_output_dir, "utilization.rpt")
    luts_info = extract_luts_from_report(report_file)
    
    # Salva informações em um arquivo JSON
    if luts_info:
        import json
        with open(os.path.join(specific_output_dir, "luts_info.json"), 'w') as f:
            json.dump(luts_info, f, indent=4)
    
    return specific_output_dir, luts_info

def find_verilog_files(root_dir):
    """Encontra todos os arquivos Verilog nos subdiretórios"""
    verilog_files = []
    for root, _, files in os.walk(root_dir):
        for file in files:
            if file.endswith(('.v', '.vh', '.verilog')):
                verilog_files.append(os.path.join(root, file))
    return verilog_files

def main():
    # Cria diretório base de saída
    os.makedirs(OUTPUT_BASE_DIR, exist_ok=True)
    
    # Configura log global
    global_log = os.path.join(OUTPUT_BASE_DIR, LOG_FILE)
    
    with open(global_log, 'a') as log:
        log.write(f"\n\n=== Iniciando processamento em {datetime.now()} ===\n")
        
        # Pede ao usuário o diretório raiz contendo as pastas com arquivos Verilog
        root_dir = input("Digite o caminho do diretório raiz contendo as pastas com arquivos Verilog: ")
        
        # Verifica se o diretório existe
        if not os.path.isdir(root_dir):
            log.write(f"Erro: Diretório {root_dir} não encontrado.\n")
            print(f"Erro: Diretório {root_dir} não encontrado.")
            return
        
        # Encontra todos os arquivos Verilog
        verilog_files = find_verilog_files(root_dir)
        
        if not verilog_files:
            log.write("Nenhum arquivo Verilog encontrado.\n")
            print("Nenhum arquivo Verilog encontrado.")
            return
        
        log.write(f"Encontrados {len(verilog_files)} arquivos Verilog para processar.\n")
        print(f"Encontrados {len(verilog_files)} arquivos Verilog para processar.")
        
        # Processa cada arquivo
        summary = []
        for i, verilog_file in enumerate(verilog_files, 1):
            try:
                log.write(f"\nProcessando arquivo {i}/{len(verilog_files)}: {verilog_file}\n")
                print(f"\nProcessando arquivo {i}/{len(verilog_files)}: {verilog_file}")
                
                output_dir, luts_info = process_verilog_file(verilog_file, OUTPUT_BASE_DIR)
                
                if luts_info:
                    summary_entry = {
                        'file': verilog_file,
                        'output_dir': output_dir,
                        'luts': luts_info
                    }
                    summary.append(summary_entry)
                    log.write(f"Sucesso. LUTs usadas: {luts_info['used']}/{luts_info['available']} ({luts_info['percentage']}%)\n")
                    print(f"Sucesso. LUTs usadas: {luts_info['used']}/{luts_info['available']} ({luts_info['percentage']}%)")
                else:
                    log.write("Processamento concluído, mas não foi possível extrair informações de LUTs.\n")
                    print("Processamento concluído, mas não foi possível extrair informações de LUTs.")
            
            except Exception as e:
                log.write(f"Erro ao processar {verilog_file}: {str(e)}\n")
                print(f"Erro ao processar {verilog_file}: {str(e)}")
        
        # Gera relatório resumido
        if summary:
            summary_file = os.path.join(OUTPUT_BASE_DIR, f"summary_{datetime.now().strftime('%Y%m%d_%H%M%S')}.json")
            import json
            with open(summary_file, 'w') as f:
                json.dump(summary, f, indent=4)
            
            log.write(f"\nRelatório resumido salvo em: {summary_file}\n")
            print(f"\nRelatório resumido salvo em: {summary_file}")
        
        log.write(f"\n=== Processamento concluído em {datetime.now()} ===\n")
        print("\nProcessamento concluído.")

if __name__ == "__main__":
    main()