#on cornet server
export PATH=$PATH:/usr/sbin:/usr/bin
iptables -I INPUT -p udp -j ACCEPT
iptables -I INPUT -p tcp --dport 36687 -j ACCEPT
iptables -I INPUT -p tcp -s 42.200.198.191 --dport 8118 -j ACCEPT
iptables -I INPUT -p tcp --dport 22 -j ACCEPT
iptables-save | perl -ne '$H{$_}++ or print' | iptables-restore
cd /root/shadowsocks
nohup python server.py -c config.json &
cd /tmp/
# go get github.com/wynemo/kiss-proxy/httpproxy
nohup /root/httpproxy &
