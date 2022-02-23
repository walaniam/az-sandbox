param([string]$resourceGroup)

Connect-AzAccount

$adminCredential = Get-Credential -Message "Enter a username and password for the VM administrator."

For ($i = 1; $i -le 3; $i++) {
    $vmName = "testVm-" + $i
    Write-Host "Creating VM: " $vmName
    New-AzVM -ResourceGroupName $resourceGroup -Name $vmName -Credential $adminCredential -Image UbuntuLTS -Size Standard_B1ls
}