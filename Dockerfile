# Use Python 3.9 slim as base image
FROM python:3.10-slim

# Set environment variable to avoid caching
ENV PIP_NO_CACHE_DIR=1

# Install required system dependencies
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
    libsqlite3-dev \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip and install Python dependencies
RUN pip3 install --upgrade pip setuptools wheel

# Clone the repository
RUN git clone https://github.com/AnonymousX1025/FallenRobot /root/FallenRobot

# Set the working directory
WORKDIR /root/FallenRobot

# Copy config file
COPY ./FallenRobot/config.py /root/FallenRobot/FallenRobot/

# Install Python dependencies
RUN pip3 install -U -r requirements.txt --no-cache-dir --verbose

# Set the environment variables (configure in Railway)
ENV PATH="/home/bot/bin:$PATH"

# Expose the necessary port if required
EXPOSE 5000

# Run the bot
CMD ["python3", "-m", "FallenRobot"]
