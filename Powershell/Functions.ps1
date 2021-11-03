# Author Name: Jackson van der Werf


#use this if it doesn't allow you to run your scripts
# Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser

# Parameters
param([string]$myname = "Dave", [switch]$ImSpecial)

# Functions
function Get-DirectoryStuff {
    param($directory)
    $directory
}


# Main
$dir = Get-ChildItem
Get-DirectoryStuff -directory $dir

Write-Host Say-Hello
Write-Host "Hello $ImSpecial"

# if ($ImSpecial)
# {
#     write-host "Hello $myname, you are special!"
# }
# else
# {
#     write-host "Hello $myname, you are not special!"
# }