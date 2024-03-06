#!/bin/bash
#This script will create a second tmux session to switch between windows seperatly
#Started by Riley C on 1/17/2024
echo "To switch between windows use CTRL-B <WINDOW #>"
echo "To disconnect use CTRL-B d, NOT CTRL-D"
sleep 2
tmux new-session -s winlinkauto2 -t winlinkauto
