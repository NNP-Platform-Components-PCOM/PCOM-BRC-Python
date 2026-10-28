# syntax=docker/dockerfile:1.7
#
# PCOM - BRC - Python
# -------------------
# CPython (Debian slim) re-published under the Nubo Native Platform (NNP)
# runtime images, so Python workloads pull their interpreter from the NNP
# Docker Hub namespace instead of an external registry. One tag per minor
# version (3.11, 3.12, 3.13).
#
# Upstream: https://hub.docker.com/_/python
#
# Build:
#   docker build --build-arg python_version=3.12 -t pcom-brc-python:3.12 .

# Upstream Python minor version. Overridable at build time.
ARG python_version=3.12

FROM python:${python_version}-slim

# --- OCI image metadata (populated by CI, overridable at build time) ---------
ARG BUILD_DATE
ARG VCS_REF
ARG python_version

LABEL org.opencontainers.image.title="pcom-brc-python" \
      org.opencontainers.image.description="CPython ${python_version} (Debian slim) for the Nubo Native Platform runtime images." \
      org.opencontainers.image.vendor="Nubo Native Platform" \
      org.opencontainers.image.source="https://github.com/NNP-Platform-Components-PCOM/PCOM-BRC-Python" \
      org.opencontainers.image.url="https://github.com/NNP-Platform-Components-PCOM/PCOM-BRC-Python" \
      org.opencontainers.image.base.name="docker.io/library/python:${python_version}-slim" \
      org.opencontainers.image.version="${python_version}" \
      org.opencontainers.image.revision="${VCS_REF}" \
      org.opencontainers.image.created="${BUILD_DATE}"

RUN python --version
