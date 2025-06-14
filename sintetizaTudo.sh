#!/bin/bash

TOP_MODULES=("TreeLUT")  # Liste os nomes dos módulos top de cada pasta, na mesma ordem das pastas!
FPGA_PART="xc7a35ticsg324-1L"  # Substitua pelo part number do seu FPGA

i=0
for dir in */ ; do
    if [ -d "$dir" ]; then
        top=${TOP_MODULES[$i]}
        echo "Processando $dir com top module $top"
        vivado -mode batch -source script.tcl -tclargs "$PWD/$dir" "$top" "$FPGA_PART"
        ((i++))
    fi
done
