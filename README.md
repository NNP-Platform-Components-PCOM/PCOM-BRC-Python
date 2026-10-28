# PCOM - BRC - Python

**Base Runtime Component: Python** — CPython (Debian slim) re-published for the
Nubo Native Platform (NNP), so Python workloads pull their interpreter from the
NNP Docker Hub namespace instead of an external registry.

Each image is built `FROM python:<version>-slim` and adds only OCI metadata; the
interpreter is unchanged from upstream. Debian (glibc) is used rather than
Alpine so that binary wheels (numpy, pandas, torch, ...) install and run
normally.

## Images

Published to Docker Hub on every push to `main`:

```
docker.io/nubonativesolution/pcom-brc-python:3.11
docker.io/nubonativesolution/pcom-brc-python:3.12
docker.io/nubonativesolution/pcom-brc-python:3.13
```

`latest` points to 3.12. Pin a version tag in workloads. Architecture:
`linux/amd64`.

## Use

```dockerfile
FROM docker.io/nubonativesolution/pcom-brc-python:3.12
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
CMD ["python", "main.py"]
```

For packages that need a compiler, build in
[`PCOM-BRC-Python-Build`](https://github.com/NNP-Platform-Components-PCOM/PCOM-BRC-Python-Build)
and copy the result into this image.

## Build locally

```bash
docker build --build-arg python_version=3.12 -t pcom-brc-python:3.12 .
```

## CI/CD

`.github/workflows/build.yml` is a thin caller for the shared
[`PCOM-CICD`](https://github.com/NNP-Platform-Components-PCOM/PCOM-CICD)
reusable pipeline, run once per Python version: build with Buildx, publish with
SBOM + provenance, sign with **cosign keyless** (OIDC), and scan with Trivy and
Grype (results in the **Security** tab). Pull requests build and scan without
publishing. Images are rebuilt weekly to pick up upstream security updates.

## License

Apache-2.0 for the packaging in this repository. Python is distributed by its
upstream project under the PSF license.
