# AgriCare - Agricultural Assistant Web Application

AgriCare is a comprehensive agricultural web application designed to help farmers optimize their crop selection, growing practices, and disease management through data-driven recommendations.

## Features

### 1. Location-Based Crop Recommendation System
- Hierarchical location selection (Country → State → District → Village)
- Soil fertility analysis based on geographical data
- Climate and weather condition assessment for the selected region
- Intelligent recommendation engine for suitable crops, fertilizers, and planting schedules

### 2. Crop Life Cycle Management
- Day-by-day guidance system from planting to harvest
- Personalized calendar with timely notifications
- Progress tracking with visualization of growth stages
- Customizable alerts and reminders for critical farming activities

### 3. Plant Disease Detection and Management
- Image-based disease recognition system
- AI-powered disease identification and analysis
- Detailed information on diseases, treatments, and prevention
- Historical disease tracking for pattern recognition

## Tech Stack

- **Backend**: Python with Django
- **Databases**: 
  - MySQL for structured data
  - Firebase for real-time data and authentication
- **Frontend**: HTML, CSS, JavaScript with responsive design
- **Additional Technologies**: Machine learning for disease detection, Weather API integration

## Project Structure

```
agricare/
├── accounts/                # User authentication and profiles
├── crops/                   # Crop recommendations and database
├── lifecycle/               # Crop lifecycle management
├── disease_detection/       # Disease detection and management
├── agricare/                # Main project settings
├── templates/               # HTML templates
├── static/                  # Static files (CSS, JS, images)
│   ├── css/
│   ├── js/
│   └── images/
├── media/                   # User-uploaded files
├── manage.py                # Django management script
└── README.md                # Project documentation
```

## Setup Instructions

### Prerequisites
- Python 3.8+
- MySQL Server
- Firebase account (for authentication)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/agricare.git
cd agricare
```

2. Create a virtual environment:
```bash
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
```

3. Install dependencies:
```bash
pip install -r requirements.txt
```

4. Set up the database:
```bash
# Create MySQL database
mysql -u root -p
CREATE DATABASE agricare_db;
exit;

# Run migrations
python manage.py migrate
```

5. Create a superuser:
```bash
python manage.py createsuperuser
```

6. Run the development server:
```bash
python manage.py runserver
```

7. Access the application at http://127.0.0.1:8000/

## Deployment Options

### 1. Local Production Setup

For local production deployment, please see the [Local Production Setup Guide](LOCAL_PRODUCTION_SETUP.md) which provides detailed instructions for:

1. Setting up a MySQL database with proper character encoding
2. Configuring Django for production use
3. Using Gunicorn as a WSGI server
4. Serving static files with WhiteNoise
5. Security configurations

To quickly start the application in production mode:

- **Windows**: Run `start_server.bat`
- **Linux/macOS**: Run `./start_server.sh` (make it executable first with `chmod +x start_server.sh`)

### 2. Docker Deployment

For containerized deployment using Docker, please see the [Docker Setup Guide](DOCKER_SETUP.md) which covers:

1. Running the application with Docker Compose
2. Managing the MySQL database in a container
3. Environment configuration for Docker
4. Using PHPMyAdmin for database management
5. Common Docker commands and troubleshooting

To quickly start the application with Docker:

```bash
docker-compose up -d
```

Access the application at http://localhost:8000 and PHPMyAdmin at http://localhost:8080.

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details. 