#!/bin/bash
cd ~
mydir=$(pwd)
cd /home/root/ext-fs/
echo "$mydir"
./set_environment.sh && cd /home/root/tests/
./obu_main_1.9.0 && sleep 2
killall obu_main_1.9.0 && sleep 2
cd ~
cd /home/root/ext-fs/usr/cv2x_config/
cp *Cfg /home/root/tests/cfgRsu_1.9.0/
cd /home/root/tests/
echo "$mydir"
./obu_main_1.9.0