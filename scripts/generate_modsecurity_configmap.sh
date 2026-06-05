#!/bin/bash
set -euo pipefail

output_file="${1:-modsecurity-rules-configmap.yaml}"
configmap_name="${CONFIGMAP_NAME:-evertrust-modsecurity-ip-rules}"
rule_id="${RULE_ID:-10000}"

join_cidrs() {
  awk '
    NF && $1 !~ /^#/ {
      if (cidrs != "") {
        cidrs = cidrs ","
      }
      cidrs = cidrs $1
    }
    END {
      printf "%s", cidrs
    }
  ' "$1"
}

append_rule() {
  local source_file="$1"
  local configmap_key="$2"
  local cidrs

  if [ ! -s "$source_file" ]; then
    echo "$source_file is empty or missing" >&2
    exit 1
  fi

  cidrs="$(join_cidrs "$source_file")"
  if [ -z "$cidrs" ]; then
    echo "$source_file does not contain any CIDR" >&2
    exit 1
  fi

  {
    printf '  %s: |\n' "$configmap_key"
    printf '    SecRule REMOTE_ADDR "!@ipMatch %s" "id:%s,phase:1,log,drop,status:444,severity:INFO"\n' "$cidrs" "$rule_id"
  } >> "$output_file"
}

{
  printf 'apiVersion: v1\n'
  printf 'kind: ConfigMap\n'
  printf 'metadata:\n'
  printf '  name: %s\n' "$configmap_name"
  printf 'data:\n'
} > "$output_file"

append_rule ips.txt evertrust.conf

for source_file in *_ips.txt; do
  service_name="${source_file%_ips.txt}"
  append_rule "$source_file" "$service_name.conf"
done
