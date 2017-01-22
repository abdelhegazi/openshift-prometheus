#!/bin/bash
oadm new-project prometheus --node-selector="region=infra"
oc project prometheus 
sleep 5

oc create -f prometheus-dc.yaml
oadm policy add-cluster-role-to-user cluster-reader system:serviceaccount:prometheus:default
oadm policy add-cluster-role-to-user cluster-reader system:serviceaccount:prometheus:metrics
oc create -f prometheus-service.yaml 
oc create -f prometheus-configmap.yaml
oc create -f sa-metrics.yaml
oc expose service prometheus

oadm pod-network make-projects-global nft
oadm pod-network make-projects-global wow
oadm pod-network make-projects-global prometheus
oadm pod-network make-projects-global openshift-infra

#bash prometheus-pvc-pv.sh
git clone https://github.com/waynedovey/gluster-ose.git
./gluster-ose/create-pv-pvc.sh
