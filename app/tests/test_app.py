from fastapi.testclient import TestClient

from src.main import app

client = TestClient(app)


def test_root() -> None:
    r = client.get("/")
    assert r.status_code == 200
    assert r.json()["message"].startswith("Hello")


def test_health() -> None:
    assert client.get("/health").json() == {"status": "ok"}


def test_metrics_endpoint() -> None:
    r = client.get("/metrics")
    assert r.status_code == 200
    assert b"http_requests_total" in r.content
