#!/bin/bash

open_url() {
    local URL="$1"

    if command -v xdg-open > /dev/null; then
        xdg-open "$URL"
    elif command -v gnome-open > /dev/null; then
        gnome-open "$URL"
    elif command -v open > /dev/null; then
        open "$URL"
    else
        echo "Could not detect web browser to open $URL"
    fi
}

# Check if yq is installed
if ! command -v yq &> /dev/null; then
    echo "yq is not installed. Please install it first. https://github.com/mikefarah/yq"
    exit 1
fi

# Check arguments
if [ "$#" -ne 4 ]; then
    echo "Usage: $0 /path/to/your/yaml/file http://grafana.example.com grafana-alert-id grafana-datasource-id"
    exit 1
fi

file_path="$1"
grafana_url="$2"
grafana_alert_id="$3"
grafana_datasource_id="$4"

# Check if the provided file exists
if [ ! -f "$file_path" ]; then
    echo "The provided file does not exist."
    exit 1
fi

# Extract all prom_cluster values from anywhere in the hierarchy and filter out null values
clusters=($(yq e '.. | select(has("prom_cluster")).prom_cluster' "$file_path" | grep -v '^null$'))

# Generate PromQL based on cluster values
promql=""
for cluster in "${clusters[@]}"; do
    if [ "$promql" != "" ]; then
        promql="${promql} or "
    fi
    promql="${promql}(absent(up{job=~\"node-exporter|node_exporter\",cluster=\"$cluster\"}))"
done

escaped_promql="${promql//\"/\\\"}"

alert_url="$grafana_url/alerting/$grafana_alert_id/edit?returnTo=%2Falerting%2Flist"

open_url "$alert_url"

query_url="$grafana_url/explore?orgId=1&left={\"datasource\":\"$grafana_datasource_id\",\"queries\":[{\"refId\":\"A\",\"expr\":\"$escaped_promql\",\"range\":true,\"instant\":true,\"datasource\":{\"type\":\"prometheus\",\"uid\":\"$grafana_datasource_id\"},\"editorMode\":\"code\"}],\"range\":{\"from\":\"now-1h\",\"to\":\"now\"}}"

open_url "$query_url"
