echo $(git rev-parse HEAD)
echo $SHA
docker build -t mayankrastogi94/multi-client:$(git rev-parse HEAD) -f ./client/Dockerfile ./client
docker build -t mayankrastogi94/multi-server:$(git rev-parse HEAD) -f ./server/Dockerfile ./server
docker build -t mayankrastogi94/multi-worker:$(git rev-parse HEAD) -f ./worker/Dockerfile ./worker

docker push mayankrastogi94/multi-client:$(git rev-parse HEAD)
docker push mayankrastogi94/multi-server:$(git rev-parse HEAD)
docker push mayankrastogi94/multi-worker:$(git rev-parse HEAD)

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mayankrastogi94/multi-server:$(git rev-parse HEAD)
kubectl set image deployments/client-deployment client=mayankrastogi94/multi-client:$(git rev-parse HEAD)
kubectl set image deployments/worker-deployment worker=mayankrastogi94/multi-worker:$(git rev-parse HEAD)