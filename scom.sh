#!/bin/bash
mydir=$(pwd)
echo "$mydir"
# Подразумеваю, что сейчас вы находитесь в директории с 3-мя основными клонированными проектами: PhotoRadarSources, WebInterface, SCM_phradar
cd WebInterface/
echo "directory WebInterface"
day=$(date +"%d%m%Y")
touch commits$day.log

git checkout Release_5.23
git pull
git log --all --pretty=format:"%ad %s" --since='1 day ago' --date=short > Diff$day.log
#since может принимать любое удобное значение, например --since='30 days ago'. --date необязательно. format вывода можно задать любой.
#cat test1.log > Diff$day.log
echo "cycle started..."

while IFS= read -r line
do
	echo "$line" | grep -i fix-bug | grep -v origin | grep -v into >> commits$day.log
	echo "$line" | grep KRDN | grep " / " | grep -v fix | grep -v origin >> commits$day.log
	echo "$line" | grep VAPA | grep " / " | grep -v fix | grep -v origin >> commits$day.log
done < Diff$day.log

rm Diff$day.log
cd -
mv ./WebInterface/commits$day.log ./PhotoRadarSources/
cd PhotoRadarSources/
echo "directory PhotoRadarSources"

git checkout Release_5.23
git pull
git log --all --pretty=format:"%ad %s" --since='1 day ago' --date=short > Diff$day.log
#cat test3.log > Diff$day.log
echo "cycle started..."

while IFS= read -r line
do
	echo "$line" | grep NEW >> commits$day.log
	echo "$line" | grep MOD >> commits$day.log
	echo "$line" | grep FIX >> commits$day.log
done < Diff$day.log

rm Diff$day.log
cd -
mv ./PhotoRadarSources/commits$day.log ./SCM_phradar/
cd SCM_phradar/
echo "directory SCM_phradar"

git checkout Release_5.23
git pull
git log --all --pretty=format:"%ad %s" --since='1 day ago' --date=short > Diff$day.log
#cat test3.log > Diff$day.log
echo "cycle started..."

while IFS= read -r line
do
	echo "$line" | grep NEW >> commits$day.log
	echo "$line" | grep MOD >> commits$day.log
	echo "$line" | grep FIX >> commits$day.log
done < Diff$day.log

rm Diff$day.log
touch uncommits$day.log
cat commits$day.log | cut -d ' ' -f2- | cut -d ':' -f2- | sort -u | uniq >> uncommits$day.log
cat uncommits$day.log
rm commits$day.log
cd -
mv ./SCM_phradar/uncommits$day.log ./