.PHONY: update-azuread update

update-azuread: ## Fetch Azure Active Directory IPs and store them in azuread_ips.txt
	./scripts/update_azuread.sh

update: update-azuread ## Fetch all third-party IPs and store them in files

push:
	git add .
	git commit -m "Beep. Bop. Automated update"
	git push
