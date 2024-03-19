# puppet to config the server
exec { 'apt-get-update':
  command => '/usr/bin/apt -y update',
}
package { 'nginx':
  ensure => installed,
}
exec { '/data/web_static/releases/test/':
  command => '/usr/bin/mkdir -p /data/web_static/releases/test/',
}
exec { '/data/web_static/shared/':
  command => '/usr/bin/mkdir -p /data/web_static/shared/',
}
exec { '/data/web_static/releases/test/index.html':
  command => '/usr/bin/echo -e "<html>\n\t<head>\n\t</head>\n\t<body>\n\t\tHolberton School\n\t</body>\n</html>" | sudo /usr/bin/tee /data/web_static/releases/test/index.html',
}
exec { 'update server':
  command => '/usr/bin/ln -sf /data/web_static/releases/test/ /data/web_static/current',
}
exec { 'chown -R ubuntu:ubuntu /data':
  command => '/usr/bin/chown -R ubuntu:ubuntu /data/',
}
exec { '/etc/nginx/sites-available/default':
  command => 'sudo sed -i "/^server {/a \ \n\tlocation \/hbnb_static {alias /data/web_static/current/;index index.html;}" /etc/nginx/sites-enabled/default',
  provider => shell,
}
exec { 'start-nginx':
  command => '/usr/bin/service nginx restart',
}
