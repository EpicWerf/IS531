# Gets information about a computer using the IP address. If no address is passed in, 
#   it will use the IP address of the computer running the script.
# Authors: Jackson van der Werf, Xavier Flandro, Quinn Peterson, Max Baer

# Parameters
param([string]$ip = ".")

# Functions
# Get computer information using the WMIObject commandlet
function Get_WMI_Info {
    # Call our second function
    Write-Output '____________________________________________________________________________________________'
    Write-Output 'Overall System Information'
    Write-Host 'Collecting Overall System Information'
    Get_PC_Info

    Write-Output '____________________________________________________________________________________________'
    Write-Output 'Win32_SystemBios Information'
    Write-Host 'Collecting Win32_SystemBios Information'
    Get-WmiObject -Class Win32_SystemBios -ComputerName $ip 

    Write-Output '____________________________________________________________________________________________'
    Write-Output 'Win32_Account Information'
    Write-Host 'Collecting Win32_Account Information'
    Get-WmiObject -Class Win32_Account -ComputerName $ip | Format-Table

    Write-Output '____________________________________________________________________________________________'
    Write-Output 'Win32_Fan Information'
    Write-Host 'Collecting Win32_Fan Information'
    Get-WmiObject -Class Win32_Fan -ComputerName $ip  

    Write-Output '____________________________________________________________________________________________'
    Write-Output 'Win32_PhysicalMemory Information'
    Write-Host 'Collecting Win32_PhysicalMemory Information'
    Get-WmiObject -Class Win32_PhysicalMemory -ComputerName $ip | Format-Table
    
    Write-Output '____________________________________________________________________________________________'
    Write-Output 'Win32_UserAccount Information'
    Write-Host 'Collecting Win32_UserAccount Account Information'
    Get-WmiObject -Class Win32_UserAccount -ComputerName $ip | Format-Table
    
    Write-Output '____________________________________________________________________________________________'
    Write-Output 'Win32_Group Information'
    Write-Host 'Collecting Win32_Group Information'
    Get-WmiObject -Class Win32_Group -ComputerName $ip | Format-Table
    
    Write-Output '____________________________________________________________________________________________'
    Write-Output 'Win32_IP4RouteTable Information'
    Write-Host 'Collecting Win32_IP4RouteTable Information'
    Get-WmiObject -Class Win32_IP4RouteTable -ComputerName $ip | Format-Table

    Write-Output '____________________________________________________________________________________________'
    Write-Output 'Win32_Keyboard Information'
    Write-Host 'Collecting Win32_Keyboard Information'
    Get-WmiObject -Class Win32_Keyboard -ComputerName $ip | Format-Table

    Write-Output '____________________________________________________________________________________________'
    Write-Output 'Win32_Service Information'
    Write-Host 'Collecting Win32_Service Information'
    Get-WmiObject -Class Win32_Service -ComputerName $ip | Format-Table

    Write-Output '____________________________________________________________________________________________'
    Write-Output 'Win32_Process Information'
    Write-Host 'Collecting Win32_Process Information'
    Get-WmiObject -Class Win32_Process -ComputerName $ip | Format-Table

    Write-Output '____________________________________________________________________________________________'
}

#Get specific / important information about the computer
function Get_PC_Info {
    # Pass in a computers array. This could be a list of computers, or a single computer.
    param($Computers = ".")

    # Get information about each computer in the array
    $Computers | ForEach-Object {
    
        $computerSystem = (Get-WmiObject Win32_ComputerSystem -ComputerName $_)
        $computerOS = (Get-WmiObject Win32_OperatingSystem -ComputerName $_)
        $computerCPU = (Get-WmiObject Win32_Processor -ComputerName $_)
        $computerSN = (Get-WmiObject Win32_bios -ComputerName $_) | Select-Object SerialNumber
        $computerDisk = (Get-WmiObject win32_logicaldisk -ComputerName $_) | Select-Object DeviceId, Size, FreeSpace
    
        [PSCustomObject]@{
            'PCName' = $computerSystem.Name    
            'Model' = $computerSystem.Model   
            'RAM' = "{0:N2}" -f ($computerSystem.TotalPhysicalMemory/1GB)    
            'CPU' = $computerCPU.Name    
            'OS' = $computerOS.caption   
            'SN' = $computerSN.SerialNumber
            'User' = $computerSystem.UserName 
            'Disk' = $computerDisk.DeviceId  | Format-Table | Out-String
            'Size' = $computerDisk.Size  | Format-Table | Out-String
            'Free Space' = $computerDisk.FreeSpace  | Format-Table | Out-String
        }
    }    
}

# Main
# Call each function to get system information
Get_WMI_Info > "Get_WMI_Info.txt"