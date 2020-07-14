#cloud-config
write_files:
-   content: |
      <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">

      <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
      <head>
        <title>Web-Server-${instance} on Oracle Cloud Infrastructure</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
      </head>
      <body>
        <div>This is my Web-Server-${instance} running on Oracle Cloud Infrastructure!</div>
      </body>
      </html>
    owner: opc:opc
    path: /home/opc/index.html
runcmd:
- yum install nginx -y
- cp /usr/share/nginx/html/index.html /usr/share/nginx/html/index.original.html
- cat /home/opc/index.html > /usr/share/nginx/html/index.html
- systemctl enable nginx
- nginx -T
- systemctl start nginx
- firewall-offline-cmd --add-port=80/tcp
- systemctl restart firewalld
