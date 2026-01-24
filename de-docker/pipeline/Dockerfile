FROM python:3.12-slim

# Install ca-certificates package
RUN apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*

# Add corporate CA certificate for SSL verification
COPY corporate-ca.crt /usr/local/share/ca-certificates/corporate-ca.crt
RUN update-ca-certificates

# Install uv via pip
RUN pip install uv

# Set working directory
WORKDIR /app

# Configure SSL for Python and other tools (trust system certificates)
ENV SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
ENV REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt
ENV CURL_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt
ENV UV_NATIVE_TLS=1

# Add virtual environment to PATH so we can use installed packages
ENV PATH="/app/.venv/bin:$PATH"

# Copy dependency files first (better layer caching)
COPY pyproject.toml uv.lock .python-version ./

# Install dependencies using system Python (skip python-build-standalone download)
RUN uv sync --locked --python-preference=only-system

# Copy application code
COPY ingest_data.py ingest_data.py

# Set entry point
ENTRYPOINT ["python", "ingest_data.py"]
















