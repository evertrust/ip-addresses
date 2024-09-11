.PHONY: update-azuread update

all: update push

update-azuread: ## Fetch Azure Active Directory IPs and store them in azuread_ips.txt
	./scripts/update_azuread.sh

update: update-azuread ## Fetch all third-party IPs and store them in files

push:
	git diff --quiet && git diff --staged --quiet || git commit -u all -a -m "Beep. Bop. Automated update."
	git push
