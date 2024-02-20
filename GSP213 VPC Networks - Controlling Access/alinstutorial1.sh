export PROJECT_ID=$(gcloud config get-value project)
gcloud compute instances create blue \
  --zone=$ZONE \
  --machine-type=e2-medium \
  --tags=web-server
gcloud compute instances create green \
  --zone=$ZONE \
  --machine-type=e2-medium 
gcloud compute firewall-rules create allow-http-web-server \
  --network=default \
  --action=ALLOW \
  --direction=INGRESS \
  --source-ranges=0.0.0.0/0 \
  --target-tags=web-server \
  --rules=tcp:80,icmp
gcloud compute instances create test-vm --machine-type=e2-micro --subnet=default --zone=$ZONE

