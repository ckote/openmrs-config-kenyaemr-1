#!/bin/bash

# Clean up previous build artifacts
echo "Cleaning up previous build artifacts ..."
rm -rf openmrs-config-kenyaemr
rm -rf frontend

# Build assets
echo "Building Kenya EMR 3.x assets ..."
CWD=$(pwd)
npx --legacy-peer-deps openmrs@next build \
  --build-config ./configuration/spa-build-config.json \
  --target ./frontend \
  --page-title "KenyaEMR" \
  --support-offline false

# Assemble assets
echo "Assembling assets ..."
npx --legacy-peer-deps openmrs@next assemble \
  --manifest \
  --mode config \
  --config ./configuration/spa-build-config.json \
  --target ./frontend

# Copy required files
echo "Copying required files ..."
cp "${CWD}/assets/kenyaemr-login-logo.png" "${CWD}/frontend"
cp "${CWD}/assets/kenyaemr-primary-logo.png" "${CWD}/frontend"
cp "${CWD}/assets/favicon.ico" "${CWD}/frontend"
cp "${CWD}/configuration/config.json" "${CWD}/frontend"

# Exit with success status
exit 0
