
gcloud services enable artifactregistry.googleapis.com \
    cloudbuild.googleapis.com \
    run.googleapis.com
git clone https://github.com/googlecodelabs/monolith-to-microservices.git
cd ~/monolith-to-microservices./setup.sh
./setup.sh
cd ~/monolith-to-microservices/monolith
npm start
gcloud artifacts repositories create monolith-demo --location=us-central1 --repository-format=docker
gcloud auth configure-docker us-central1-docker.pkg.dev
gcloud builds submit --tag us-central1-docker.pkg.dev/${GOOGLE_CLOUD_PROJECT}/monolith-demo/monolith:1.0.0
gcloud run deploy monolith --image us-central1-docker.pkg.dev/${GOOGLE_CLOUD_PROJECT}/monolith-demo/monolith:1.0.0 --allow-unauthenticated --region us-central1
gcloud run deploy monolith --image us-central1-docker.pkg.dev/${GOOGLE_CLOUD_PROJECT}/monolith-demo/monolith:1.0.0 --allow-unauthenticated --region us-central1 --concurrency 1
gcloud run deploy monolith --image us-central1-docker.pkg.dev/${GOOGLE_CLOUD_PROJECT}/monolith-demo/monolith:1.0.0 --allow-unauthenticated --region us-central1 --concurrency 80
cd ~/monolith-to-microservices/react-app/src/pages/Home
mv index.js.new index.js
cd ~/monolith-to-microservices/react-app
npm run build:monolith
cd ~/monolith-to-microservices/monolith
gcloud builds submit --tag us-central1-docker.pkg.dev/${GOOGLE_CLOUD_PROJECT}/monolith-demo/monolith:2.0.0
gcloud run deploy monolith --image us-central1-docker.pkg.dev/${GOOGLE_CLOUD_PROJECT}/monolith-demo/monolith:2.0.0 --allow-unauthenticated --region us-central1