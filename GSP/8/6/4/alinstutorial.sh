gcloud auth list
gcloud config list project
gcloud config set compute/region $REGION

git clone https://github.com/googleapis/synthtool
cd synthtool/tests/fixtures/nodejs-dlp/samples/ && npm install

gcloud config set project $PROJECT_ID
gcloud services enable dlp.googleapis.com cloudkms.googleapis.com \
--project $PROJECT_ID

node inspectString.js $PROJECT_ID "My email address is jenny@somedomain.com and you can call me at 555-867-5309" > inspected-string.txt

cat inspected-string.txt
cat resources/accounts.txt

node inspectFile.js $PROJECT_ID resources/accounts.txt > inspected-file.txt
cat inspected-file.txt

gsutil cp inspected-string.txt gs://qwiklabs-gcp-01-8b40f27a4bd8-bucket
gsutil cp inspected-file.txt gs://qwiklabs-gcp-01-8b40f27a4bd8-bucket

node deidentifyWithMask.js $PROJECT_ID "My order number is F12312399. Email me at anthony@somedomain.com" > de-identify-output.txt

cat de-identify-output.txt
gsutil cp de-identify-output.txt gs://qwiklabs-gcp-01-8b40f27a4bd8-bucket

node redactText.js $PROJECT_ID  "Please refund the purchase to my credit card 4012888888881881" CREDIT_CARD_NUMBER > redacted-string.txt
cat redacted-string.txt

node redactImage.js $PROJECT_ID resources/test.png "" PHONE_NUMBER ./redacted-phone.png

node redactImage.js $PROJECT_ID resources/test.png "" EMAIL_ADDRESS ./redacted-email.png

gsutil cp redacted-string.txt gs://qwiklabs-gcp-01-8b40f27a4bd8-bucket
gsutil cp redacted-phone.png gs://qwiklabs-gcp-01-8b40f27a4bd8-bucket
gsutil cp redacted-email.png gs://qwiklabs-gcp-01-8b40f27a4bd8-bucket