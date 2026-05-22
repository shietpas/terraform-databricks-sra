provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  tenant_id = var.tenant_id
}

provider "azapi" {
  subscription_id = var.subscription_id
  tenant_id = var.tenant_id
}

provider "databricks" {
  host       = "https://accounts.azuredatabricks.net"
  account_id = var.databricks_account_id
  azure_tenant_id = var.tenant_id
}

provider "databricks" {
  alias = "hub"
  host  = var.create_hub && length(module.webauth_workspace) > 0 ? module.webauth_workspace[0].workspace_url : "https://placeholder.azuredatabricks.net"
  azure_tenant_id = var.tenant_id
}

# Spoke provider (required for creating a catalog in the spoke workspace)
provider "databricks" {
  alias = "spoke"
  host  = module.spoke_workspace.workspace_url
  azure_tenant_id = var.tenant_id
}

# These blocks are not required by terraform, but they are here to silence TFLint warnings
provider "null" {}

provider "time" {}
