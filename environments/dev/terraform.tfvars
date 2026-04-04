# ──────────────────────────────────────────────────────────────────────────────
# environments/dev/terraform.tfvars
# Non-sensitive values only. Secrets are injected via GitHub Actions Secrets.
# ──────────────────────────────────────────────────────────────────────────────

location       = "West Europe"
environment    = "dev"
project_name   = "3tier"
instance_count = 2
vm_sku         = "Standard_F2"

# ssh_public_key is NOT set here — pass it with:
#   TF_VAR_ssh_public_key="$(cat ~/.ssh/id_rsa.pub)" terraform apply
