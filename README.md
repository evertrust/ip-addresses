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