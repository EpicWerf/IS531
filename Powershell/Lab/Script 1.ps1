# PARAMS
param($csvfile, $output, [switch]$create)

# FUNCTIONS
function AD-Maker {
     param($file)

     $file | ForEach-Object{
        # Create an Active Directory User
        New-ADUser -GivenName $_.FirstName -Surname $_.LastName -Name $_.UserName

        # Obtain the SID of the user (since we set the Name of the user to be the username, the identity will match username)
        $SID = Get-ADUser -Identity $_.UserName | select SID
        $SID = Out-String -InputObject $SID 
        $SID = $SID.Substring(94).Trim()
                   
        # If a file is to be created, create a new line and then insert it into the output file
        if ($create)
        {
            # Put SAMAccountName and SID in a new row (The SAMAccountName is the same as the Username)
            $NewLine = "{0},{1}" -f $_.Username, $SID

            # Add that info to the csv
            $NewLine | add-content -path $output
        }
        
     }
}

# MAIN

# Create the output file if the create switch was passed in
if ($create)
{
    Add-Content -Path $output -Value '"SAMAccountName","SID"'
}

$mycsv = Import-CSV -Path $csvfile

AD-Maker -file $mycsv
