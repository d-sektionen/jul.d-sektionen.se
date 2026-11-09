# Use an official Python runtime as the base image
FROM python:3.15-slim

# Install uv from the official image
COPY --from=ghcr.io/astral-sh/uv:0.13 /uv /uvx /bin/

# Set the working directory in the container
WORKDIR /code

# set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV DJANGO_SETTINGS_MODULE=app.settings_production
ENV PATH="/code/.venv/bin:$PATH"

# Copy dependency files into container
COPY pyproject.toml uv.lock README.md ./

# Install build tools and project dependencies, remove tools and cache after.
RUN uv sync --frozen --no-dev --no-install-project --no-cache

# Copy over rest of the project after installing deps to optimize rebuilds
COPY ./src ./docker-entrypoint.sh ./

ENTRYPOINT [ "sh", "/code/docker-entrypoint.sh"]
