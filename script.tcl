# ==========================================
# script.tcl - Fluxo de Síntese Automatizado
# ==========================================

# Argumentos recebidos
set verilog_dir [lindex $argv 0]
set top_module  [lindex $argv 1]
set part_fpga   [lindex $argv 2]
set output_dir  [lindex $argv 3]

# Configura mensagens
puts "\n========================================"
puts "Iniciando sintese para $top_module"
puts "========================================"
puts "Diretorio Verilog: $verilog_dir"
puts "Top Module: $top_module"
puts "FPGA Part: $part_fpga"
puts "Diretorio Saida: $output_dir"

# Verifica se a pasta existe
if {![file exists $verilog_dir]} {
    puts "\nERRO: Diretorio $verilog_dir nao encontrado!"
    exit 1
}

# Lista arquivos .v
set verilog_files [glob -nocomplain -directory $verilog_dir *.v]
if {[llength $verilog_files] == 0} {
    puts "\nERRO: Nenhum arquivo .v encontrado em:"
    puts "Conteudo do diretorio: [glob -nocomplain -directory $verilog_dir *]"
    exit 1
}

# Mostra arquivos encontrados
puts "\nArquivos Verilog encontrados:"
foreach file $verilog_files { puts "- $file" }

# Cria projeto in-memory
create_project -in_memory -part $part_fpga

# Adiciona arquivos
read_verilog $verilog_files

# Sintetiza
puts "\nIniciando sintese..."
synth_design -top $top_module -part $part_fpga

# Gera saídas
file mkdir $output_dir
set netlist_file "$output_dir/${top_module}_netlist.v"
set report_file "$output_dir/${top_module}_utilization.txt"

puts "\nGerando resultados:"
puts "- Netlist: $netlist_file"
puts "- Relatorio: $report_file"

write_verilog -force $netlist_file
report_utilization -file $report_file -hierarchical

puts "\n========================================"
puts "Sintese concluida com sucesso!"
puts "========================================"
exit 0