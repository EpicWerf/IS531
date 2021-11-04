# Description: This script reads a CSV and writes out the number of rows
# Author Name: Jackson van der Werf

######## Parameters ########
param([string]$myCsvPath)

######## Functions ########
function count_rows($myCsv) {
    $rowCount = $myCsv.count
    Write-Host "There are $rowCount rows in the CSV file."
}

function count_people($myCsv) {
    foreach ($row in $myCsv) {
        $personCount += 1
    }

    write-host $personCount
}

function count_hispanic($myCsv) {
    foreach ($row in $myCsv) {
        if ($row.pcthispanic -gt 5) {
            $hispanicCount += 1
        }
    }
    write-host $hispanicCount
}

function filter_hispanic($myCsv) {
    $hispanicCsv = $myCsv | where {$_.pcthispanic -gt 5} | where {$_.count -gt 50000}
    $hispanicCsv | Select name, pcthispanic, count | Sort count -Descending
}

function names_starting_with_s($myCsv) {
    $sCsv = $myCsv | where {$_.name -like 's*'}
    $sCsv | Select name, count | Sort count
}

######## Main ########
Clear-Host
$myCsv = Import-Csv $myCsvPath
# count_rows $myCsv
# count_people $myCsv
# count_hispanic $myCsv
# filter_hispanic $myCsv
# names_starting_with_s $myCsv