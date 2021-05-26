$User = $env:UserName#Obtain name of current User
$OutputPath = "C:\Users\$user\Desktop\"#Path where backup is saved *CAN BE CHANGED*
$Profile = "Default"
$date = (Get-Date).tostring(“MM-dd-yyyy-hh-mm-ss”)
$count = 1

#----------------------------------------------------------------------------------------------------------------------------------------------------------#
New-Item -Path "$OutputPath\Bookmarks\Chrome\" -Name "$date" -ItemType "directory"
New-Item -Path "$OutputPath\Bookmarks\Edge\" -Name "$date" -ItemType "directory"
New-Item -Path "$OutputPath\Bookmarks\IE\" -Name "$date" -ItemType "directory"

Get-ChildItem "C:\Users\$User\appdata\local\Google\Chrome\User Data\$Profile\bookmarks*" | Copy-Item -Destination "$OutputPath\Bookmarks\Chrome\$date"  
#Default Path for Chrome
Get-ChildItem "C:\Users\$User\AppData\Local\Microsoft\Edge\User Data\$Profile\bookmarks*" | Copy-Item -Destination "$OutputPath\Bookmarks\Edge\$date" 
#Default Path for Edge
Copy-Item -Path "C:\Users\$User\Favorites" -Destination "$OutputPath\Bookmarks\IE\$date" -Recurse
#Default path to IE bookmarks/favorties
$Profile = "Profile " + $count
while(Test-Path -Path "C:\Users\$User\AppData\Local\Google\Chrome\User Data\$Profile\"){
    echo works!
    echo $count
    New-Item -Path "$OutputPath\Bookmarks\Chrome\$date" -Name "$Profile" -ItemType "directory"
    Copy-Item -Path "C:\Users\$User\AppData\Local\Google\Chrome\User Data\$Profile\bookmarks*" -Destination "$OutputPath\Bookmarks\Chrome\$date\$Profile" 


    $count = $count + 1
    $Profile = "Profile " + $count
}#Checks to see if there are other profiles for chrome
$count = 1
$Profile = "Profile " + $count
while(Test-Path -Path "C:\Users\$User\AppData\Local\Microsoft\Edge\User Data\$Profile\"){
    echo works!
    echo $count
    New-Item -Path "$OutputPath\Bookmarks\Edge\$date" -Name "$Profile" -ItemType "directory"
    Copy-Item -Path "C:\Users\$User\AppData\Local\Microsoft\Edge\User Data\$Profile\bookmarks*" -Destination "$OutputPath\Bookmarks\Chrome\$date\$Profile"


    $count = $count + 1
    $Profile = "Profile " + $count
}#Checks to see if there are other profiles for chrome
