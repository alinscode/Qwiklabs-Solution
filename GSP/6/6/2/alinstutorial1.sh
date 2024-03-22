gcloud config set compute/zone $ZONE
gcloud services enable compute.googleapis.com
gsutil mb gs://fancy-store-$DEVSHELL_PROJECT_ID
git clone https://github.com/googlecodelabs/monolith-to-microservices.git
cd ~/monolith-to-microservices
chmod +x setup.sh
./setup.sh
nvm install --lts
curl -O -L https://github.com/Qwicklab/Level-1-AppDev-and-Infrastructure/blob/main/sh%20files/startup-script.sh
gsutil cp ~/monolith-to-microservices/startup-script.sh gs://fancy-store-$DEVSHELL_PROJECT_ID
cd ~
rm -rf monolith-to-microservices/*/node_modules
gsutil -m cp -r monolith-to-microservices gs://fancy-store-$DEVSHELL_PROJECT_ID/
gcloud compute instances create backend \
    --machine-type=e2-medium \
    --tags=backend \
   --metadata=startup-script-url=https://storage.googleapis.com/fancy-store-$DEVSHELL_PROJECT_ID/startup-script.sh
gcloud compute instances list
export EXTERNAL_IP=$(gcloud compute instances describe backend --zone=$ZONE --format='get(networkInterfaces[0].accessConfigs[0].natIP)')
cd ~/monolith-to-microservices/react-app
rm -f .env
cat > .env << EOF
REACT_APP_ORDERS_URL=http://$EXTERNAL_IP:8081/api/orders
REACT_APP_PRODUCTS_URL=http://$EXTERNAL_IP:8082/api/products
EOF
cd ~/monolith-to-microservices/react-app
npm install && npm run-script build
cd ~
rm -rf monolith-to-microservices/*/node_modules
gsutil -m cp -r monolith-to-microservices gs://fancy-store-$DEVSHELL_PROJECT_ID/
gcloud compute instances create frontend \
    --machine-type=e2-medium \
    --tags=frontend \
    --metadata=startup-script-url=https://storage.googleapis.com/fancy-store-$DEVSHELL_PROJECT_ID/startup-script.sh
gcloud compute firewall-rules create fw-fe \
    --allow tcp:8080 \
    --target-tags=frontend
gcloud compute firewall-rules create fw-be \
    --allow tcp:8081-8082 \
    --target-tags=backend
gcloud compute instances list