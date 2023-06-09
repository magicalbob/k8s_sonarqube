# Make sure kind cluster exists
kind  get clusters 2>&1 | grep "No kind clusters found"
if [ $? -eq 0 ]
then
    envsubst < kind-config.yaml.template > kind-config.yaml
    kind create cluster --config kind-config.yaml
fi

# add metrics
kubectl apply -f https://dev.ellisbs.co.uk/files/components.yaml

# install local storage
kubectl apply -f  local-storage-class.yml

# create sonarqube namespace, if it doesn't exist
kubectl get ns sonarqube 2> /dev/null
if [ $? -eq 1 ]
then
    kubectl create namespace sonarqube
fi

# sort out persistent volume
export NODE_NAME=$(kubectl get nodes |grep control-plan|cut -d\  -f1)
envsubst < sonarqube.deploy.pv.yml.template > sonarqube.deploy.pv.yml
kubectl apply -f sonarqube.deploy.pv.yml

# create common deployment
kubectl apply -f sonarqube.yml

# check status
kubectl get all -n sonarqube
