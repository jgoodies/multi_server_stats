# multi_server_stats
bash script that gathers hourly average traffic statistics from multiple servers and sends it to telegram

on all servers:

```
sudo apt update
sudo apt install vnstat
```

on main server:
```
curl -Lo multi_server_stats.sh https://github.com/jgoodies/multi_server_stats/multi_server_stats.sh
```
