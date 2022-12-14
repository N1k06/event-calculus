load 'config/dark2.pal'
load 'config/xyborder.cfg'
load 'config/grid.cfg'
load 'config/mathematics.cfg'

set autoscale
#unset autoscale

set xlabel 'Number of Events'
set ylabel 'Execution Time [ms]'
set terminal qt size 600,550 font 'Helvetica,9'

#plot 'res2_rbt_aggregate.txt' using 1:2 w lines ls 1 lw 2 notitle, 'res2_rbt_aggregate.txt' using 1:2:3 w yerrorbars ls 1 lw 1 notitle
plot 'res4_rbt_aggregate.txt' using 1:2 w lines ls 1 lw 2 notitle, 'res4_rbt_aggregate.txt' using 1:2:3 w yerrorbars ls 1 lw 1 notitle
#plot 'res6_rbt_aggregate.txt' using 1:2 w lines ls 1 lw 2 notitle, 'res6_rbt_aggregate.txt' using 1:2:3 w yerrorbars ls 1 lw 1 notitle
plot 'res8_rbt_aggregate.txt' using 1:2 w lines ls 1 lw 2 notitle, 'res8_rbt_aggregate.txt' using 1:2:3 w yerrorbars ls 1 lw 1 notitle

#plot 'res2_l_findall_aggregate.txt' using 1:2 w lines ls 1 lw 2 lc rgb 'red' notitle, 'res2_l_findall_aggregate.txt' using 1:2:3 w yerrorbars ls 1 lw 1 lc rgb 'red' notitle
#plot 'res4_l_findall_aggregate.txt' using 1:2 w lines ls 1 lw 2 lc rgb 'red' notitle, 'res4_l_findall_aggregate.txt' using 1:2:3 w yerrorbars ls 1 lw 1 lc rgb 'red' notitle
#plot 'res6_l_findall_aggregate.txt' using 1:2 w lines ls 1 lw 2 lc rgb 'red' notitle, 'res6_l_findall_aggregate.txt' using 1:2:3 w yerrorbars ls 1 lw 1 lc rgb 'red' notitle
#plot 'res8_l_findall_aggregate.txt' using 1:2 w lines ls 1 lw 2 lc rgb 'red' notitle, 'res8_l_findall_aggregate.txt' using 1:2:3 w yerrorbars ls 1 lw 1 lc rgb 'red' notitle



#plot 'seqSingleAl_sparse_jrec.txt' using 1:2 w lines ls 1 lw 2 lc rgb 'red' notitle, 'seqSingleAl_sparse_jrec.txt' using 1:2:3 w yerrorbars ls 1 lw 1 lc rgb 'red' notitle


plot 'cmplxSingleAl_sparse_jrec.txt' using 1:2 w lines ls 1 lw 2 lc rgb 'red' dt 3 title 'standard jREC', 'cmplxSingleAl_sparse_jrec.txt' using 1:2:3 w yerrorbars ls 1 lw 1 lc rgb 'red' notitle,'res8_rbt_aggregate.txt' using 1:2 w lines ls 1 lw 2 title 'RBT-indexing jREC ', 'res8_rbt_aggregate.txt' using 1:2:3 w yerrorbars ls 1 lw 1 notitle

plot 'seqSingleAl_sparse_jrec.txt' using 1:2 w lines ls 1 lw 2 lc rgb 'red' dt 3 title 'standard jREC', 'seqSingleAl_sparse_jrec.txt' using 1:2:3 w yerrorbars ls 1 lw 1 lc rgb 'red' notitle,'res4_rbt_aggregate.txt' using 1:2 w lines ls 1 lw 2 title 'RBT-indexing jREC ', 'res4_rbt_aggregate.txt' using 1:2:3 w yerrorbars ls 1 lw 1 notitle

set xrange [0:200]
