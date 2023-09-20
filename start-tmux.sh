tmux new-session -d -s winlinkauto
tmux new-window -d -n rigctl -t winlinkauto:2 "bash"
tmux new-window -d -n direwolf -t winlinkauto:4 "bash"
tmux new-window -d -n ardop -t winlinkauto:3 "bash"
tmux new-window -d -n pat -t winlinkauto:1 "bash"
tmux new-window -d -n shell -t winlinkauto:5 "bash"
tmux send -t winlinkauto:1 "pat http" C-m
tmux send -t winlinkauto:2 "rigctld -m 1042 -v -r /dev/ttyUSB0 -s 38400" C-m
#tmux send -t winlinkauto:3 "../ardopc/piardopc 8515 plughw:1,0 plughw:1,0" C-m
tmux send -t winlinkauto:3 " ../ardopc/piardopc -l /home/riley/git/winlinkauto/logs/ardop 8515 plughw:1,0 plughw:1,0" C-m
tmux send -t winlinkauto:4 "direwolf -c /etc/direwolf.conf" C-m

