FROM python:3.11-slim


RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libcairo2 \
    libpango-1.0-0 \
    libpangoft2-1.0-0 \
    libgdk-pixbuf-2.0-0 \
    libglib2.0-0 \
    libffi-dev \
    libfreetype6 \
    libharfbuzz0b \
    libxml2 \
    libxslt1.1 \
    libjpeg62-turbo \
    libsm6 \
    libxext6 \
    fonts-liberation \
    fonts-dejavu-core \
    tzdata \
    libreoffice \
    libxrender-dev \
 && ln -snf /usr/share/zoneinfo/Europe/Lisbon /etc/localtime \
 && echo "Europe/Lisbon" > /etc/timezone \
 && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy all app code
COPY . .
COPY app/streamlit/.streamlit/ ./app/streamlit/.streamlit/

# Install Python dependencies
RUN pip install --upgrade pip && pip install -r requirements.txt

# Expose both ports
EXPOSE 8000
EXPOSE 8501

# run start

COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]
