# Use an official Python runtime as a parent image
FROM python:3.10-slim

# Set the working directory in the container
WORKDIR /root/FallenRobot

# Install system dependencies
RUN apt-get update && apt-get upgrade -y && \
    apt-get install --no-install-recommends -y \
    bash \
    curl \
    git \
    libffi-dev \
    libjpeg-dev \
    libjpeg62-turbo-dev \
    libwebp-dev \
    libpq-dev \
    python3-lxml \
    python3-psycopg2 \
    python3-pip \
    python3-requests \
    python3-sqlalchemy \
    python3-tz \
    python3-aiohttp \
    postgresql \
    postgresql-client \
    ffmpeg \
    zlib1g \
    libssl-dev \
    libgconf-2-4 \
    libxi6 \
    libsqlite3-dev && \
    rm -rf /var/lib/apt/lists/*

# Clone the repository (if needed)
RUN git clone https://github.com/Sandalivihansa/FallenRobot.git /root/FallenRobot

# Set the working directory for the project
WORKDIR /root/FallenRobot

# Upgrade pip and setuptools
RUN pip3 install --upgrade pip setuptools wheel

# Copy the requirements.txt file into the container
COPY requirements.txt /root/FallenRobot/

# Install Python dependencies from requirements.txt
RUN pip3 install -U -r /root/FallenRobot/requirements.txt --no-cache-dir --verbose

# Copy the configuration file (if any) into the correct directory
COPY ./FallenRobot/config.py /root/FallenRobot/FallenRobot/

# Ensure that the __main__.py file exists in your local repository
# If not, add it to the repository
# Example:
# COPY ./FallenRobot/__main__.py /root/FallenRobot/FallenRobot/__main__.py

# Set environment variables (if needed)
# ENV VAR_NAME=value

# Expose necessary ports (if applicable)
# EXPOSE 8080

# Command to run your application (ensure it runs as a package with __main__.py)
CMD ["python3", "-m", "FallenRobot"]
