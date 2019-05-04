python /home/pi/ping_route.py
if [ "$?" = "1" ]; then
        echo "fail"
        echo 'reboot now'
        /sbin/reboot
fi
