FROM python:3.11-slim

# Install uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# Set working directory
WORKDIR /app

# Install system dependencies for potential browser automation needs
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

# Copy the fast_flights directory (required at runtime)
COPY fast_flights/ ./fast_flights/

# Copy the server file
COPY server.py .
COPY requirements.txt .

# Install Python dependencies using uv
RUN uv pip install --system -r requirements.txt
RUN playwright install

# Expose port (if needed for SSE transport)
EXPOSE 8000

# Run the server
CMD ["python", "server.py"]