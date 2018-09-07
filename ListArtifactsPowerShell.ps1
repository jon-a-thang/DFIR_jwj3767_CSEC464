# CSEC 464 LAB 1 Powershell Artifact Script
# jwj3767

#Run Powershell as Admin
#Get-ExecutionPolicy
#Set-ExecutionPolicy RemoteSigned

#Run Script: C:\*PATH*\ListArtifactsPowerShell.ps1

Write-Host `nComputer System Forensics Artifacts Powershell Script`n

$result = Invoke-Command -ScriptBlock {

Write-Output `n---Current_Time---
Get-Date

Write-Output `n---Time_Zone---
Get-TimeZone

Write-Output `n---PC_Uptime---
(get-date) - (gcim Win32_OperatingSystem).LastBootUpTime

Write-Output `n---OS_Version---
[environment]::OSVersion.Version

Write-Output `n---OS_Typical_Name---
(gwmi win32_operatingsystem).caption

Write-Output `n---CPU_Brand_and_Type---
Get-WmiObject Win32_Processor
#(Get-WmiObject win32_processor).Manufacturer
#(Get-WmiObject win32_processor).Name

Write-Output `n---Ram_Ammount---
[Math]::Round((Get-WmiObject -Class Win32_ComputerSystem).TotalPhysicalMemory/1GB)
#[Math]::Round((Get-WmiObject -Class Win32_ComputerSystem).TotalPhysicalMemory/1024MB)

Write-Output `n---HDD_Ammount---
(gwmi win32_diskdrive | % size)/1gb

Write-Output `n--File_System_Info----
gdr -PSProvider 'FileSystem'
#Get-PSDrive -PSProvider FileSystem

#Write-Output `n---IP_Address_of_DC---
#Get-NetIPAddress

#Write-Output `n---Hostname_and_Domain---
#gwmi win32_computersystem | ft Name, Domain
Write-Output `n---Hostname---
$env:COMPUTERNAME
#[System.Net.Dns]::GetHostName()
#(Get-WmiObject Win32_ComputerSystem).Name

Write-Output `n---Domain---
(Get-WmiObject Win32_ComputerSystem).Domain

Write-Output `n---List_Of_Users---
#Get-LocalUser
Get-WmiObject -Class Win32_UserAccount
#gwmi win32_useraccount | ft Name, SID


Write-Output `n---Start_at_Boot:_Services---
Get-Service | select -property name,starttype | where {$_.starttype -eq 'Automatic'}
#get-service | where {$_.starttype -eq 'Automatic'}

Write-Output `n---Start_at_Boot:_Programs---
Get-CimInstance Win32_StartupCommand

Write-Output `n---List_of_Scheduled_Tasks---
Get-ScheduledTask | where state -EQ 'ready'

Write-Output `n---Network---
ipconfig /all
#Get-NetIPAddress

Write-Output `n---Arp_Table---
arp -a

Write-Output `n---MAC_Address---
getmac

Write-Output `n---Routing_Table---
Get-NetRoute

Write-Output `n---Listening_Services---
Get-NetTCPConnection -State Listen

Write-Output `n---Established_Services---
Get-NetTCPConnection -State Established

Write-Output `n---DNS_Cache---
Get-DnsClientCache

Write-Output `n---Network_SMB_Shares---
Get-SmbShare

Write-Output `n---Printers---
Get-Printer

Write-Output `n---Wifi_Access_Profiles---
netsh.exe wlan show profiles

Write-Output `n---Installed_Software---
Get-WmiObject -Class Win32_Product

Write-Output `n---Process_List---
Get-Process

Write-Output `n---Driver_List---
Get-WmiObject Win32_PnPSignedDriver | ft DeviceName, Location, DriverVersion, InstallDate, DriverProviderName

Write-Output `n---List_All_Downloads_and_Documents---
Get-ChildItem -Path C:\Users\User\Downloads -Force
Get-ChildItem -Path C:\Users\User\Desktop -Force

# 3 of my own
Write-Output `n---History_of_Commands---
history

Write-Output `n---Get_List_of_all_Folders_and_Get_Path_of_a_Specific_Folder---
[Environment+SpecialFolder]::GetNames([Environment+SpecialFolder])
Write-Output `n
[Environment]::GetFolderPath("Desktop")

Write-Output `n---Get_the_Contents_and_Last_Write_Time_of_Files_in_Folder---
$deskLoc = [Environment]::GetFolderPath("Desktop")
dir $deskLoc | ft LastWriteTime, Name


#Export-Csv -Path "C:\Users\User\Desktop\artifacts.csv"
#C:\Users\User\Desktop\ListArtifactsPowerShell.ps1 | Export-Csv -Path "C:\Users\User\Desktop\artifacts.csv"
#C:\Users\User\Desktop\ListArtifactsPowerShell.ps1 | Out-File "C:\Users\User\Desktop\artifacts.csv"
}
$result | Tee-Object -file "C:\Users\User\Desktop\artifacts.csv" -Append