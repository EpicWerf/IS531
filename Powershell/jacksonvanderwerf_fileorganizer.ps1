########EXAMPLE 1###################
#Program Description: move files from one folder to another.
#Author: Degan Kettles, Co-Author: Jackson van der Werf
#Use this command to test: .\Example1.ps1 -source  C:\Users\Jackson\Documents\GitHub\IS531\Powershell\mySource -destination C:\Users\Jackson\Documents\GitHub\IS531\Powershell\myDestination


#PARAMETERS TO PROGRAM
param($source,$destination)


#FUNCTIONS
function Test-Folder {
    param($folder,[switch]$create)

    #make the folder if the create switch is true.  Can also do: if ($create) {}
    if ($create -eq $true) {
        Write-Host "Testing for $folder and creating if necessary"
        $result = Test-Path -Path $folder
        if ($result -eq $false) {
            New-Item -Path $folder -ItemType "directory"
        }  
    }

    $result = Test-Path -Path $folder
    
    #exit program if folder is not found
    #note, you can use $false or just if ($result) or (!$result)
    if ($result -eq $false) {
        Write-Host "File Folder Not Found, Exiting program"
        Exit
    }
}


function Get-FolderStats {
    param($folder)

    #announce name of folder
    Write-Host "Folder Stats is analyzing: $folder"


    #determine file count
    $files = Get-ChildItem -File $folder.FullName
    $count = $files.count
    Write-Host "File count: $count"
    
    #Determine size
    $size=0;$files | foreach {$size = $size + $_.Length}
    Write-Host "File summary size is: $size"
}

#MAIN
Test-Folder -folder $source
Test-Folder -folder $destination -create

#move each file to destination
$filelist = Get-ChildItem $source
$filelist | foreach {
    $destfolder = $destination + "\" +  $_.Extension.Substring(1)
    Test-Folder $destfolder -create
    #Copy-Item -Path $_.FullName -Destination $fulldestination
    Move-Item -Path $_.FullName -Destination $destfolder
}

#check folder stats
$folderlist = Get-ChildItem -Directory $destination
$folderlist | foreach {
    Get-FolderStats $_
}
