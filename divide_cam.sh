#!/bin/bash
file="event_cam.json"
i=0
IFS=$'\n'
for var in $(cat $file)
do
	i=$(($i + 1))
	touch ex_$i.json
	echo "$i"
	echo "$var" | tee ex_$i.json
done

for ((a=1; a<=100; a++))
do
file_ex="ex_$a.json"
string=$(cat $file_ex)
echo "Строка из ex_$a:"
echo "$string"

echo "Массив из строки ex_$a:"
IFS=',' read -ra array<<<$string; declare -p array;
unset "array[0]"
unset "array[49]"

echo ""{$(IFS=","; echo "${array[*]}")}"" >> example_$a.json
file_new="example_$a.json"
echo "Файл примера CAM:"
echo "$(cat $file_new)"
done

rm ex_*.json
