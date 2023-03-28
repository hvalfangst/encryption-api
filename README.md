# Gunicorn Flask encryption API with NGINX reverse proxy

Provides endpoints for encrypting and decrypting using AES in CBC mode with PBKDF2 key derivation

## Requirements

* Docker
* Kubernetes cluster

##

## Creating resources
The shell script "up.sh" is responsible for building the local Docker image and creating resources
```
sh up.sh
```


## Port forwarding
The following command will reroute requests from local port 6666 to that of port 80 of the nginx pod
```
kubectl port-forward deployments/nginx 6666:80
```

## Deleting resources
The shell script "down.sh" frees up allocated resources

```
sh down.sh
```

## Endpoints

---

### Encrypt (raw body: text), (bearer token) -> ciphertext

POST http://localhost:6666/encrypt

### Decrypt (raw body: ciphertext), (bearer token) -> text


POST http://localhost:6666/decrypt

---

### Create User (json body: {username, password}) -> text

POST http://localhost:6666/users

### List Users -> JSON


GET http://localhost:6666/users

### Delete User (json body: {username, password}) -> text

DELETE http://localhost:6666/users

---

### Login (json body: {username, password}) -> Token

POST http://localhost:6666/login


