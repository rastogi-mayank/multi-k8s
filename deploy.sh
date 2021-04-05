docker build -t mayankrastogi94/multi-client:latest -t mayankrastogi94/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mayankrastogi94/multi-server:latest -t mayankrastogi94/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mayankrastogi94/multi-worker:latest -t mayankrastogi94/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mayankrastogi94/multi-client:latest
docker push mayankrastogi94/multi-server:latest
docker push mayankrastogi94/multi-worker:latest

docker push mayankrastogi94/multi-client:$SHA
docker push mayankrastogi94/multi-server:$SHA
docker push mayankrastogi94/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mayankrastogi94/multi-server:$SHA
kubectl set image deployments/client-deployment client=mayankrastogi94/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mayankrastogi94/multi-worker:$SHA