#!/bin/bash
set -e

echo "🔧 Building Lambda Layer (platform: linux/amd64)..."

# Build the Docker image for x86_64 architecture
docker build --platform=linux/amd64 -t kafka-layer-builder .

echo "📦 Exporting the Layer zip package..."

# Create a container and copy out the layer zip
CONTAINER_ID=$(docker create kafka-layer-builder)
docker cp $CONTAINER_ID:/build/layer.zip ./layer.zip
docker cp $CONTAINER_ID:/build/python ./python_layer_preview
docker rm $CONTAINER_ID

echo "✅ Build complete: layer.zip"

echo "🔍 Checking compiled .so files for architecture compatibility..."
find ./python_layer_preview -name '*.so' | while read sofile; do
    file "$sofile"
done

echo "✅ Compatibility check complete. You can now upload layer.zip to Lambda."
