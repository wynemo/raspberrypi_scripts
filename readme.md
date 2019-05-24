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
    
install zerotier on pi:

    curl -s https://install.zerotier.com/ | sudo bash
    
check zerotier network
    
    pi@raspberrypi:~ $ sudo zerotier-cli listnetworks
    200 listnetworks <nwid> <name> <mac> <status> <type> <dev> <ZT assigned ips>
    200 listnetworks xxx world 22:ec:2a:b1:ef:40 OK PRIVATE ztc3qssbai fda0:cbf4:b62a:ddb2:2299:935e:f79b:59b4/88,fc8a:1646:945e:f79b:59b4:0000:0000:0001/40,192.168.193.163/24
    200 listnetworks fff local f2:79:08:a9:5f:3e OK PRIVATE ztqu3hkioc fd83:048a:0632:ff27:f099:935e:f79b:59b4/88,fcb1:fbad:f65e:f79b:59b4:0000:0000:0001/40,10.147.17.163/24
    
install srelay on pi:

    git clone https://github.com/wynemo/srelay.git
    
    pi@raspberrypi:~/srelay $ git diff
    diff --git a/main.c b/main.c
    index 2221279..1b4ec67 100644
    --- a/main.c
    +++ b/main.c
    @@ -32,6 +32,7 @@ IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

     */

    +#include <sys/ioctl.h>
     #include <sys/stat.h>
     #include "srelay.h"

    diff --git a/srelay.conf b/srelay.conf
    index 24282b9..f532f6b 100644
    --- a/srelay.conf
    +++ b/srelay.conf
    @@ -1,23 +1,2 @@
    -#
    -#  srelay.conf
    -#  $Id$
    -#
    -#  dest[/mask]                 port    proxy           proxy-port
    -; intranet
    -172.16.1.0/24                  -       192.168.1.1
    -123.123.123.0/255.255.255.248  any     192.168.1.3
    -# some IPv6 destination should go through 10.1.1.1:1080
    -2001:111:1:21::/64             1024-   10.1.1.1
    -# some IPv6 ftp/ssh/telnet should go 2001::240:2ff:fe3e:b2 socks
    -::                             21-23   2001::240:2ff:fe3e:b2
    -# dest host matches c-wind.com should go host x:1080
    -c-wind.com                     -       x
    -# to reach the Intra subnet 10.1.1.0/25, first contact fw2:socks,
    -# then firewall:http-proxy,
    -# then 100.100.100.100:1111 socks.
    -10.1.1.0/25    any     100.100.100.100 1111    firewall 8080/H  fw2 1080
    -# other IPv4 destination will be reached through fiewall 8080 http-proxy,
    -# and test2 socks.
    -0.0.0.0                any     test    1080    firewall        8080/H
    -# rest of any FQDN (and IPv6) destination should go 192.168.1.5 socks.
    -*                              any     192.168.1.5     1080
    \ No newline at end of file
    +0.0.0.0      any 69.60.161.217    8118/h  127.0.0.1    2080
    +*            any 69.60.161.217    8118/h  127.0.0.1    2080

change configuration:

    $ ./configure
    $ vi config.sh
    /* Define if the build system is Linux */
    /* #undef LINUX */
    #define LINUX
    $ make
