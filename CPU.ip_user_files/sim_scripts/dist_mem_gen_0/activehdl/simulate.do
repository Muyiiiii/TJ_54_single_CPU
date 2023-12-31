onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+dist_mem_gen_0 -L unisims_ver -L unimacro_ver -L secureip -L xil_defaultlib -L xpm -L dist_mem_gen_v8_0_10 -O5 xil_defaultlib.dist_mem_gen_0 xil_defaultlib.glbl

do {wave.do}

view wave
view structure
view signals

do {dist_mem_gen_0.udo}

run -all

endsim

quit -force
