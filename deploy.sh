docker build -t peinutz/multicontainer-client:latest -t peinutz/multicontainer-client:$SHA -f ./client/Dockerfile ./client
docker build -t peinutz/multicontainer-server:latest -t peinutz/multicontainer-server:$SHA -f ./server/Dockerfile ./server
docker build -t peinutz/multicontainer-worker:latest -t peinutz/multicontainer-worker:$SHA -f ./worker/Dockerfile ./worker

docker push peinutz/multicontainer-client:latest
docker push peinutz/multicontainer-server:latest
docker push peinutz/multicontainer-worker:latest

docker push peinutz/multicontainer-client:$SHA
docker push peinutz/multicontainer-server:$SHA
docker push peinutz/multicontainer-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=peinutz/multicontainer-server:$SHA
kubectl set image deployments/client-deployment client=peinutz/multicontainer-client:$SHA
kubectl set image deployments/worker-deployment worker=peinutz/multicontainer-worker:$SHA