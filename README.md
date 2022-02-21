# az-sandbox
Azure Sandbox, PowerShell, az cli, Terraform etc

# PowerShell
## Install PowerShell 7.2
https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows?view=powershell-7.2

## Connect to subscription
Connect
```shell
Connect-AzAccount
```

Get subscriptions
```shell
Get-AzSubscription
```

Set active subscription
```shell
Set-AzContext -Subscription '00000000-0000-0000-0000-000000000000'
```

## Resource Groups
```shell
Get-AzResourceGroup
New-AzResourceGroup -Name example-vms -Location westeurope
Get-AzResource -ResourceGroupName example-vms
```

## Azure VM
Create new VM
```shell
New-AzVm -ResourceGroupName example-vms -Name "example-vm-westeu-01" -Credential (Get-Credential) -Location "westeurope" -Size 'Standard_B1ls' -Image UbuntuLTS -OpenPorts 22 -PublicIpAddressName "testvm-01"
```

Show VM
```shell
$vm = (Get-AzVM -Name "example-vm-westeu-01" -ResourceGroupName "example-vms")
$vm
$vm.HardwareProfile

Get-AzPublicIpAddress -ResourceGroupName "example-vms" -Name "testvm-01"
```

Destroy VM
```shell
Stop-AzVM -Name $vm.Name -ResourceGroupName $vm.ResourceGroupName
Remove-AzVM -Name $vm.Name -ResourceGroupName $vm.ResourceGroupName
```

List remaining resources
```shell
Get-AzResource -ResourceGroupName $vm.ResourceGroupName | Format-Table
```

Delete remaining resources
```shell
$vm | Remove-AzNetworkInterface -Force
Get-AzDisk -ResourceGroupName $vm.ResourceGroupName -DiskName $vm.StorageProfile.OSDisk.Name | Remove-AzDisk -Force
Get-AzVirtualNetwork -ResourceGroupName $vm.ResourceGroupName | Remove-AzVirtualNetwork -Force
Get-AzNetworkSecurityGroup -ResourceGroupName $vm.ResourceGroupName | Remove-AzNetworkSecurityGroup -Force
Get-AzPublicIpAddress -ResourceGroupName $vm.ResourceGroupName | Remove-AzPublicIpAddress -Force
```

# az cli
## Connect to subscription
Login and set subscription
```shell
az login
az account list
az account set --subscription mySubscriptionId
```

List locations
```shell
az account list-locations -o table
```

# Terraform
Fix DNS issue (https://github.com/microsoft/WSL/issues/8022) run below script 
```shell
sudo bash -c "sed -i '/management.azure.com/d' /etc/hosts" ; sudo bash -c 'echo "$(dig management.azure.com | grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}$") management.azure.com" >> /etc/hosts'
```