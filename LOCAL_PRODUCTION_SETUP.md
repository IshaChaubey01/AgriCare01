# AgriCare Local Production Setup Guide
## Django + MySQL Configuration

This guide will help you set up the AgriCare application in a production-like environment on your local machine.

## Prerequisites

- Python 3.8+ installed
- MySQL Server installed and running
- Git (optional, for cloning the repository)
- Basic understanding of command line operations

## Step 1: Set up the Database

1. Open MySQL command line client or use a GUI like MySQL Workbench
2. Create a new database for AgriCare:

```sql
CREATE DATABASE agricare_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
``` 

3. Create a dedicated MySQL user for the application:

```sql
CREATE USER 'agricare_user'@'localhost' IDENTIFIED BY 'your_secure_password';
GRANT ALL PRIVILEGES ON agricare_db.* TO 'agricare_user'@'localhost';
FLUSH PRIVILEGES;
```

Replace `'your_secure_password'` with a strong password.

## Step 2: Set up the Python Environment

1. Clone or download the AgriCare project:

```bash
git clone https://github.com/yourusername/AgriCare01.git     
cd AgriCare01
```

2. Create and activate a virtual environment:

```bash
# Windows
python -m venv venv
venv\Scripts\activate

# Linux/macOS
python3 -m venv venv
source venv/bin/activate
```

3. Install the required dependencies:

```bash
pip install -r requirements.txt
```

## Step 3: Configure Production Settings

1. Create a new file called `production_settings.py` in the `agricare` folder:

```python
from .settings import *

# Turn off debug mode
DEBUG = False

# Set allowed hosts - replace with your domain or IP
ALLOWED_HOSTS = ['localhost', '127.0.0.1', 'your-domain.com']

# Configure MySQL database
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'agricare_db',
        'USER': 'agricare_user',
        'PASSWORD': 'your_secure_password',  # Use the password you created in Step 1
        'HOST': 'localhost',
        'PORT': '3306',
        'OPTIONS': {
            'init_command': "SET sql_mode='STRICT_TRANS_TABLES'",
            'charset': 'utf8mb4',
        },
    }
}

# Set secret key from environment variable or use a specific secure key
import os
SECRET_KEY = os.environ.get('DJANGO_SECRET_KEY', 'your-secure-secret-key-here')

# Configure static files
STATIC_ROOT = os.path.join(BASE_DIR, 'staticfiles')
STATIC_URL = '/static/'

# Configure media files
MEDIA_ROOT = os.path.join(BASE_DIR, 'media')
MEDIA_URL = '/media/'

# Configure HTTPS settings
SECURE_SSL_REDIRECT = False  # Set to True if using HTTPS
SESSION_COOKIE_SECURE = False  # Set to True if using HTTPS
CSRF_COOKIE_SECURE = False  # Set to True if using HTTPS

# Additional security settings
SECURE_HSTS_SECONDS = 0  # Set to non-zero value if using HTTPS
SECURE_HSTS_INCLUDE_SUBDOMAINS = False  # Set to True if using HTTPS
SECURE_HSTS_PRELOAD = False  # Set to True if using HTTPS
```

## Step 4: Set up the Production Environment

1. Install production-ready WSGI server:

```bash
pip install gunicorn whitenoise
```

2. Add Whitenoise to middleware in your production settings:

```python
# Add to production_settings.py
MIDDLEWARE.insert(1, 'whitenoise.middleware.WhiteNoiseMiddleware')

# Configure WhiteNoise
STATICFILES_STORAGE = 'whitenoise.storage.CompressedManifestStaticFilesStorage'
```

## Step 5: Run Database Migrations

1. Apply migrations:

```bash
python manage.py migrate --settings=agricare.production_settings
```

2. Create a superuser:

```bash
python manage.py createsuperuser --settings=agricare.production_settings
```

## Step 6: Collect Static Files

```bash
python manage.py collectstatic --settings=agricare.production_settings
```

## Step 7: Run the Application with Gunicorn

Create a `start_server.bat` (Windows) or `start_server.sh` (Linux/macOS) file:

For Windows (`start_server.bat`):
```batch
@echo off
call venv\Scripts\activate
set DJANGO_SETTINGS_MODULE=agricare.production_settings
gunicorn agricare.wsgi:application --bind 0.0.0.0:8000
```

For Linux/macOS (`start_server.sh`):
```bash
#!/bin/bash
source venv/bin/activate
export DJANGO_SETTINGS_MODULE=agricare.production_settings
gunicorn agricare.wsgi:application --bind 0.0.0.0:8000
```

Make the script executable (Linux/macOS only):
```bash
chmod +x start_server.sh
```

## Step 8: Run the Server

```bash
# Windows
start_server.bat

# Linux/macOS
./start_server.sh
```

## Step 9: Access Your Application

The application should now be running at http://localhost:8000

## Troubleshooting

### Database Connection Issues

If you experience connection issues with MySQL:

1. Check if MySQL service is running
2. Verify the credentials in your settings file
3. Ensure the user has necessary privileges
4. Check if the database name is correct

### Static Files Not Loading

If static files aren't loading properly:

1. Run collectstatic again
2. Check the STATIC_ROOT and STATIC_URL settings
3. Ensure WhiteNoise middleware is correctly configured

### Server Not Starting

If Gunicorn doesn't start:

1. Check if the virtual environment is activated
2. Ensure Gunicorn is installed
3. Check for syntax errors in the settings files

## Next Steps

1. Configure a proper reverse proxy (Nginx/Apache)
2. Set up SSL/TLS certificates for HTTPS
3. Configure proper backup strategy for database
4. Set up monitoring for the application

## Resources

- [Django Deployment Checklist](https://docs.djangoproject.com/en/5.2/howto/deployment/checklist/)
- [Gunicorn Documentation](https://docs.gunicorn.org/en/stable/)
- [MySQL Documentation](https://dev.mysql.com/doc/) 

## 1. Development Mode

```
python manage.py runserver
```

This starts Django's development server on http://127.0.0.1:8000/ 

## 2. Docker Mode

```
docker-compose up -d
```

This starts:
- Web application: http://localhost:8000
- PHPMyAdmin: http://localhost:8080 (login with user: agricare_user, password: your_secure_password)

To view logs: `docker-compose logs`
To stop: `docker-compose down` 