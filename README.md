## 📦 Kafka Layer Builder
This project provides a simple and repeatable way to build a Python Lambda Layer for confluent_kafka.
The generated layer.zip can be used in AWS Lambda to enable Kafka integration without bundling dependencies in your function code.

## 🚀 Project Structure

```
kafka-layer-builder/
├── python_layer_preview/       # Preview of extracted layer content (ignored in git)
├── build.sh                    # Build script for generating layer.zip
├── Dockerfile                  # Docker environment for reproducible builds
├── layer.zip                   # Build artifact (ignored in git)
├── requirements.txt            # Python dependencies
└── .gitignore                  # Git ignore rules
```

## 🛠️ How to Build the Layer
You can build the layer using the provided Dockerfile for consistency across environments.

docker build -t kafka-layer-builder .
docker run --rm -v "$PWD":/var/task kafka-layer-builder
Or simply use the build script:

./build.sh
After running, you will get layer.zip which can be uploaded to AWS Lambda as a Layer.

## 📥 Usage in AWS Lambda

Upload layer.zip to AWS Lambda Layers via the AWS Console or CLI.

Add the Layer to your Lambda function.

Make sure your Lambda uses compatible Python runtime.

Example:

from confluent_kafka import Producer
```
p = Producer({'bootstrap.servers': 'localhost:9092'})
p.produce('mytopic', key='key', value='value')
p.flush()
```

## 📌 Notes
python_layer_preview directory is used only for preview and is not included in git history.

layer.zip is ignored by git and should be built locally or during your CI/CD process.

For any issues, please feel free to open an issue or fork this repo.

✅ License
MIT License.
