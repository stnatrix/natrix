$ErrorActionPreference = "Stop"

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

ssh vps "mkdir -p /tmp/stnatrix_web /tmp/stnatrix_web/css /tmp/stnatrix_web/js /tmp/stnatrix_web/fonts/nunito"
scp "$scriptDir\index.html" "vps:/tmp/stnatrix_web/index.html"
scp "$scriptDir\css\main.css" "vps:/tmp/stnatrix_web/css/main.css"
scp "$scriptDir\js\app.js" "vps:/tmp/stnatrix_web/js/app.js"
scp "$scriptDir\js\sfx.js" "vps:/tmp/stnatrix_web/js/sfx.js"
scp "$scriptDir\fonts\nunito\*" "vps:/tmp/stnatrix_web/fonts/nunito/"
scp "$scriptDir\stnatrix.conf" "vps:/etc/nginx/sites-available/stnatrix.conf"

ssh vps "mkdir -p /var/www/sites/stnatrix && cp -r /tmp/stnatrix_web/* /var/www/sites/stnatrix/ && rm -rf /tmp/stnatrix_web && chown -R www-data:www-data /var/www/sites/stnatrix && chmod -R 755 /var/www/sites/stnatrix && ln -sf /etc/nginx/sites-available/stnatrix.conf /etc/nginx/sites-enabled/stnatrix.conf && nginx -t && systemctl reload nginx"

Write-Host "Deployment completed successfully."
