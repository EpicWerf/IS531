Get-ChildItem
Get-Process
Get-Service
Get-TimeZone
$a = 1 + 1
$a
$a | Get-Member
$b = 'swag'
$b
$b | Get-Member
Get-ChildItem | Get-Member
Get-ChildItem
$a = Get-ChildItem
$a | Get-Member
$a.Count
$a[115]

#Finding other directories
Get-Help Get-ChildItem -Examples
Get-ChildItem C:\Windows
Get-ChildItem -Path C:\Windows

#Using Aliases
Get-Alias -Definition Get-ChildItem
Get-Alias ls
Get-Alias
Set-Alias Goku2 Get-ChildItem
Goku2

#String Basics pt 2
$name = "Jackson"
$name
Write-Host $name
Write-Host "My name is $name"
"My name is $name"
$name | Get-Member
$name.Substring(0,4)
$name.Substring(2,4)
$name.Substring(2)

#comparisons -eq -ne -lt -gt
2 -eq 2
2 -eq 1
$name.ToUpper() -eq "JACKSON"
$name.ToUpper() -ne "JACKSON"

#numbers
1..10
10..99
1..10 | foreach {$_ * 2} # $_ means for each item in array
"*"*5
"ho"*5
1..10 | foreach {"*"*$_}
Get-ChildItem | foreach {$size = $size + $_.Length}
$size
$size = 0; Get-ChildItem | foreach {$size = $size + $_.Length}; $size
$size = 0; Get-ChildItem C:\Windows\System32 | foreach {$size = $size + $_.Length}; $size

#Filtering Data
(Get-ChildItem)[0] #() to make an array from the result
Get-Process | Sort -Property CPU -Descending
(Get-Process | Sort -Property CPU -Descending)[0] # Get just the first item
Get-Process | Sort -Property CPU -Descending | Select -First 5 # Get first 5 items
Get-Process | where {$_.ProcessName -eq "Code"}
Get-Process | where {$_.ProcessName -eq "RuntimeBroker"} | sort -Property CPU -Descending
Get-Process | where ProcessName -eq "Code"

Get-ChildItem C:\Windows | Sort -Property Length -Descending | select -First 5
$size = 0; Get-ChildItem C:\Windows | foreach {$size = $size + $_.Length}; $size

#filter by columns 
Get-Process | Select -Property ProcessName, CPU -First 5
(Get-Process notepad)[0].Kill()

#Formatting
gci | Format-List
gci | ConvertTo-Html > section2.html

#export to a csv
gci | Export-Csv section2.csv

#import from a csv
Import-Csv .\Census1000.csv | Format-Table | Select -First 7
$census = Import-Csv .\Census1000.csv
$census | Select name, pcthispanic | Sort pcthispanic -Descending | Select -First 10
$census | Select name, pctwhite | Sort pctwhite | Select -First 10

#Arrays / Dictionaries
$strComputers = @("Server 1", "Server 2", "Server 3")
$strComputers += @("Server 4")
$strComputers[3]
$moreComputers = @("Desktop 1", "Desktop 2")
$allComputers = $strComputers + $moreComputers
$allComputers | foreach {"name: " + $_ + " length: " + $_.Length}