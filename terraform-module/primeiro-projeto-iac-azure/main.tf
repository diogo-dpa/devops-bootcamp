resource "azurerm_resource_group" "rg" {
    name = "example-hmg"
    location = "brazilsouth"
    tags = {
        Iac = "True"
    }
}