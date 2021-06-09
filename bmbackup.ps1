#$OutputPath = Read-Host "Please specify the output path. Ex: H:\"#Path where backup is saved *CAN BE CHANGED*
Do {
#Prompts user where to save their bookmarks
$OutputPath = Read-Host 'Please specify the output path. Ex: H:\'

#Checks to see if the output exists
If (!(Test-Path $OutputPath)) {
    "Path does not exist. Please try again."
} 

#ends the loop if the file path exists
} Until (Test-Path $OutputPath)


#ask user to enter their account username
$User = Read-Host 'Please enter the account username (Ex: cc102020) or press ENTER to obtain current logged in username'

if($User -eq ''){
$User = $env:UserName#Obtains name of current User
}


$Profile = "Default"
$date = (Get-Date).tostring(“MM-dd-yyyy-hh-mm-ss”)
$count = 1

#----------------------------------------------------------------------------------------------------------------------------------------------------------#
New-Item -Path "$OutputPath\Bookmarks\Chrome\" -Name "$date" -ItemType "directory"
New-Item -Path "$OutputPath\Bookmarks\Edge\" -Name "$date" -ItemType "directory"
New-Item -Path "$OutputPath\Bookmarks\IE\" -Name "$date" -ItemType "directory"

Copy-Item -Path "C:\Users\$User\appdata\local\Google\Chrome\User Data\$Profile\bookmarks*" -Destination "$OutputPath\Bookmarks\Chrome\$date"  
#Default Path for Chrome
Copy-Item -Path "C:\Users\$User\AppData\Local\Microsoft\Edge\User Data\$Profile\bookmarks*"  -Destination "$OutputPath\Bookmarks\Edge\$date" 
#Default Path for Edge





Copy-Item -Path "C:\Users\$User\Favorites" -Destination "$OutputPath\Bookmarks\IE\$date" -Recurse
#Default path to IE bookmarks/favorties
$Profile = "Profile " + $count
while(Test-Path -Path "C:\Users\$User\AppData\Local\Google\Chrome\User Data\$Profile\"){

    New-Item -Path "$OutputPath\Bookmarks\Chrome\$date" -Name "$Profile" -ItemType "directory"
    Copy-Item -Path "C:\Users\$User\AppData\Local\Google\Chrome\User Data\$Profile\bookmarks*" -Destination "$OutputPath\Bookmarks\Chrome\$date\$Profile" 


    $count = $count + 1
    $Profile = "Profile " + $count
}#Checks to see if there are other profiles for Chrome
$count = 1
$Profile = "Profile " + $count
while(Test-Path -Path "C:\Users\$User\AppData\Local\Microsoft\Edge\User Data\$Profile\"){

    New-Item -Path "$OutputPath\Bookmarks\Edge\$date" -Name "$Profile" -ItemType "directory"
    Copy-Item -Path "C:\Users\$User\AppData\Local\Microsoft\Edge\User Data\$Profile\bookmarks*" -Destination "$OutputPath\Bookmarks\Chrome\$date\$Profile"


    $count = $count + 1
    $Profile = "Profile " + $count
}#Checks to see if there are other profiles for Edge
