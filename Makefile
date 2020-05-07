install: ## spring cloud data flow를 런칭합니다. 
	kubectl create -f kubernetes/kafka/
	kubectl create -f kubernetes/mysql/
	kubectl create -f kubernetes/prometheus/
	kubectl create -f kubernetes/prometheus-proxy/
	kubectl create -f kubernetes/grafana/
	kubectl create -f kubernetes/skipper/
	kubectl create -f kubernetes/server/

remove: ## spring coud data flow를 제거합니다.
	kubectl delete -f kubernetes/kafka/
	kubectl delete all,pvc,secrets -l app=mysql
	kubectl delete -f kubernetes/prometheus/
	kubectl delete -f kubernetes/prometheus-proxy/
	kubectl delete all,cm,svc,secrets -l app=grafana
	kubectl delete role scdf-role
	kubectl delete rolebinding scdf-rb
	kubectl delete serviceaccount scdf-sa
	kubectl delete all,cm -l app=skipper
	kubectl delete all,cm -l app=scdf-server

create_cluster: ## cluster를 런칭합니다.
	gcloud container clusters create scdf-lab --zone asia-northeast1-a --enable-autoscaling --min-nodes 3 --max-nodes 12 --preemptible

delete_cluster: ## cluster를 제거합니다.
	gcloud container clusters delete scdf-lab --zone asia-northeast1-a 

help:
	@grep -E '^[a-zA-Z0-9._-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help
