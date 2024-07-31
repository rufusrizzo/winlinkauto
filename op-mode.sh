#!/bin/bash
#This script will create a tmux session to tail all the process log files
#Started by Riley C on 9/20/2023
echo "To switch between windows use CTRL-B <WINDOW #>"
echo "To disconnect use CTRL-B d, NOT CTRL-D"
sleep 2
tmux new-session -d -s winlinkauto
tmux new-window -d -n pat -t winlinkauto:1 "bash"
tmux new-window -d -n rigctl -t winlinkauto:2 "bash"
tmux new-window -d -n ardop -t winlinkauto:3 "bash"
tmux new-window -d -n direwolf -t winlinkauto:4 "bash"
tmux new-window -d -n shell -t winlinkauto:5 "bash"
#tmux send -t winlinkauto:1 "tail -f /var/log/winlinkauto/pat.log" C-m
tmux send -t winlinkauto:1 "multitail -i /var/log/winlinkauto/pat.log -i /home/riley/.local/state/pat/pat.log -i /home/riley/.local/state/pat/eventlog.json" C-m
tmux send -t winlinkauto:2 "tail -F /var/log/winlinkauto/rigctl.log" C-m
tmux send -t winlinkauto:3 "tail -F /var/log/winlinkauto/ardop.log" C-m
tmux send -t winlinkauto:4 "tail -F /var/log/winlinkauto/direwolf.log" C-m

tmux attach -t winlinkauto
