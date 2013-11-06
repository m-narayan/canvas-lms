start_time=$(date +%s)
i=1
  for file in spec/*
  do
   echo "File $((i++)) : $file"
   IFS='/' read -ra ADDR <<< "$file"
echo "ADDR[1] : ${ADDR[0]} : : ${ADDR[1]}"
   if [ "${ADDR[1]}" != "selenium" ]
    then
	RAILS_env=test  script/spec $file > ~/spec/arrivu-lms-spec/$file
   else
	echo "Skipping selenium dir"		
	continue     
 fi 
  
 done
finish_time=$(date +%s)
echo "Time duration: $((finish_time - start_time)) secs."
