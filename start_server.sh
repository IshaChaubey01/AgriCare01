#!/bin/bash
echo "Starting AgriCare in production mode..."
source venv/bin/activate
export DJANGO_SETTINGS_MODULE=agricare.production_settings
echo "Creating logs directory if it doesn't exist..."
mkdir -p logs
echo "Installing Gunicorn if not already installed..."
pip install gunicorn whitenoise
echo "Collecting static files..."
python manage.py collectstatic --noinput --settings=agricare.production_settings
echo "Starting Gunicorn server..."
gunicorn agricare.wsgi:application --bind 0.0.0.0:8000 