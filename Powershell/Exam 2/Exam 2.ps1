# Exam 2 Powershell Script
# This script gathers information about various Star Wars characters/planets and answers trivia questions
# Author Name: Jackson van der Werf

####### Functions #######
function GetStarWarsCharacter {
    param([string]$personid)

    $client = New-Object System.Net.WebCLient
    $json = $client.DownloadString("https://swapi.dev/api/people/$personid/")
    $character = $json | ConvertFrom-Json
    $character.height = if ($character.height -eq "unknown"){[int]0}else{[int]$character.height}
    $character.mass = if ($character.mass -eq "unknown"){[int]0}else{[int]$character.mass}
 
    return $character
}

function GetStarWarsPlanets {
    $client = New-Object System.Net.WebCLient
    $json = $client.DownloadString("https://swapi.dev/api/planets/")
    $planets = ($json | ConvertFrom-Json).results
    $planets = $planets | Select-Object -Property name,population,diameter,climate,terrain,gravity,orbital_period,rotation_period,surface_water,residents
   
    return $planets
}

####### Importing of Data #######
# Create a for loop from 1-83 that gets the character data for each character in the Star Wars API
for ($i = 1; $i -le 83; $i++) {
    $character = GetStarWarsCharacter($i)

    #add current $character to the array
    $AllCharacters += @($character)
}

$allPlanets = GetStarWarsPlanets

####### Trivia Question Code Snippets #######
function Trivia_Questions {
    #1 - What is the name of the tallest character?
    Write-Output '____________________________________________________________________________________________'
    Write-Output 'Question 1: What is the name of the tallest character?'
    $tallest = $AllCharacters | sort-object height -descending | select -first 1
    Write-Output $tallest.name

    #2 - List all female characters (and only female characters) and any relevant information about them in tabular (table format)
    Write-Output '____________________________________________________________________________________________'
    Write-Output 'Question 2: List all female characters (and only female characters) and any relevant information about them in tabular (table format)'
    $females = $AllCharacters | where {$_.gender -eq 'female'} | Format-Table
    Write-Output $females

    #3 - What is the combined known mass of all characters?
    Write-Output '____________________________________________________________________________________________'
    Write-Output 'Question 3: What is the combined known mass of all characters?'
    function sumMass($AllCharacters) {
        foreach ($person in $AllCharacters) {
            $mass += $person.mass
        }
        return $mass
    }
    $totalMass = sumMass $AllCharacters
    Write-Output $totalMass

    #4 - Which planet(s) have a frozen climate?
    Write-Output '____________________________________________________________________________________________'
    Write-Output 'Question 4: Which planet(s) have a frozen climate?'
    $frozenPlanets = ($allPlanets | where {$_.climate -eq 'frozen'}) | Format-Table | Out-String
    Write-Output $frozenPlanets

    # 5 - How many planets have a shorter day than earth? (The rotation period is specified in hours)
    Write-Output '____________________________________________________________________________________________'
    Write-Output 'Question 5: How many planets have a shorter day than earth?'
    function count_rotation_periods($allPlanets) {
        foreach ($row in $allPlanets) {
            if ($row.rotation_period -lt 24) {
                $shortCount += 1
            }
        }
        return $shortCount
    }
    $shortCount = count_rotation_periods $allPlanets
    Write-Output $shortCount
}

Trivia_Questions > 'Trivia_Answers.txt'