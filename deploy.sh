# NOTE - fibonacci-api is used instead of fibonacci-server cos thats how we used it in original fibonacci project
# Want to use same docker hub image so used that 
# build & tag our current images
# tag it twice, once for the image and once with the git sha attached
# with the git sha we always have a unique build so k8s can pick up that the image is different
# Also useful as we can check out git repo using the sha to see code as it was at that point in time
docker build -t eoinwhelan64/fibonacci-client:k8s -t eoinwhelan64/fibonacci-client:$GIT_SHA ./client
docker build -t eoinwhelan64/fibonacci-api:k8s -t eoinwhelan64/fibonacci-api:$GIT_SHA ./server
docker build -t eoinwhelan64/fibonacci-worker:k8s -t eoinwhelan64/fibonacci-worker:$GIT_SHA ./worker
# Push up to HUB, the k8s version
docker push eoinwhelan64/fibonacci-client:k8s
docker push eoinwhelan64/fibonacci-api:k8s
docker push eoinwhelan64/fibonacci-worker:k8s
# do another push for the sha version of the images
# We'll actually be deploying this 
docker push eoinwhelan64/fibonacci-client:$GIT_SHA
docker push eoinwhelan64/fibonacci-api:$GIT_SHA
docker push eoinwhelan64/fibonacci-worker:$GIT_SHA
# Apply them with kubectl
# Travis will have kubectl set up by this poit, so this works
kubectl apply -f k8s 
# make sure its the latest image, in my case always
# make it be k8s version so not really necessary
# we're kinda telling it here to always use k8s version, still imperative
# so serves same purpose of forcing an imperative command in our deployment

# VERY IMPORTANT 
# Know we are deploying k8s version of app on google CLOUD
# we deploy regular version to AWS. 
# Currently only using SHA with gcp, so any image commits with that on hub are k8s version
# TODO - find out if can sub tag images, eg eoinwhelan64/fibonacci-client:k8s.v1 etc, can prob just do k8s_$GIT_SHA as partial step
kubectl set image deployments/server-deployment server=eoinwhelan64/fibonacci-api:$GIT_SHA
kubectl set image deployments/client-deployment client=eoinwhelan64/fibonacci-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=eoinwhelan64/fibonacci-worker:$GIT_SHA