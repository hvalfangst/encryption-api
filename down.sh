#!/bin/sh

echo

kubectl delete -f manifest.yaml > /dev/null 2>&1
wait

echo "Deleting resources defined in manifest.yaml"
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
sleep 0.350
done
echo