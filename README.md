# New Relic Kubernetes(OpenShift) Logging

Welcome to the New Relic Fluent Bit Output Plugin for Kubernetes! There are only a few quick steps to getting this 
working in your cluster.

## Usage

### Applying k8s manifests manually

* Clone this repo
* Configure the plugin. In `new-relic-fluent-plugin.yml`:
  * Specify your New Relic license key in the value for `LICENSE_KEY`
* From this directory, run `kubectl apply -f .` on your cluster
* Check the Logging product for your logs

### Running On OpenShift

This daemonset setting mounts /var/log as service account newrelic-logging so you need to run containers as privileged container. Here is command example:

```
oc create namespace newrelic
oc apply -f rbac.yaml
oc adm policy add-scc-to-user privileged system:serviceaccount:default:newrelic-logging
oc adm policy add-cluster-role-to-user cluster-reader system:serviceaccount:default:newrelic-logging
oc apply -f fluent-conf.yml
oc apply -f new-relic-fluent-plugin.yml

```

## Configuration notes

We default to tailing `/var/log/containers/*.log`. If you want to change what's tailed, just update the `PATH` 
value in `new-relic-fluent-plugin.yml`.

## Parsing

We currently support parsing json and docker logs. If you want more parsing, feel free to add more parsers in `fluent-conf.yml`.

## Legal

This project is provided AS-IS WITHOUT WARRANTY OR SUPPORT, although you can report issues and contribute to the project here on GitHub.
