export PROJECT_ID=$(gcloud info --format='value(config.project)')
export BUCKET_NAME=$PROJECT_ID

gsutil mb -p $PROJECT_ID gs://$PROJECT_ID-alinstutorial

curl -O https://github.com/alinscode/Qwiklabs-Solution/blob/main/Working%20with%20the%20Google%20Cloud%20Console%20and%20Cloud%20Shell/kitten.png

gsutil cp kitten.png gs://$PROJECT_ID-alinstutorial/kitten.png
