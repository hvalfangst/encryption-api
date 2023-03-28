#!/bin/sh

printf "\n\n"

chmod +x misc/progress_bar.sh

REPOSITORY_TAG="hardokkerdokker/hvalfangst:encryption-service"

# Check if the current operating system is macOS
if [ "$(uname)" = "Darwin" ]; then
    # Replace "sed" with "gsed" for macOS
    SED_COMMAND="gsed"
else
    SED_COMMAND="sed"
fi

# Build image from Dockerfile - exit script on failure
printf "Building image [encryption-service] from local Dockerfile\n"
if ! docker build -t "$REPOSITORY_TAG" . ; then
    printf "[Error building image 'encryption-service' - Exiting script]\n"
    exit 1
fi
echo

# Push image to repository with given tag for macOS
if [ "$(uname)" = "Darwin" ]; then
    printf "Pushing image with tag [%s]", "$REPOSITORY_TAG"
    if ! docker push "$REPOSITORY_TAG" ; then
        printf "[Error pushing image to repository - Exiting script]\n"
        exit 1
    fi
    echo
fi

printf "\n\n"

# Prompt user for encryption key
read -p "Enter desired encryption key: " encryption_key

printf "\n\n"

# Base64 encode the encryption key
encoded_key=$(echo -n "$encryption_key" | base64 | tr -d '\n')

# Use "sed" to overwrite value of the field "encryption_key" contained in yaml file "secrets"
$SED_COMMAND -i "s|^\(.*encryption_key: \)\(.*\)|\1$encoded_key|" k8s/secrets.yaml

# Create our initial resources
kubectl apply -f k8s/secrets.yaml > /dev/null 2>&1
kubectl apply -f k8s/nginx.yaml > /dev/null 2>&1
kubectl apply -f k8s/manifest.yaml > /dev/null 2>&1

echo "Creating resources defined in manifest.yaml"
./misc/progress_bar.sh 0.25

echo "Preparing pods..."
./misc/progress_bar.sh 0.25

# List pods
kubectl get pods