use aptitude to install redsocks:

    pi@raspberrypi:~ $ sudo aptitude show redsocks 
    Package: redsocks
    Version: 0.5-1 
    State: installed
    
shadowsocks config:

    {

        "server":"ss_ip",

        "server_port":12345,

        "local_address": "0.0.0.0",

        "local_port":2080,

        "password":"*****",

        "timeout":600,

        "method":"aes-256-cfb",

        "fast_open": false

    }
    
install zerotier:

    curl -s https://install.zerotier.com/ | sudo bash
    
check zerotier network
    
    pi@raspberrypi:~ $ sudo zerotier-cli listnetworks
    200 listnetworks <nwid> <name> <mac> <status> <type> <dev> <ZT assigned ips>
    200 listnetworks xxx world 22:ec:2a:b1:ef:40 OK PRIVATE ztc3qssbai fda0:cbf4:b62a:ddb2:2299:935e:f79b:59b4/88,fc8a:1646:945e:f79b:59b4:0000:0000:0001/40,192.168.196.163/24
    200 listnetworks fff local f2:79:08:a9:5f:3e OK PRIVATE ztqu3hkioc fd83:048a:0632:ff27:f099:935e:f79b:59b4/88,fcb1:fbad:f65e:f79b:59b4:0000:0000:0001/40,10.147.17.163/24
