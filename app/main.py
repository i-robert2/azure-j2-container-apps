from flask import Flask, jsonify, request

app = Flask(__name__)
NOTES = []


@app.get("/healthz")
def healthz():
    return jsonify({"status": "ok"})


@app.get("/api/notes")
def list_notes():
    return jsonify(NOTES)


@app.post("/api/notes")
def add_note():
    data = request.get_json(silent=True) or {}
    title = data.get("title")
    if not title:
        return jsonify({"error": "title required"}), 400
    note = {"id": len(NOTES) + 1, "title": title}
    NOTES.append(note)
    return jsonify(note), 201


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)
