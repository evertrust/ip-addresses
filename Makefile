.PHONY: update-azuread update

all: update push

update-azuread: ## Fetch Azure Active Directory IPs and store them in azuread_ips.txt
	./scripts/update_azuread.sh

update-jamf: ## Fetch Jamf IPs and store them in jamf_ips.txt
	./scripts/update_jamf.sh

update-betteruptime: ##Fetch Better Uptime IPs and store them in betteruptime_ips.txt
	./scripts/update_betteruptime.sh

update: update-azuread update-jamf update-betteruptime ## Fetch all third-party IPs and store them in files

push:
	git add .
	git diff --quiet && git diff --staged --quiet || git commit -am "Beep. Bop. Automated update."
	git push
