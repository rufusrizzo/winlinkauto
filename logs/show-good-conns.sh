cat logs/pat_connect-summ.log | awk -F"|" '{if ($NF < "1") print $0;}'
