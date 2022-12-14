IFS=";"
echo -n > $3
while read engine exectime nalert nevents
  do
    if [ $engine = $2 ] && ([ $nevents -eq 1000 ] || [ $nevents -eq 900 ] || [ $nevents -eq 800 ] || [ $nevents -eq 700 ] || [ $nevents -eq 600 ] || [ $nevents -eq 500 ] || [ $nevents -eq 400 ] || [ $nevents -eq 300 ] || [ $nevents -eq 200 ] || [ $nevents -eq 100 ] || [ $nevents -eq 10 ]); then
      echo $exectime";"$nevents >> $3
    fi
  done < $1
