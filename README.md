# EVERTRUST IP addresses

This repository is automatically updated with EVERTRUST's CIDR ranges for whitelisting purposes. Each line represents a valid CIDR range according to [RFC 4632](https://datatracker.ietf.org/doc/html/rfc4632).

The latest version is available at all times at: https://raw.githubusercontent.com/evertrust/ip-addresses/main/ips.txt.

We recommend pulling this database every day, as we may add or remove addresses with a 48h interval.

## Third-party addresses

For conveniance purposes, this repository also keeps an index of some third-party vendor IPs lists that are regularly updated. These lists come without any guarantee and are usually tailored for EVERTRUST's software integrations.

Currently, the following lists are maintained:

- [azuread_ips.txt](./azuread_ips.txt): the list of IPs used for SCIM provisioning for Entra (formerly Azure AD)

- [betteruptime_ips.txt](./betteruptime_ips.txt): the list of IPs used for Better Uptime

- [jamf_ips.txt](./jamf_ips.txt): the list of IPs used for Jamf.

## ModSecurity ConfigMap

Generate a Kubernetes ConfigMap with one ModSecurity rule file per IP list:

```sh
mise run generate-modsecurity-configmap
```

This writes `modsecurity-rules-configmap.yaml`. The ConfigMap keys keep the service names, for example `azuread.conf`, `betteruptime.conf`, and `jamf.conf`. The root `ips.txt` list is written as `evertrust.conf`.

Set `CONFIGMAP_NAME` or pass an output path to the script to customize the generated manifest:

```sh
CONFIGMAP_NAME=my-modsecurity-rules ./scripts/generate_modsecurity_configmap.sh ./configmap.yaml
```
