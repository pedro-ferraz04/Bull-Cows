# sim.do

# Work
vlib work
vdel -all -lib work
#vmap work work

# Compilando os arquivos Verilog
vlog -reportprogress 300 bullsCows.sv
vlog -reportprogress 300 bullsCows_tb.sv

# Começo
#vsim work.calculadora_top_tb

do wave.do

# Run
run 5000 ns
