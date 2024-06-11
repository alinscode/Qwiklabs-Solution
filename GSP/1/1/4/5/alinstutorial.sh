gcloud auth list
gcloud config list project

gcloud services enable dataplex.googleapis.com
gcloud services enable datacatalog.googleapis.com
gcloud dataplex lakes create orders-lake \
   --location=$REGION \
   --display-name="Orders Lake"
gcloud dataplex zones create customer-curated-zone \
    --location=$REGION \
    --lake=orders-lake \
    --display-name="Customer Curated Zone" \
    --type=CURATED \
    --resource-location-type=SINGLE_REGION
gcloud dataplex assets create customer-details-dataset \
--location=$REGION \
--lake=orders-lake \
--zone=customer-curated-zone \
--display-name="Customer Details Dataset" \
--resource-type=BIGQUERY_DATASET \
--resource-name=projects/$DEVSHELL_PROJECT_ID/datasets/customers

