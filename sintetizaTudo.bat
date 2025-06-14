@echo off
setlocal enabledelayedexpansion

:: Configurações - MODIFIQUE ESTES CAMINHOS SE NECESSÁRIO
set "VIVADO=C:\Xilinx\Vivado\2024.2\bin\vivado.bat"
set "FPGA_PART=xc7a35ticsg324-1L"
set "TOP_MODULE=TreeLUT"

:: --------------------------------------------------
:: NÃO MODIFIQUE ABAIXO DESTA LINHA
:: --------------------------------------------------

:: Obtém caminho do script atual
set "SCRIPT_DIR=%~dp0"
set "SCRIPT_DIR=%SCRIPT_DIR:~0,-1%"

:: Define pastas de entrada/saída
set "VERILOG_DIR=%SCRIPT_DIR%\verilog"
set "OUTPUT_DIR=%SCRIPT_DIR%\output_sintese"

echo ******************************************
echo * Configuracao do Ambiente              *
echo ******************************************
echo Diretorio do Script: %SCRIPT_DIR%
echo Pasta Verilog: %VERILOG_DIR%
echo Pasta Saida: %OUTPUT_DIR%
echo.

:: Verifica se a pasta verilog existe
if not exist "%VERILOG_DIR%" (
    echo ERRO: Pasta verilog nao encontrada em:
    echo %VERILOG_DIR%
    pause
    exit /b 1
)

:: Cria pasta de saída se não existir
if not exist "%OUTPUT_DIR%" (
    mkdir "%OUTPUT_DIR%"
)

:: Executa o Vivado
echo Executando sintese para %TOP_MODULE%...
call "%VIVADO%" -mode batch -source "%SCRIPT_DIR%\script.tcl" -tclargs "%VERILOG_DIR%" "%TOP_MODULE%" "%FPGA_PART%" "%OUTPUT_DIR%"

if errorlevel 1 (
    echo ERRO durante a sintese
) else (
    echo Sintese concluida com sucesso!
    echo Resultados em: %OUTPUT_DIR%
)

pause