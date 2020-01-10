<#
.SYNOPSIS
    Deletes specified Resource Group (default: "BasicServerTest") and all its resources.

.DESCRIPTION
    Deletes RG "BasicServerTest" (or other RG specified with $Name) and all its resources.
    REQUIRED AUTOMATION ASSETS
    	An Automation connection asset that contains the Azure service principal, by default named AzureRunAsConnection. 
   
.PARAMETER Name (optional)
    String value specifying which Resource Group to delete. Default value: "BasicServerTest".

.EXAMPLE
    DeleteResourceGroup -Name "ResourceGroupToDelete"

.NOTES
	Author: Johannes Söderberg Eriksson
	Last Updated: 1/10/2020   
#>

workflow DeleteResourceGroup {
    param (
        [parameter(Mandatory=$false)]
        [String]$Name = "BasicServerTest"
    )
        # Connect to Azure with RunAs account
        $conn = Get-AutomationConnection -Name "AzureRunAsConnection" 
        $null = Add-AzureRmAccount `
         -ServicePrincipal `
         -TenantId $conn.TenantId `
         -ApplicationId $conn.ApplicationId `
         -CertificateThumbprint $conn.CertificateThumbprint
        Write-Output "Deleting Resource Group: $Name"
        Get-AzureRmResourceGroup -Name $Name | Remove-AzureRmResourceGroup -Verbose -Force
}