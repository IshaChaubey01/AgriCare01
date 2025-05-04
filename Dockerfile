FROM python:3.11-slim



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
    build-essential \
    python3-dev \
    libjpeg-dev \
    zlib1g-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt /app/
RUN pip install --upgrade pip
RUN  pip install -r requirements.txt

# Copy entrypoint script and set permissions
COPY entrypoint.sh /app/
RUN chmod +x /app/entrypoint.sh

# Copy project files
COPY . /app/



# Create logs directory
RUN mkdir -p logs

# Create a directory for static files
RUN mkdir -p staticfiles

# Collect static files (optional here, because it will also run via entrypoint)
RUN python manage.py collectstatic --noinput || true



# Set working directory again (just to be safe)
WORKDIR /app

# Run migrations by default when the container starts
# This is just for local testing - in real production, 
# you would want to run migrations separately
ENTRYPOINT ["/app/entrypoint.sh"]
 