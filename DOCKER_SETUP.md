# AgriCare Docker Setup Guide

This guide provides instructions for running the AgriCare application using Docker and Docker Compose, making deployment easier and more consistent across different environments.

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/) installed
- [Docker Compose](https://docs.docker.com/compose/install/) installed
- Basic understanding of Docker and containers

## Project Structure

The Docker setup consists of the following components:

- `Dockerfile`: Defines the container image for the Django application
- `docker-compose.yml`: Orchestrates the services (web, database, phpmyadmin)
- `agricare/docker_settings.py`: Django settings specifically for Docker deployment

## Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/AgriCare01.git
cd AgriCare01
```

### 2. Configure Environment Variables (Optional)

You can modify the environment variables in the `docker-compose.yml` file for:

- Database credentials
- Django secret key
- Other application-specific configurations

### 3. Build and Start the Containers

```bash
docker-compose up -d
```

This command will:
- Build the web application image
- Start the MySQL database service
- Start the web application service
- Start the PHPMyAdmin service for database management

### 4. Create a Superuser

```bash
docker-compose exec web python manage.py createsuperuser
```

### 5. Access the Application

- Web application: http://localhost:8000
- PHPMyAdmin (database management): http://localhost:8080
  - Server: db
  - Username: agricare_user (or root)
  - Password: from the docker-compose.yml file

## Common Docker Commands

### View Running Containers

```bash
docker-compose ps
```

### View Container Logs

```bash
# All logs
docker-compose logs

# Specific service logs
docker-compose logs web
docker-compose logs db
```

### Stop the Containers

```bash
docker-compose down
```

### Remove Volumes (When You Want to Reset the Database)

```bash
docker-compose down -v
```

## Configuration Details

### Database Configuration

The MySQL database service is configured with:
- UTF-8 character encoding
- Persistent storage using Docker volumes
- Health check for dependency management

### Web Server Configuration

The Django application uses:
- Gunicorn as the WSGI server
- WhiteNoise for static file serving
- Environment variables for configuration

## Customizing the Setup

### Changing the Database Password

1. Update the password in `docker-compose.yml` under the db service
2. Restart the containers with `docker-compose down && docker-compose up -d`

### Adding Custom Environment Variables

1. Add your variables to the `environment` section in the web service in `docker-compose.yml`
2. Access them in your code using `os.environ.get('VARIABLE_NAME')`

### Production Deployment Considerations

For actual production deployment, consider:

1. Using a proper reverse proxy (Nginx) in front of Gunicorn
2. Setting up SSL/TLS certificates
3. Using Docker Swarm or Kubernetes for orchestration
4. Implementing proper backup strategies
5. Setting up monitoring and alerting

## Troubleshooting

### Database Connection Issues

If the web container can't connect to the database:

1. Check the database logs: `docker-compose logs db`
2. Verify the database credentials in the `docker-compose.yml` file
3. Make sure the database service is healthy: `docker-compose ps`

### Static Files Not Loading

If static files aren't loading properly:

1. Make sure the volume mappings are correct in `docker-compose.yml`
2. Rebuild the containers: `docker-compose up -d --build`
3. Check the settings in `agricare/docker_settings.py`

## Resources

- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [Django Deployment with Docker](https://docs.djangoproject.com/en/5.2/howto/deployment/) 