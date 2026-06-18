from main import app


def test_healthz():
    client = app.test_client()
    r = client.get("/healthz")
    assert r.status_code == 200
    assert r.get_json() == {"status": "ok"}


def test_add_and_list_note():
    client = app.test_client()
    client.post("/api/notes", json={"title": "first"})
    r = client.get("/api/notes")
    assert r.status_code == 200
    body = r.get_json()
    assert any(n["title"] == "first" for n in body)


def test_add_note_requires_title():
    client = app.test_client()
    r = client.post("/api/notes", json={})
    assert r.status_code == 400
