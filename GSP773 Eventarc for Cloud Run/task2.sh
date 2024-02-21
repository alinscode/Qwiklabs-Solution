echo "Hello World" > random.txt

gsutil cp random.txt gs://${BUCKET_NAME}/random.txt

gcloud beta eventarc attributes types describe google.cloud.audit.log.v1.written

gcloud beta eventarc triggers create trigger-auditlog \
--destination-run-service=${SERVICE_NAME} \
--matching-criteria="type=google.cloud.audit.log.v1.written" \
--matching-criteria="serviceName=storage.googleapis.com" \
--matching-criteria="methodName=storage.objects.create" \
--service-account=${PROJECT_NUMBER}-compute@developer.gserviceaccount.com


gsutil cp random.txt gs://${BUCKET_NAME}/random.txt

curl -O https://github.com/alinscode/Qwiklabs-Solution/blob/main/Working%20with%20the%20Google%20Cloud%20Console%20and%20Cloud%20Shell/kitten.png

gsutil cp kitten.png gs://${BUCKET_NAME}/kitten.png