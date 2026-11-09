# Use an official Python runtime as the base image
FROM python:3.12-slim

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
RUN apt update && apt upgrade -y
RUN apt install gcc musl-dev libpcre2-dev -y
RUN uv sync --frozen --no-dev --no-install-project --no-cache
RUN apt clean autoclean
RUN apt autoremove --purge apt gcc musl-dev -y --allow-remove-essential
RUN rm -rf /var/lib/{apt,dpkg,cache,log,lists}

# Copy over rest of the project after installing deps to optimize rebuilds
COPY ./src ./docker-entrypoint.sh ./

ENTRYPOINT [ "sh", "/code/docker-entrypoint.sh"]
