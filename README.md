# New Relic Kubernetes(OpenShift) Logging

Welcome to the New Relic Fluent Bit Output Plugin for Kubernetes! There are only a few quick steps to getting this 
working in your cluster.

## Usage

### Deploying as Helm chart (Recommended)

* Clone this repo
* Deploy the chart using your New Relic license key: `helm install --set licenseKey=(your-license-key) ./helm/newrelic-logging`
* Check the Logging product for your logs

### Applying k8s manifests manually

* Clone this repo
* For OpenShift, add role: `oc adm policy add-scc-to-user privileged system:serviceaccount:default:newrelic-logging`
* Configure the plugin. In `new-relic-fluent-plugin.yml`:
  * Specify your New Relic license key in the value for `LICENSE_KEY`
* From this directory, run `kubectl apply -f .` on your cluster
* Check the Logging product for your logs

## Configuration notes

We default to tailing `/var/log/containers/*.log`. If you want to change what's tailed, just update the `PATH` 
value in `new-relic-fluent-plugin.yml`.

## Parsing

We currently support parsing json and docker logs. If you want more parsing, feel free to add more parsers in `fluent-conf.yml`.

Here are some parsers for your parsing pleasure. 

```
[PARSER]
    Name   apache
    Format regex
    Regex  ^(?<host>[^ ]*) [^ ]* (?<user>[^ ]*) \[(?<time>[^\]]*)\] "(?<method>\S+)(?: +(?<path>[^\"]*?)(?: +\S*)?)?" (?<code>[^ ]*) (?<size>[^ ]*)(?: "(?<referer>[^\"]*)" "(?<agent>[^\"]*)")?$
    Time_Key time
    Time_Format %d/%b/%Y:%H:%M:%S %z

[PARSER]
    Name   apache2
    Format regex
    Regex  ^(?<host>[^ ]*) [^ ]* (?<user>[^ ]*) \[(?<time>[^\]]*)\] "(?<method>\S+)(?: +(?<path>[^ ]*) +\S*)?" (?<code>[^ ]*) (?<size>[^ ]*)(?: "(?<referer>[^\"]*)" "(?<agent>[^\"]*)")?$
    Time_Key time
    Time_Format %d/%b/%Y:%H:%M:%S %z

[PARSER]
    Name   apache_error
    Format regex
    Regex  ^\[[^ ]* (?<time>[^\]]*)\] \[(?<level>[^\]]*)\](?: \[pid (?<pid>[^\]]*)\])?( \[client (?<client>[^\]]*)\])? (?<message>.*)$

[PARSER]
    Name   nginx
    Format regex
    Regex ^(?<remote>[^ ]*) (?<host>[^ ]*) (?<user>[^ ]*) \[(?<time>[^\]]*)\] "(?<method>\S+)(?: +(?<path>[^\"]*?)(?: +\S*)?)?" (?<code>[^ ]*) (?<size>[^ ]*)(?: "(?<referer>[^\"]*)" "(?<agent>[^\"]*)")?$
    Time_Key time
    Time_Format %d/%b/%Y:%H:%M:%S %z
  ```   

## Legal

This project is provided AS-IS WITHOUT WARRANTY OR SUPPORT, although you can report issues and contribute to the project here on GitHub.
