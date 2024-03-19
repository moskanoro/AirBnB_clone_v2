#!/usr/bin/env bash
# make ur web server works
dpkg -l | grep nginx > /dev/null 2>&1 || (sudo apt -y update && sudo apt -y upgrade && sudo apt -y install nginx)
ls /data/web_static/releases/test/ > /dev/null 2>&1 || sudo mkdir -p /data/web_static/releases/test/
ls /data/web_static/shared/ > /dev/null 2>&1 || sudo mkdir -p /data/web_static/shared/

echo -e "<html>\n\t<head>\n\t</head>\n\t<body>\n\t\tHolberton School\n\t</body>\n</html>" | sudo tee /data/web_static/releases/test/index.html

sudo ln -sf /data/web_static/releases/test/ /data/web_static/current

sudo chown -R ubuntu:ubuntu /data/

sudo sed -i '/server_name _;/a \\n\tlocation /hbnb_static {\n\t\talias /data/web_static/current;\n\t}\n' /etc/nginx/sites-available/default

sudo service nginx restart
