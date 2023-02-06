#!/bin/sh

echo -e "\n\n"


# Build image from Dockerfile - exit script on failure
echo "Building image [encryption-service] from local Dockerfile"
  if ! docker build -t hardokkerdocker/hvalfangst:encryption-service .; then
      echo
      echo "[Error building image 'encryption-service' - Exiting script]"
      exit 1
  fi
echo


echo -e "\n\n"


# Create our deployment and service resources
kubectl apply -f manifest.yaml > /dev/null 2>&1

echo "Creating resources defined in manifest.yaml"
bar_length=50
bar_char="="
for i in $(seq 1 10); do
  progress=$((i * 10))
  progress_bar=""
  for j in $(seq 1 $((bar_length * i / 10))); do
    progress_bar="$progress_bar$bar_char"
  done
  spaces=$((bar_length - (bar_length * i / 10)))
  for k in $(seq 1 $spaces); do
    progress_bar="$progress_bar "
  done
echo -ne "\r[$progress_bar] $progress %"
sleep 0.250
done

echo -e "\n\n"

echo "Preparing pods..."
bar_length=50
bar_char="="
for i in $(seq 1 10); do
  progress=$((i * 10))
  progress_bar=""
  for j in $(seq 1 $((bar_length * i / 10))); do
    progress_bar="$progress_bar$bar_char"
  done
  spaces=$((bar_length - (bar_length * i / 10)))
  for k in $(seq 1 $spaces); do
    progress_bar="$progress_bar "
  done
echo -ne "\r[$progress_bar] $progress %"
sleep 0.25
done

echo -e "\n\n"

# List pods
kubectl get pods