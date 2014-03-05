set terminal x11

set title "MSSM particle spectrum"
set ylabel "mass / GeV"
unset key

plot "MSSM_spectrum.dat" using 1:2:(0.4):(0):xtic(3) with boxxyerrorbars linecolor rgb "black"
