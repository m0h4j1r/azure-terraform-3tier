resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  name                = "vmss-app"
  resource_group_name = var.rg_name
  location            = var.location
  sku                 = var.vm_sku
  instances           = var.instance_count
  admin_username      = var.admin_username
  upgrade_mode        = "Automatic"

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_public_key
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name    = "nic-app"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = var.app_subnet_id
    }
  }

  automatic_os_upgrade_policy {
    disable_automatic_rollback  = false
    enable_automatic_os_upgrade = true
  }

  health_probe_id = azurerm_lb_probe.app_probe.id

  tags = var.tags
}

# ─── Load Balancer (Internal) ─────────────────────────────────────────────────
resource "azurerm_lb" "app_lb" {
  name                = "lb-app"
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                          = "PrivateFrontend"
    subnet_id                     = var.app_subnet_id
    private_ip_address_allocation = "Dynamic"
  }

  tags = var.tags
}

resource "azurerm_lb_backend_address_pool" "app_pool" {
  loadbalancer_id = azurerm_lb.app_lb.id
  name            = "backendPool"
}

resource "azurerm_lb_probe" "app_probe" {
  loadbalancer_id = azurerm_lb.app_lb.id
  name            = "httpProbe"
  protocol        = "Http"
  port            = 80
  request_path    = "/health"
}

resource "azurerm_lb_rule" "app_rule" {
  loadbalancer_id                = azurerm_lb.app_lb.id
  name                           = "httpRule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "PrivateFrontend"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.app_pool.id]
  probe_id                       = azurerm_lb_probe.app_probe.id
}
