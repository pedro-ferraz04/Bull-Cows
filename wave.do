onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -position insertpoint  \
sim:/calculadora_top_tb/clock
add wave -position insertpoint  \
sim:/calculadora_top_tb/reset
add wave -position insertpoint  \
sim:/calculadora_top_tb/cmd
add wave -position insertpoint  \
sim:/calculadora_top_tb/guess
add wave -position insertpoint  \
sim:/calculadora_top_tb/d1

add wave -position insertpoint  \
sim:/calculadora_top_tb/result


add wave -position insertpoint  \
sim:/ctrl/a

TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1241 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {4515 ns}

