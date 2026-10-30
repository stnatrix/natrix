# stnatrix.space Portfolio Website Architecture

## Overview
- **Domain**: `stnatrix.space`, `www.stnatrix.space`
- **DNS**: Cloudflare proxy enabled (A record pointing to VPS Frankfurt)
- **Local Directory**: `C:\Users\stnatrix\Documents\antigravity\vps\sites\stnatrix-space`
- **VPS Root**: `/var/www/sites/stnatrix`
- **Web Server**: Nginx (`/etc/nginx/sites-available/stnatrix.conf` -> `/etc/nginx/sites-enabled/stnatrix.conf`)
- **Repository**: [stnatrix/natrix](https://github.com/stnatrix/natrix)
- **Projects Highlighted**:
  - `toolstrix`: [tools.stnatrix.space](https://tools.stnatrix.space) | [stnatrix/toolstrix](https://github.com/stnatrix/toolstrix)
  - `ahktrix`: [ahk.stnatrix.space](https://ahk.stnatrix.space) | [stnatrix/ahktrix](https://github.com/stnatrix/ahktrix)
  - Profile: [@stnatrix](https://github.com/stnatrix)
- **Design System**: 1:1 match with toolstrix and ahktrix (compact 480px card, dark palette `#141312` / `#1d1b19`, Nunito typography, Web Audio SFX click synthesizer).

## Nginx Virtual Host
```nginx
server {
    listen 80;
    listen [::]:80;
    server_name stnatrix.space www.stnatrix.space;

    root /var/www/sites/stnatrix;
    index index.html;

    gzip on;
    gzip_vary on;
    gzip_min_length 1024;
    gzip_proxied any;
    gzip_types
        text/plain
        text/css
        text/javascript
        application/javascript
        application/json
        image/svg+xml
        font/ttf
        font/woff
        font/woff2;

    location / {
        try_files $uri $uri/ /index.html =404;
    }

    location ~* \.(?:css|js|svg|png|jpg|jpeg|gif|ico|webp|woff|woff2|ttf)$ {
        expires 7d;
        try_files $uri =404;
    }

    add_header X-Content-Type-Options nosniff always;
    add_header X-Frame-Options SAMEORIGIN always;
    add_header Referrer-Policy strict-origin-when-cross-origin always;
}
```

## Deployment
Run `deploy.ps1` from PowerShell to synchronize static files and apply Nginx virtual host configuration on `ssh vps`.
