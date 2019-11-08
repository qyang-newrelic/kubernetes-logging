#!/bin/bash


kubectl delete -f fluent-conf.yml
kubectl delete -f new-relic-fluent-plugin.yml
kubectl apply -f  fluent-conf.yml
kubectl apply -f  new-relic-fluent-plugin.yml
