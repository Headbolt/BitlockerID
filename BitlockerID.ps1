###############################################################################################################
#
# ABOUT THIS PROGRAM
#
#   BitlockerID.ps1
#   https://github.com/Headbolt/BitlockerID
#
#   This script was designed to Set Bitlocker Identification Field Settings
#
#	USAGE:
#			BitlockerID [Install/Uninstall] ID AllowedID's
#
#	example : 
#			BitlockerID Install MyCompanyID "MyCompanyID1,MyCompanyID2,MyCompanyID3"
#
###############################################################################################################
#
# HISTORY
#
#   Version: 1.0 - 02/03/2022
#
#   - 02/03/2022 - V1.0 - Created by Headbolt
#
###############################################################################################################
#
#   Variables
#
###############################################################################################################
#
$Path = "HKLM:\SOFTWARE\Policies\Microsoft\FVE" # Path to the Registry Key responsible for ID Fields
$IdField = "IdentificationField"
$IdFieldString = "IdentificationFieldString"
$SecondFieldString = "SecondaryIdentificationField"
#
#   Do Not Modify Below This Linw
#
$Mode=$args[0]
$Id=$args[1]
$AllowedIds=$args[2]
#
################################################################################################################
#
#   FUNCTIONS SECTION
#
###############################################################################################################
#
function Install
{
	Write-Host "Installing Settings"
	#
	if(!(Test-Path $Path))
	{
	New-Item -Path $Path -Force | Out-Null
	New-ItemProperty -Path $Path -Name $IdField -Value 1 -PropertyType "DWord" -Force | Out-Null
	New-ItemProperty -Path $Path -Name $IdFieldString -Value $Id -PropertyType "String" -Force | Out-Null
	New-ItemProperty -Path $Path -Name $SecondFieldString -Value $AllowedIds -PropertyType "String" -Force | Out-Null
	}
	else
	{
	New-ItemProperty -Path $Path -Name $IdField -Value 1 -PropertyType "DWord" -Force | Out-Null
	New-ItemProperty -Path $Path -Name $IdFieldString -Value $Id -PropertyType "String" -Force | Out-Null
	New-ItemProperty -Path $Path -Name $SecondFieldString -Value $AllowedIds -PropertyType "String" -Force | Out-Null
	}
}
#
function UnInstall
{
	Write-Host "UnInstalling Settings"
	#
	Remove-ItemProperty $Path -Name $IdField -Force -Verbose | Out-Null
	Remove-ItemProperty $Path -Name $IdFieldString -Force -Verbose | Out-Null
	Remove-ItemProperty $Path -Name $SecondFieldString -Force -Verbose | Out-Null
}
#
###############################################################################################################
#
#   END OF FUNCTION DEFENITION
#
###############################################################################################################
#
#   BEGIN PROCESSING
#
###############################################################################################################
#
if ( $Mode -eq "UnInstall" )
{
	UnInstall 
}
else
{
	Install
}
