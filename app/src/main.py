"""Tiny FastAPI service used to demo the CI/CD + observability pipeline."""
from __future__ import annotations

import logging
import os
import sys
import time

from fastapi import FastAPI, Response
from prometheus_client import CONTENT_TYPE_LATEST, Counter, Histogram, generate_latest
from starlette.middleware.base import BaseHTTPMiddleware
from starlette.requests import Request

logging.basicConfig(
    stream=sys.stdout,
    level=os.environ.get("LOG_LEVEL", "INFO"),
    format='{"time":"%(asctime)s","level":"%(levelname)s","msg":"%(message)s"}',
)
log = logging.getLogger("starter-devops")

REQUESTS = Counter(
    "http_requests_total", "Total HTTP requests", ["method", "path", "status"]
)
LATENCY = Histogram(
    "http_request_duration_seconds", "HTTP request duration (s)", ["path"]
)


class MetricsMiddleware(BaseHTTPMiddleware):
    async def dispatch(self, request: Request, call_next):  # type: ignore[no-untyped-def]
        start = time.perf_counter()
        response = await call_next(request)
        elapsed = time.perf_counter() - start
        path = request.url.path
        LATENCY.labels(path=path).observe(elapsed)
        REQUESTS.labels(
            method=request.method, path=path, status=str(response.status_code)
        ).inc()
        log.info(f"{request.method} {path} {response.status_code} {elapsed:.4f}s")
        return response


app = FastAPI(title="Skilluv starter-devops demo")
app.add_middleware(MetricsMiddleware)


@app.get("/")
def root() -> dict[str, str]:
    return {"message": "Hello from starter-devops!", "version": "0.1.0"}


@app.get("/health")
def health() -> dict[str, str]:
    return {"status": "ok"}


@app.get("/metrics")
def metrics() -> Response:
    return Response(generate_latest(), media_type=CONTENT_TYPE_LATEST)
