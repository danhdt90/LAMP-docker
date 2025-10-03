# LAMP Docker Environment

Môi trường phát triển LAMP (Linux, Apache/Nginx, MySQL, PHP) sử dụng Docker với quản lý submodules linh hoạt.

## 🚀 Quick Start

```bash
# 1. Clone repository
git clone <repository-url>
cd LAMP-docker

# 2. Setup dynamic domains (requires sudo)
./manage-domains.sh setup

# 3. Start Docker services
docker compose up -d

# 4. Access your applications (auto-detected from src/ folders)
# ✅ http://php08.test - PHP Demo
# ✅ http://propolife-webs.test - Portfolio & Business Websites
# ✅ http://localhost:8081 - phpMyAdmin

# 5. Create new project instantly
mkdir src/my-project
echo "<h1>My Project</h1>" > src/my-project/index.html
./manage-domains.sh setup  # Add new domain to hosts
# ✅ http://my-project.test - Ready immediately!

# 6. Initialize submodules when needed
./manage-submodules.sh init propolife-webs
```

## 📁 Cấu trúc Project

```
LAMP-docker/
├── docker-compose.yml          # Docker services configuration
├── config/                     # Configuration files
│   ├── nginx/
│   └── php/
├── src/                        # Source code directory
│   ├── propolife-webs/        # WordPress Portfolio & Business Websites
│   └── php08/                 # PHP application
├── manage-submodules.sh        # Submodule management script
└── README.md
```

## 🔧 Services

- **Nginx**: Web server (port 8080)
- **PHP-FPM**: PHP 8.4 FastCGI Process Manager
- **MySQL**: Database server (MySQL 8.0)
- **phpMyAdmin**: Database management tool (port 8081)

## 📦 Quản lý Submodules

Project này sử dụng Git submodules để quản lý các component riêng biệt. Bạn có thể chọn chỉ tải những submodules cần thiết.

### Submodules có sẵn:
- `nhatansteel-src`: Backend application
- `nhatansteel-fe`: Frontend application

### 🛠️ Sử dụng Script Quản lý

#### Xem trạng thái submodules:
```bash
./manage-submodules.sh status
```

#### Tải submodule cụ thể:
```bash
# Chỉ tải backend
./manage-submodules.sh init nhatansteel-src

# Chỉ tải frontend  
./manage-submodules.sh init nhatansteel-fe

# Force clean và tải lại (nếu thư mục đã tồn tại)
./manage-submodules.sh clean-init nhatansteel-src
```

#### Cập nhật submodule:
```bash
# Cập nhật backend
./manage-submodules.sh pull nhatansteel-src

# Cập nhật frontend
./manage-submodules.sh pull nhatansteel-fe
```

#### Hủy bỏ submodule không cần thiết:
```bash
./manage-submodules.sh deinit nhatansteel-fe
```

#### Xem danh sách submodules:
```bash
./manage-submodules.sh list
```

### 🔄 Sử dụng Git Commands trực tiếp

#### Clone submodules có chọn lọc:
```bash
# Clone chỉ backend
git submodule update --init src/nhatansteel-src

# Clone chỉ frontend
git submodule update --init src/nhatansteel-fe

# Clone tất cả
git submodule update --init --recursive
```

#### Cập nhật submodules:
```bash
# Cập nhật submodule cụ thể
git submodule update --remote src/nhatansteel-src

# Cập nhật tất cả submodules
git submodule update --remote
```

#### Kiểm tra trạng thái:
```bash
git submodule status
```

### 💡 Tips

1. **Làm việc chỉ với Frontend:**
   ```bash
   ./manage-submodules.sh init nhatansteel-fe
   ./manage-submodules.sh deinit nhatansteel-src
   ```

2. **Làm việc chỉ với Backend:**
   ```bash
   ./manage-submodules.sh init nhatansteel-src
   ./manage-submodules.sh deinit nhatansteel-fe
   ```

3. **Full Development:**
   ```bash
   ./manage-submodules.sh init nhatansteel-src
   ./manage-submodules.sh init nhatansteel-fe
   ```

4. **Cập nhật định kỳ:**
   ```bash
   ./manage-submodules.sh pull nhatansteel-src
   ./manage-submodules.sh pull nhatansteel-fe
   ```

## 🌍 Quản lý Dynamic Domains

Project hỗ trợ **tự động tạo domains** dựa trên tên folder trong thư mục `src/`. Bạn chỉ cần tạo folder mới và domain sẽ tự động khả dụng!

### 🚀 Cách hoạt động:
- Tạo folder trong `src/` → Domain `{folder-name}.test` tự động sẵn sàng
- Ví dụ: `src/chinokanri` → `http://chinokanri.test`
- Ví dụ: `src/my-project` → `http://my-project.test`

### Available Domains:
Tự động phát hiện từ folders trong `src/`:
- `nhatansteel-src.test` → Backend application
- `nhatansteel-fe.test` → Frontend application  
- `php08.test` → PHP08 application
- `chinokanri.test` → ChiNo Management (demo)
- + Bất kỳ folder nào bạn tạo thêm!

### 🛠️ Sử dụng Script Quản lý Domains

#### Scan folders để xem domains có sẵn:
```bash
./manage-domains.sh scan
```

#### Setup tất cả domains tự động:
```bash
./manage-domains.sh setup
```

#### Kiểm tra trạng thái:
```bash
./manage-domains.sh status
```

#### List tất cả domains:
```bash
./manage-domains.sh list
```

#### Restart nginx:
```bash
./manage-domains.sh restart-nginx
```

#### Remove tất cả domains:
```bash
./manage-domains.sh remove
```

### 💡 Dynamic Domain Tips

1. **Tạo project mới:**
   ```bash
   mkdir src/my-new-project
   echo "<h1>My New Project</h1>" > src/my-new-project/index.html
   ./manage-domains.sh setup  # Thêm domain vào hosts
   # Truy cập: http://my-new-project.test
   ```

2. **Không cần restart nginx:**
   - Nginx tự động handle domains mới
   - Chỉ cần thêm vào `/etc/hosts`

3. **Multiple projects dễ dàng:**
   - Mỗi project có domain riêng
   - Không conflict giữa các project
   - Dễ switch giữa projects

4. **Development workflow:**
   ```bash
   # Tạo project mới
   mkdir src/awesome-app
   
   # Setup domain
   ./manage-domains.sh setup
   
   # Code và test ngay
   # http://awesome-app.test
   ```

### 🏗️ Nginx Configuration

Nginx được cấu hình để tự động handle tất cả domains `.test`:
- Sử dụng regex pattern: `~^(?<folder_name>.+)\.test$`
- Document root: `/usr/share/nginx/html/$folder_name`
- Logs riêng cho từng domain: `/tmp/${folder_name}_access.log`

## 🐳 Docker Commands

### Khởi động services:
```bash
docker-compose up -d
```

### Dừng services:
```bash
docker-compose down
```

### Xem logs:
```bash
docker-compose logs -f
```

### Rebuild containers:
```bash
docker-compose up -d --build
```

## 🌐 Access URLs

### Custom Domains (Recommended):
- **Backend Application**: http://nhatansteel-src.test
- **Frontend Application**: http://nhatansteel-fe.test  
- **PHP08 Application**: http://php08.test
- **phpMyAdmin**: http://localhost:8081

### Alternative Localhost URLs:
- **Web Application**: http://localhost:8080 or http://localhost
- **phpMyAdmin**: http://localhost:8081

### 🔧 Setup Custom Domains

#### Automatic Setup (Recommended):
```bash
# Setup all custom domains
./manage-domains.sh setup

# Check domain status
./manage-domains.sh status

# Restart nginx after changes
./manage-domains.sh restart-nginx
```

#### Manual Setup:
Add these lines to your `/etc/hosts` file:
```
127.0.0.1    nhatansteel-src.test
127.0.0.1    nhatansteel-fe.test
127.0.0.1    php08.test
```

#### Remove Custom Domains:
```bash
./manage-domains.sh remove
```

## 📊 Database Info

- **Host**: localhost (from host machine) / db (from containers)
- **Port**: 3306
- **Database**: nhatansteel
- **Username**: exampleuser
- **Password**: examplepass

## 🔧 Development Workflow

1. **Setup môi trường:**
   ```bash
   git clone <repository-url>
   cd LAMP-docker
   ```

2. **Cấu hình custom domains:**
   ```bash
   ./manage-domains.sh setup
   ```

3. **Chọn submodules cần thiết:**
   ```bash
   ./manage-submodules.sh init nhatansteel-src
   # hoặc
   ./manage-submodules.sh init nhatansteel-fe
   ```

4. **Khởi động Docker:**
   ```bash
   docker-compose up -d
   ```

5. **Truy cập applications:**
   - Backend: http://nhatansteel-src.test
   - Frontend: http://nhatansteel-fe.test
   - PHP08: http://php08.test

6. **Phát triển và cập nhật:**
   ```bash
   ./manage-submodules.sh pull nhatansteel-src
   ./manage-domains.sh restart-nginx  # Nếu cần restart nginx
   ```

## 🤝 Team Collaboration

### Clone project lần đầu:
```bash
git clone <repository-url>
cd LAMP-docker
# Không cần clone tất cả submodules ngay
```

### Khi cần làm việc với component cụ thể:
```bash
./manage-submodules.sh init <component-name>
```

### Chia sẻ changes:
```bash
# Commit changes trong submodule
cd src/nhatansteel-src
git add .
git commit -m "Update feature"
git push

# Cập nhật reference trong main project
cd ../..
git add src/nhatansteel-src
git commit -m "Update nhatansteel-src submodule"
git push
```

## 🚨 Lưu ý quan trọng

- ⚠️ Luôn commit và push changes trong submodule trước khi cập nhật reference trong main project
- ⚠️ Sử dụng `./manage-submodules.sh deinit` cẩn thận vì sẽ xóa local changes chưa commit
- ⚠️ Khi làm việc nhóm, thông báo cho team khi cập nhật submodule references

## 📝 Troubleshooting

### Submodule bị stuck ở trạng thái cũ:
```bash
./manage-submodules.sh pull <submodule-name>
```

### Reset submodule về trạng thái clean:
```bash
./manage-submodules.sh deinit <submodule-name>
./manage-submodules.sh init <submodule-name>
```

### Lỗi "directory already exists and is not empty":
```bash
# Sử dụng clean-init để xóa thư mục hiện tại và initialize lại
./manage-submodules.sh clean-init <submodule-name>

# Hoặc sử dụng init với backup tự động (an toàn hơn)
./manage-submodules.sh init <submodule-name>
```

### Domain không hoạt động:
```bash
# Kiểm tra domain configuration
./manage-domains.sh status

# Restart nginx nếu cần
./manage-domains.sh restart-nginx

# Kiểm tra Docker services
docker compose ps
```

### Kiểm tra conflicts:
```bash
git submodule status
git status
```

## 🗄️ Database Import Issues

### Lỗi import database lớn:
Nếu gặp lỗi khi import database có kích thước > 2MB:
```
Warning: POST Content-Length exceeds the limit
Error during session start
Cannot modify header information - headers already sent
```

**Giải pháp:**
1. **Cấu hình đã được tối ưu** cho import file lớn (lên đến 1GB)
2. **Restart containers** nếu cần:
   ```bash
   docker compose restart php phpmyadmin
   ```

3. **Import qua command line** cho file rất lớn:
   ```bash
   # Copy file vào container
   docker cp your_database.sql lamp-docker-db-1:/tmp/
   
   # Import trực tiếp
   docker compose exec db mysql -u root -p'passrootDanh123@' your_db < /tmp/your_database.sql
   ```

4. **Kiểm tra cấu hình PHP**:
   ```bash
   docker compose exec php php -i | grep -E "(upload_max_filesize|post_max_size|memory_limit)"
   ```

📋 **Chi tiết xem tại:** [DATABASE_IMPORT_GUIDE.md](DATABASE_IMPORT_GUIDE.md)