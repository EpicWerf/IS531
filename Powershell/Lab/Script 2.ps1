# Gets information about a computer
# Authors: Jackson van der Werf

# Parameters
param([string]$ip = ".")

# Functions
# create a function to get bios information for the $ip variable
function get_computer_info {
    Write-Host '______________________________________________'
    Write-Host 'Bios Information'
    Get-WmiObject -Class Win32_BIOS -ComputerName $ip | Format-Table
    Get-WmiObject -Class Win32_Service -ComputerName $ip | Format-Table
    # Get-WmiObject -Class Win32_PROCESS -ComputerName $ip | Format-Table
    # Get-WmiObject -Class Win32_ACCOUNT -ComputerName $ip | Format-Table
    # Get-WmiObject -Class Win32_PRODUCT -ComputerName $ip  | Format-Table
}

# Main
get_computer_info > Add-Item newfile.docx