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
