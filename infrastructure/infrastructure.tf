###########################################################
### Default configuration block when working with Azure ###
###########################################################
terraform {
  # Provide configuration details for Terraform
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.90"
    }
  }
  # This block allows us to save the terraform.tfstate file on the cloud, so a team of developers can use the terraform
  # configuration to update the infrastructure.
  # Link: https://learn.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage?tabs=azure-cli
  # Note.- Before using this block, is important that the resource group, storage account and container ARE DEPLOYED.
  backend "azurerm" {
    resource_group_name  = "dip-prd-master-rg"
    storage_account_name = "dipprdmasterst"
    container_name       = "dip-prd-asdlgen2-fs-config"
    key                  = "github-tst-11ss55-rg/terraform.tfstate"
    
  }
}

# provide configuration details for the Azure terraform provider
provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}


# For naming conventions please refer to:
# https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/resource-name-rules

# Get info about current user
data "azuread_client_config" "current" {}


###########################################################
###################  Resource Group #######################
###########################################################
resource "azurerm_resource_group" "rg" {
  location = var.location
  name     = "${var.default_prefix}-${var.environment}-${var.random_id}-rg"
  tags = {
    owner       = var.owner
    environment = var.environment

  }
}

# Add Ownership roles for the resource group to the list of contributors.
# Note.- Admins do not need to be added. They are already owners of the subscription, so they will inherit the ownershipt for this resource group. Otherwise there will be listed twice.
resource "azurerm_role_assignment" "roles_on_rg_for_contributors" {
  for_each = toset(var.contributors_object_ids)
  role_definition_name = "Owner" # "Owner" | "Contributor" | azurerm_role_definition.rd.name
  scope                = azurerm_resource_group.rg.id
  principal_id         = each.key
}

###########################################################
#################  Container Registry #####################
###########################################################

resource "azurerm_container_registry" "acr" {
  name                = "${var.default_prefix}${var.environment}${var.random_id}acr"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Standard"
  admin_enabled       = false
}