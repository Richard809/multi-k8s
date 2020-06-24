docker build -t richardholguing/multi-client:latest -t richardholguing/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t richardholguing/multi-worker:latest -t richardholguing/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker build -t richardholguing/multi-server:latest -t richardholguing/multi-server:$SHA -f ./server/Dockerfile ./server

docker push richardholguing/multi-client:latest
docker push richardholguing/multi-worker:latest
docker push richardholguing/multi-server:latest

docker push richardholguing/multi-client:$SHA
docker push richardholguing/multi-worker:$SHA
docker push richardholguing/multi-server:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=richardholguing/multi-server:$SHA
kubectl set image deployments/client-deployment client=richardholguing/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=richardholguing/multi-worker:$SHA