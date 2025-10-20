# 📋 Panduan Deployment Klinik Bungas ke Server Ubuntu 24 dengan aaPanel

## 🎯 Overview
Panduan ini akan membantu Anda melakukan deployment aplikasi **Klinik Bungas** ke server Ubuntu 24.04 LTS menggunakan aaPanel sebagai control panel dengan domain `klinikbungas.com`.

## 📋 Persyaratan Sistem

### Server Requirements
- **OS**: Ubuntu 24.04 LTS
- **RAM**: Minimal 2GB (Rekomendasi 4GB+)
- **Storage**: Minimal 20GB SSD
- **CPU**: 2 Core (Rekomendasi 4 Core+)
- **Domain**: klinikbungas.com (sudah pointing ke server)

### Software Requirements
- **PHP**: 8.2+
- **Node.js**: 18+ (LTS)
- **MySQL**: 8.0+
- **Nginx**: Latest
- **Composer**: Latest
- **Git**: Latest

---

## 🚀 Langkah 1: Persiapan Server Ubuntu 24

### 1.1 Update System
```bash
sudo apt update && sudo apt upgrade -y
sudo apt install curl wget git unzip -y
```

### 1.2 Install aaPanel
```bash
# Download dan install aaPanel
wget -O install.sh http://www.aapanel.com/script/install-ubuntu_6.0_en.sh
sudo bash install.sh aapanel
```

**Catatan**: Setelah instalasi selesai, catat URL, username, dan password yang diberikan.

### 1.3 Konfigurasi Firewall
```bash
# Buka port yang diperlukan
sudo ufw allow 22    # SSH
sudo ufw allow 80    # HTTP
sudo ufw allow 443   # HTTPS
sudo ufw allow 8888  # aaPanel
sudo ufw enable
```

---

## 🔧 Langkah 2: Konfigurasi aaPanel

### 2.1 Login ke aaPanel
1. Akses `http://your-server-ip:8888`
2. Login dengan kredensial yang diberikan saat instalasi
3. Pilih bahasa Indonesia (opsional)

### 2.2 Install LNMP Stack
1. Masuk ke **App Store** → **Runtime Environment**
2. Install komponen berikut:
   - **Nginx** (Latest)
   - **MySQL** 8.0
   - **PHP** 8.2
   - **phpMyAdmin** (Latest)

### 2.3 Install PHP Extensions
Masuk ke **PHP** → **Extensions** dan install:
- `fileinfo`
- `openssl`
- `pdo`
- `mbstring`
- `tokenizer`
- `xml`
- `ctype`
- `json`
- `bcmath`
- `zip`
- `gd`
- `curl`

### 2.4 Install Node.js
```bash
# Install Node.js 18 LTS
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

# Verify installation
node --version
npm --version
```

### 2.5 Install Composer
```bash
# Download dan install Composer
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
sudo chmod +x /usr/local/bin/composer

# Verify installation
composer --version
```

---

## 🌐 Langkah 3: Setup Domain dan SSL

### 3.1 Tambah Website
1. Masuk ke **Website** → **Add Site**
2. Isi form:
   - **Domain**: `klinikbungas.com`
   - **Document Root**: `/www/wwwroot/klinikbungas.com`
   - **PHP Version**: 8.2
3. Klik **Submit**

### 3.2 Setup SSL Certificate
1. Masuk ke **Website** → pilih domain → **SSL**
2. Pilih **Let's Encrypt** (gratis)
3. Centang **Force HTTPS**
4. Klik **Apply**

---

## 📁 Langkah 4: Deploy Aplikasi

### 4.1 Clone Repository
```bash
# Masuk ke direktori website
cd /www/wwwroot/klinikbungas.com

# Backup folder default (jika ada)
sudo mv * ../backup/ 2>/dev/null || true

# Clone repository (ganti dengan URL repository Anda)
sudo git clone https://github.com/your-username/klinikbungas.git .

# Set ownership
sudo chown -R www-data:www-data /www/wwwroot/klinikbungas.com
sudo chmod -R 755 /www/wwwroot/klinikbungas.com
```

### 4.2 Install Dependencies
```bash
# Install PHP dependencies
sudo -u www-data composer install --optimize-autoloader --no-dev

# Install Node.js dependencies
sudo -u www-data npm install

# Build assets
sudo -u www-data npm run build
```

### 4.3 Setup Environment
```bash
# Copy environment file
sudo -u www-data cp .env.example .env

# Generate application key
sudo -u www-data php artisan key:generate
```

---

## 🗄️ Langkah 5: Setup Database

### 5.1 Buat Database MySQL
1. Masuk ke **Database** di aaPanel
2. Klik **Add Database**
3. Isi form:
   - **Database Name**: `klinikbungas_db`
   - **Username**: `klinikbungas_user`
   - **Password**: `[password_yang_kuat]`
4. Klik **Submit**

### 5.2 Konfigurasi Database di .env
```bash
sudo nano /www/wwwroot/klinikbungas.com/.env
```

Update konfigurasi database:
```env
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=klinikbungas_db
DB_USERNAME=klinikbungas_user
DB_PASSWORD=[password_yang_dibuat]
```

### 5.3 Import Database (Jika Ada)
```bash
# Jika ada file SQL backup
mysql -u klinikbungas_user -p klinikbungas_db < database/sql/kbungas.sql
```

### 5.4 Run Migrations
```bash
sudo -u www-data php artisan migrate --force
sudo -u www-data php artisan db:seed --force
```

---

## ⚙️ Langkah 6: Konfigurasi Environment Production

### 6.1 Update .env untuk Production
```env
APP_NAME="Klinik Bungas"
APP_ENV=production
APP_DEBUG=false
APP_URL=https://klinikbungas.com

# Database (sudah dikonfigurasi sebelumnya)
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=klinikbungas_db
DB_USERNAME=klinikbungas_user
DB_PASSWORD=[your_password]

# Cache & Session
CACHE_STORE=file
SESSION_DRIVER=file
QUEUE_CONNECTION=database

# Mail Configuration (sesuaikan dengan provider Anda)
MAIL_MAILER=smtp
MAIL_HOST=smtp.gmail.com
MAIL_PORT=587
MAIL_USERNAME=your-email@gmail.com
MAIL_PASSWORD=your-app-password
MAIL_ENCRYPTION=tls
MAIL_FROM_ADDRESS=noreply@klinikbungas.com
MAIL_FROM_NAME="Klinik Bungas"

# WhatsApp API (jika menggunakan)
WHATSAPP_API_URL=your-whatsapp-api-url
WHATSAPP_API_TOKEN=your-whatsapp-token

# BPJS Configuration (jika menggunakan)
BPJS_CONS_ID=your-bpjs-cons-id
BPJS_SECRET_KEY=your-bpjs-secret-key
BPJS_BASE_URL=https://apijkn-dev.bpjs-kesehatan.go.id
```

### 6.2 Optimize Application
```bash
# Clear dan cache konfigurasi
sudo -u www-data php artisan config:clear
sudo -u www-data php artisan config:cache

# Cache routes
sudo -u www-data php artisan route:cache

# Cache views
sudo -u www-data php artisan view:cache

# Optimize autoloader
sudo -u www-data composer dump-autoload --optimize
```

---

## 🔧 Langkah 7: Konfigurasi Nginx

### 7.1 Update Nginx Configuration
Masuk ke **Website** → pilih domain → **Conf** dan update dengan:

```nginx
server {
    listen 80;
    listen 443 ssl http2;
    server_name klinikbungas.com www.klinikbungas.com;
    root /www/wwwroot/klinikbungas.com/public;
    index index.php index.html;
    
    # SSL Configuration (akan diatur otomatis oleh aaPanel)
    
    # Security Headers
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-XSS-Protection "1; mode=block" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header Referrer-Policy "no-referrer-when-downgrade" always;
    add_header Content-Security-Policy "default-src 'self' http: https: data: blob: 'unsafe-inline'" always;
    
    # Gzip Compression
    gzip on;
    gzip_vary on;
    gzip_min_length 1024;
    gzip_proxied expired no-cache no-store private must-revalidate auth;
    gzip_types text/plain text/css text/xml text/javascript application/x-javascript application/xml+rss application/javascript;
    
    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }
    
    location ~ \.php$ {
        fastcgi_pass unix:/tmp/php-cgi-82.sock;
        fastcgi_index index.php;
        include fastcgi.conf;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_intercept_errors off;
        fastcgi_buffer_size 16k;
        fastcgi_buffers 4 16k;
        fastcgi_connect_timeout 300;
        fastcgi_send_timeout 300;
        fastcgi_read_timeout 300;
    }
    
    # Static files caching
    location ~* \.(jpg|jpeg|png|gif|ico|css|js|pdf|txt)$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }
    
    # Deny access to sensitive files
    location ~ /\. {
        deny all;
    }
    
    location ~ /(storage|bootstrap/cache) {
        deny all;
    }
}
```

### 7.2 Test dan Reload Nginx
```bash
sudo nginx -t
sudo systemctl reload nginx
```

---

## 🔐 Langkah 8: Setup Permissions dan Security

### 8.1 Set Correct Permissions
```bash
# Set ownership
sudo chown -R www-data:www-data /www/wwwroot/klinikbungas.com

# Set directory permissions
sudo find /www/wwwroot/klinikbungas.com -type d -exec chmod 755 {} \;

# Set file permissions
sudo find /www/wwwroot/klinikbungas.com -type f -exec chmod 644 {} \;

# Set storage and cache permissions
sudo chmod -R 775 /www/wwwroot/klinikbungas.com/storage
sudo chmod -R 775 /www/wwwroot/klinikbungas.com/bootstrap/cache
```

### 8.2 Setup Cron Jobs
```bash
# Edit crontab untuk www-data user
sudo crontab -u www-data -e

# Tambahkan baris berikut:
* * * * * cd /www/wwwroot/klinikbungas.com && php artisan schedule:run >> /dev/null 2>&1
```

### 8.3 Setup Queue Worker (Opsional)
```bash
# Buat systemd service untuk queue worker
sudo nano /etc/systemd/system/klinikbungas-worker.service
```

Isi dengan:
```ini
[Unit]
Description=Klinik Bungas Queue Worker
After=network.target

[Service]
User=www-data
Group=www-data
Restart=always
ExecStart=/usr/bin/php /www/wwwroot/klinikbungas.com/artisan queue:work --sleep=3 --tries=3 --max-time=3600
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=multi-user.target
```

```bash
# Enable dan start service
sudo systemctl enable klinikbungas-worker
sudo systemctl start klinikbungas-worker
```

---

## 🧪 Langkah 9: Testing dan Verifikasi

### 9.1 Test Website
1. Akses `https://klinikbungas.com`
2. Pastikan halaman loading dengan benar
3. Test fitur-fitur utama:
   - Landing page
   - Booking system
   - Review system
   - Admin panel (jika ada)

### 9.2 Check Logs
```bash
# Laravel logs
sudo tail -f /www/wwwroot/klinikbungas.com/storage/logs/laravel.log

# Nginx logs
sudo tail -f /var/log/nginx/klinikbungas.com.error.log
sudo tail -f /var/log/nginx/klinikbungas.com.access.log

# PHP logs
sudo tail -f /www/server/php/82/var/log/php-fpm.log
```

### 9.3 Performance Check
```bash
# Check PHP-FPM status
sudo systemctl status php-fpm-82

# Check MySQL status
sudo systemctl status mysql

# Check Nginx status
sudo systemctl status nginx

# Check disk usage
df -h

# Check memory usage
free -h
```

---

## 🔄 Langkah 10: Setup Backup Otomatis

### 10.1 Database Backup Script
```bash
# Buat script backup
sudo nano /root/backup-klinikbungas.sh
```

Isi dengan:
```bash
#!/bin/bash
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="/root/backups"
DB_NAME="klinikbungas_db"
DB_USER="klinikbungas_user"
DB_PASS="[your_password]"

# Create backup directory
mkdir -p $BACKUP_DIR

# Database backup
mysqldump -u $DB_USER -p$DB_PASS $DB_NAME > $BACKUP_DIR/db_backup_$DATE.sql

# Files backup
tar -czf $BACKUP_DIR/files_backup_$DATE.tar.gz /www/wwwroot/klinikbungas.com

# Keep only last 7 days of backups
find $BACKUP_DIR -name "*.sql" -mtime +7 -delete
find $BACKUP_DIR -name "*.tar.gz" -mtime +7 -delete

echo "Backup completed: $DATE"
```

```bash
# Set permissions
sudo chmod +x /root/backup-klinikbungas.sh

# Add to crontab (backup setiap hari jam 2 pagi)
sudo crontab -e
# Tambahkan:
0 2 * * * /root/backup-klinikbungas.sh >> /var/log/backup.log 2>&1
```

---

## 🚨 Troubleshooting

### Common Issues

#### 1. 500 Internal Server Error
```bash
# Check Laravel logs
sudo tail -f /www/wwwroot/klinikbungas.com/storage/logs/laravel.log

# Check permissions
sudo chown -R www-data:www-data /www/wwwroot/klinikbungas.com
sudo chmod -R 775 storage bootstrap/cache
```

#### 2. Database Connection Error
```bash
# Test database connection
mysql -u klinikbungas_user -p klinikbungas_db

# Check .env configuration
sudo nano /www/wwwroot/klinikbungas.com/.env
```

#### 3. Assets Not Loading
```bash
# Rebuild assets
cd /www/wwwroot/klinikbungas.com
sudo -u www-data npm run build

# Clear cache
sudo -u www-data php artisan cache:clear
sudo -u www-data php artisan config:clear
```

#### 4. SSL Certificate Issues
1. Masuk ke aaPanel → Website → SSL
2. Renew certificate
3. Check domain DNS pointing

### Performance Optimization

#### 1. Enable OPcache
```bash
# Edit PHP configuration
sudo nano /www/server/php/82/etc/php.ini

# Add/uncomment:
opcache.enable=1
opcache.memory_consumption=128
opcache.interned_strings_buffer=8
opcache.max_accelerated_files=4000
opcache.revalidate_freq=2
opcache.fast_shutdown=1
```

#### 2. MySQL Optimization
```bash
# Edit MySQL configuration
sudo nano /etc/mysql/mysql.conf.d/mysqld.cnf

# Add optimizations:
innodb_buffer_pool_size = 1G
innodb_log_file_size = 256M
query_cache_type = 1
query_cache_size = 64M
```

---

## 📞 Support dan Maintenance

### Regular Maintenance Tasks
1. **Weekly**: Check logs dan performance
2. **Monthly**: Update system packages
3. **Quarterly**: Review security settings
4. **Yearly**: Renew SSL certificates (otomatis dengan Let's Encrypt)

### Update Application
```bash
# Pull latest changes
cd /www/wwwroot/klinikbungas.com
sudo -u www-data git pull origin main

# Update dependencies
sudo -u www-data composer install --optimize-autoloader --no-dev
sudo -u www-data npm install
sudo -u www-data npm run build

# Run migrations
sudo -u www-data php artisan migrate --force

# Clear cache
sudo -u www-data php artisan config:cache
sudo -u www-data php artisan route:cache
sudo -u www-data php artisan view:cache
```

### Monitoring
- **Uptime**: Setup monitoring dengan UptimeRobot atau Pingdom
- **Performance**: Monitor dengan Google PageSpeed Insights
- **Security**: Regular security scans dengan tools seperti Sucuri

---

## ✅ Checklist Deployment

- [ ] Server Ubuntu 24 siap dan terupdate
- [ ] aaPanel terinstall dan terkonfigurasi
- [ ] LNMP stack terinstall (Nginx, MySQL, PHP 8.2)
- [ ] Node.js dan Composer terinstall
- [ ] Domain pointing ke server
- [ ] SSL certificate aktif
- [ ] Repository di-clone ke server
- [ ] Dependencies terinstall (Composer & NPM)
- [ ] Environment file dikonfigurasi
- [ ] Database dibuat dan migrasi dijalankan
- [ ] Permissions dan ownership diset dengan benar
- [ ] Nginx configuration diupdate
- [ ] Cron jobs disetup
- [ ] Backup script dibuat dan dijadwalkan
- [ ] Website dapat diakses dan berfungsi normal
- [ ] Performance optimization diterapkan

---

**🎉 Selamat! Aplikasi Klinik Bungas sudah berhasil di-deploy ke server production.**

Untuk pertanyaan atau bantuan lebih lanjut, silakan hubungi tim development.