gcloud compute instances stop frontend
gcloud compute instances stop backend
gcloud compute instance-templates create fancy-fe \
    --source-instance=frontend
gcloud compute instance-templates create fancy-be \
    --source-instance=backend
gcloud compute instance-templates list
gcloud compute instances delete --quiet  backend
gcloud compute instance-groups managed create fancy-fe-mig \
    --base-instance-name fancy-fe \
    --size 2 \
    --template fancy-fe
gcloud compute instance-groups managed create fancy-be-mig \
    --base-instance-name fancy-be \
    --size 2 \
    --template fancy-be
gcloud compute instance-groups set-named-ports fancy-fe-mig \
    --named-ports frontend:8080
gcloud compute instance-groups set-named-ports fancy-be-mig \
    --named-ports orders:8081,products:8082
gcloud compute health-checks create http fancy-fe-hc \
    --port 8080 \
    --check-interval 30s \
    --healthy-threshold 1 \
    --timeout 10s \
    --unhealthy-threshold 3
gcloud compute health-checks create http fancy-be-hc \
    --port 8081 \
    --request-path=/api/orders \
    --check-interval 30s \
    --healthy-threshold 1 \
    --timeout 10s \
    --unhealthy-threshold 3
gcloud compute firewall-rules create allow-health-check \
    --allow tcp:8080-8081 \
    --source-ranges 130.211.0.0/22,35.191.0.0/16 \
    --network default
gcloud compute instance-groups managed update fancy-fe-mig \
    --health-check fancy-fe-hc \
    --initial-delay 300
gcloud compute instance-groups managed update fancy-be-mig \
    --health-check fancy-be-hc \
    --initial-delay 300