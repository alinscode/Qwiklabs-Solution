# Run in Cloud Shell
```cmd
export REGION=
```

```cmd
export ZONE=
```

```cmd
curl -LO raw.githubusercontent.com/alinscode/Qwiklabs-Solution/main/GSP0/0/7/alinstutorial.sh

sudo chmod +x alinstutorial.sh

./alinstutorial.sh
```
## When repeated text appear on cloudshell
### Press Ctrl + C and run the following command
```cmd
gcloud compute instance-templates create lb-backend-template \
   --region=Region \
   --network=default \
   --subnet=default \
   --tags=allow-health-check \
   --machine-type=e2-medium \
   --image-family=debian-11 \
   --image-project=debian-cloud \
   --metadata=startup-script='#!/bin/bash
     apt-get update
     apt-get install apache2 -y
     a2ensite default-ssl
     a2enmod ssl
     vm_hostname="$(curl -H "Metadata-Flavor:Google" \
     http://169.254.169.254/computeMetadata/v1/instance/name)"
     echo "Page served from: $vm_hostname" | \
     tee /var/www/html/index.html
     systemctl restart apache2'



gcloud compute instance-groups managed create lb-backend-group \
   --template=lb-backend-template --size=2 --zone=Zone



gcloud compute firewall-rules create fw-allow-health-check \
  --network=default \
  --action=allow \
  --direction=ingress \
  --source-ranges=130.211.0.0/22,35.191.0.0/16 \
  --target-tags=allow-health-check \
  --rules=tcp:80




gcloud compute addresses create lb-ipv4-1 \
  --ip-version=IPV4 \
  --global



gcloud compute addresses describe lb-ipv4-1 \
  --format="get(address)" \
  --global


gcloud compute health-checks create http http-basic-check \
  --port 80


gcloud compute backend-services create web-backend-service \
  --protocol=HTTP \
  --port-name=http \
  --health-checks=http-basic-check \
  --global



gcloud compute url-maps create web-map-http \
    --default-service web-backend-service


gcloud compute target-http-proxies create http-lb-proxy \
    --url-map web-map-http




gcloud compute forwarding-rules create http-content-rule \
   --address=lb-ipv4-1\
   --global \
   --target-http-proxy=http-lb-proxy \
   --ports=80
```
