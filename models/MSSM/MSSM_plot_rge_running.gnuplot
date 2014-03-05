set terminal x11

set title "MSSM renormalization group running"
set xlabel "renormalization scale / GeV"
set logscale x

plot for [i=2:111+1] 'MSSM_rge_running.dat' using 1:(column(i)) title columnhead(i)
