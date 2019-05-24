#local
#iptables -A FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT
#iptables -A FORWARD -s 10.147.17.0/24 -j ACCEPT
#iptables -t nat -A POSTROUTING -s 10.147.17.0/24 -o wlan0 -j MASQUERADE

echo 1 | sudo tee /proc/sys/net/ipv4/ip_forward
sysctl -p
sysctl net.ipv4.ip_forward

cd /home/pi/redsocks/
nohup python dns-client.py config.json.local &
cd /home/pi/shadowsocks/shadowsocks
nohup python local.py &
cd /home/pi/srelay
./srelay -i 0.0.0.0:9999 -c srelay.conf

sudo iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE

sudo iptables -t nat -N REDSOCKS
# bypass local
sudo iptables -t nat -A REDSOCKS -d 0.0.0.0/8 -j RETURN
sudo iptables -t nat -A REDSOCKS -d 10.0.0.0/8 -j RETURN
sudo iptables -t nat -A REDSOCKS -d 127.0.0.0/8 -j RETURN
sudo iptables -t nat -A REDSOCKS -d 169.254.0.0/16 -j RETURN
sudo iptables -t nat -A REDSOCKS -d 172.16.0.0/12 -j RETURN
sudo iptables -t nat -A REDSOCKS -d 192.168.0.0/16 -j RETURN
sudo iptables -t nat -A REDSOCKS -d 224.0.0.0/4 -j RETURN
sudo iptables -t nat -A REDSOCKS -d 240.0.0.0/4 -j RETURN

iptables -t nat -A REDSOCKS -d 117.25.157.0/24 -j RETURN
iptables -t nat -A REDSOCKS -d 157.185.144.0/24 -j RETURN

sudo iptables -t nat -A OUTPUT -d 104.238.131.160 -j RETURN # bypass proxy ip
sudo iptables -t nat -A OUTPUT -d 42.200.198.191 -j RETURN # bypass proxy ip

sudo iptables -t nat -A REDSOCKS -p tcp -j REDIRECT --to-ports 12345
# forward dns request from zerotier to local dns server
sudo iptables -t nat -A REDSOCKS -s 192.168.193.0/24 -p udp --dport 53 -j REDIRECT --to-ports 53
sudo iptables -t nat -A REDSOCKS -s 10.147.17.0/24 -p udp --dport 53 -j REDIRECT --to-ports 53

sudo iptables -t nat -A OUTPUT -p tcp  -j REDSOCKS
sudo iptables -t nat -A OUTPUT -p udp --dport 53 -j REDSOCKS # dns

sudo iptables -t nat -A PREROUTING -p tcp -j REDSOCKS
sudo iptables -t nat -A PREROUTING -p udp -j REDSOCKS
