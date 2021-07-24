
if [ "$1" == "ON" ]; then
    cp /tmp/nginx-conf_on /etc/nginx/sites-available/flow
elif [ "$1" == "OFF" ]; then
    cp /tmp/nginx-conf_off /etc/nginx/sites-available/flow
fi

service nginx restart;