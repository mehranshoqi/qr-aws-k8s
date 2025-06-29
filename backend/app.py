from flask import Flask, request, send_file
from flask_cors import CORS
import qrcode
import io

app = Flask(__name__)
CORS(app)

@app.route("/generate", methods=["POST"])
def generate_qr():
    data = request.json.get("text")
    img = qrcode.make(data)
    buf = io.BytesIO()
    img.save(buf, format="PNG")
    buf.seek(0)
    return send_file(buf, mimetype="image/png")

@app.route("/health", methods=["GET"])
def health():
    return "healthy", 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)
