export PROJECT_ID=$(gcloud config get-value core/project)
gsutil mb gs://${PROJECT_ID}
gsutil -m cp gs://cloud-training/gsp897/cosmetic-test-data/*.png \
gs://${PROJECT_ID}/cosmetic-test-data/

gsutil ls gs://${PROJECT_ID}/cosmetic-test-data/*.png > /tmp/demo_cosmetic_images.csv
gsutil cp /tmp/demo_cosmetic_images.csv gs://${PROJECT_ID}/demo_cosmetic_images.csv

