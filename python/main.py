import os

from flask import Flask, request, jsonify
import encryption

app = Flask(__name__)


def aes(flag, text, key):
    if flag == "encrypt":
        return encryption.aesCbcPbkdf2EncryptToBase64(key, text)
    elif flag == "decrypt":
        return encryption.aesCbcPbkdf2DecryptFromBase64(key, text)
    else:
        print("Illegal argument!")


@app.route("/encrypt", methods=["POST"])
def encrypt():
    text = request.data.decode("utf-8")
    master_password = os.environ.get("ENCRYPTION_KEY")
    pod_name = os.environ.get("POD_NAME")
    result = aes("encrypt", text, master_password)

    response = {
        "pod_name": pod_name,
        "result": result
    }

    return jsonify(response)


@app.route("/decrypt", methods=["POST"])
def decrypt():
    text = request.data.decode("utf-8")
    master_password = os.environ.get("ENCRYPTION_KEY")
    pod_name = os.environ.get("POD_NAME")
    result = aes("decrypt", text, master_password)

    response = {
        "pod_name": pod_name,
        "result": result
    }

    return jsonify(response)


if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))
    app.run(debug=False, host="0.0.0.0", port=port)
