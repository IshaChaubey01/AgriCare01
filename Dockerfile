FROM python:3.8-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV DJANGO_SETTINGS_MODULE=agricare.docker_settings

# Create directory for the app
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    default-libmysqlclient-dev \
    pkg-config \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt /app/
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# Copy project files
COPY . /app/

# Create logs directory
RUN mkdir -p logs

# Create a directory for static files
RUN mkdir -p staticfiles

# Collect static files
RUN python manage.py collectstatic --noinput

# Run migrations by default when the container starts
# This is just for local testing - in real production, 
# you would want to run migrations separately
CMD python manage.py migrate --noinput && \
    gunicorn agricare.wsgi:application --bind 0.0.0.0:8000 