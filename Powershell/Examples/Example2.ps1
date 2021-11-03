########EXAMPLE 2###################
# parameters
param([string]$source="C:\", [string]$destination="c:\temp")

#functions
Function Test-Folder([string]$filepath, [switch]$create = $false){   
    #check to see if folder exists
    $exists = Test-Path $filepath

    if(!$exists -and $create){
        #create the directory
        mkdir $filepath

        #update exists
        $exists = Test-Path $filepath
    }

    return $exists
}

Function Get-FolderStats([string]$dir){
    #get the set of file objects in the directory
    $files = dir $dir -Recurse |  where -Property PSIsContainer -eq $false

    #create the stats to emit
    $stats = "" | Select dirname, filecount, bytecount
    $stats.dirname = $dir
    $stats.filecount = $files.Count
    $stats.bytecount = ($files | Measure-Object -Property Length -Sum).Sum

    return $stats
}


#Main processing
Write-Host "Source - $source"
Write-Host "Destination - $destination"

#check to see if source folder exists - if not, quit program
$exists = Test-Folder $source
if(!$exists){
    Write-Host "source path not found - $source" -ForegroundColor Red
    Exit
}

#check to see if destination folder exists - if not, create it
$exists = Test-Folder $destination -create
if(!$exists){
    Write-Host "destination path not found or could not be created - $destination" -ForegroundColor Red
    Exit
}

#create destination folders with the names of all unique file extensions
$extensions = dir -Path $source -Recurse | where -Property PSIsContainer -eq $false | sort -Property Extension -Unique
foreach($extension in $extensions){
    $a = $extension.Extension.Replace(".","")
    Test-Folder "$destination\$a" -create
}

#Move the files and print out a message when moving
$files = dir -Path $source -Recurse | where -Property PSIsContainer -eq $false
foreach($file in $files){
    $destinationFolder = "$destination\$($file.Extension.Replace('.',''))"
    Write-Host "Moving $($file.FullName) to $destinationFolder"
    move $file.FullName -Destination $destinationFolder
}

#display the destination folders and their stats
$destinationSubFolders = dir $destination -recurse | where -Property PSIsContainer -eq $true
$table = @()
foreach($subFolder in $destinationSubFolders){
   $table += Get-FolderStats $subFolder.Fullname
}
$table | sort -Property filecount -Descending

