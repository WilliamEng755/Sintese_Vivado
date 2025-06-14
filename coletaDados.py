'''import os
import re
import csv

pastas = [p for p in os.listdir() if os.path.isdir(p) and p.startswith("modelo")]
resultados = []

for pasta in pastas:
    rpt_path = os.path.join(pasta, "relatorio_util.rpt")
    if not os.path.exists(rpt_path):
        continue

    with open(rpt_path, "r") as f:
        conteudo = f.read()

    match = re.search(r'CLB LUTs\s+\|\s+(\d+)', conteudo)
    luts = int(match.group(1)) if match else "N/A"
    
    resultados.append([pasta, luts])

# Salvar como CSV
with open("relatorio_luts.csv", "w", newline="") as f:
    writer = csv.writer(f)
    writer.writerow(["Versão", "LUTs"])
    writer.writerows(resultados)

print("✅ Planilha gerada: relatorio_luts.csv")
'''