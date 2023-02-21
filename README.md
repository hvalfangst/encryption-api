# Gunicorn Flask encryption API with NGINX reverse proxy

Provides endpoints for encrypting and decrypting using AES in CBC mode with PBKDF2 key derivation. 

## Requirements

* x86-64
* Linux
* Docker
* k8s

## Creating resources
The shell script "up.sh" is responsible for building the local Docker image and creating requested resources, which are defined in our k8s manifest.

```
sh up.sh
```

## Destroying resources
The shell script "down.sh" frees up allocated resources.

```
sh down.sh
```

## Endpoints
Once you have executed the shell script "up.sh" you are ready to test the API. 


### Encrypt (raw body: text) -> ciphertext

POST http://localhost:5001/encrypt

### Decrypt (raw body: ciphertext) -> text


POST http://localhost:5001/decrypt
