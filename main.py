import os

from flask import Flask, request
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
    return aes("encrypt", text, master_password)


@app.route("/decrypt", methods=["POST"])
def decrypt():
    text = request.data.decode("utf-8")
    master_password = os.environ.get("ENCRYPTION_KEY")
    return aes("decrypt", text, master_password)


if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))
    app.run(debug=False, host="0.0.0.0", port=port)
