
<#
    .SYNOPSIS
    Install Valheim Client Mods

    .DESCRIPTION
    Simple PowerShell script that downloads client mods from this GitHub repo and 
    installs them in the client's Valheim folder. Currently only for Windows installs. 

#>

#Functions
function Exit-Script {
    Read-Host "Press any key to exit script"
    exit 
}

#Prompts
#User prompt to continue
Write-Host "`nThis process will remove any current Valheim client mods you have. Do you wish to continue (Enter 'y' for Yes and 'n' for No)?" -ForegroundColor Yellow
$userPrompt = Read-Host " "
If ($userPrompt -ne "y") {
    Write-Host "- user canceled script" -ForegroundColor Red
    Exit-Script
}

#User prompt for mod selection
Do {
    $modPrompt = $null
    Write-Host "`nWhich Valheim mod would you like to install?" -ForegroundColor Yellow
    Write-Host "  (1) ValheimPlus" -ForegroundColor Magenta
    Write-Host "  (2) DevCommands" -ForegroundColor Magenta
    Write-Host "`n"
    $modPrompt = Read-Host "Enter the mumber of the selection above"
} 
Until (($modPrompt -eq 1) -or ($modPrompt -eq 2))

switch ($modPrompt) {
    1 {
        $modZipFile = "client_mod_valheimplus"
    }
    2 {
        $modZipFile = "client_mod_devcommands"
    }
    Default {
        Write-Host " - error selecting mod file" -ForegroundColor Red
        Exit-Script
    }
}

#User prompt for Valheim folder path
Do {
    #User prompt for Valheim client folder location
    Write-Host "`nEnter the folder path to your Valheim game install (may similar to example: C:\SteamLibrary\steamapps\common\Valheim)" -ForegroundColor Yellow
    $valheimClientFolderPath = Read-Host " "

    #Folder check
    $valheimClientFolderPathCheck = $false
    If ($valheimClientFolderPath -like "*\Valheim") {
        Write-Host " - folder check successful" -ForegroundColor Green
        $valheimClientFolderPathCheck = $true          
    }
    Else {
        Write-Host " - folder check failed. Please enter the correct folder path to your Valheim client install." -ForegroundColor Red
    }

    #Executable check
    $valheimClientExecutableCheck = $false
    $valheimClientExecutable = Test-Path -Path "$($valheimClientFolderPath)\valheim.exe"    
    If ($valheimClientExecutable -eq $true) {
        Write-Host " - executable check successful" -ForegroundColor Green
        $valheimClientExecutableCheck = $true          
    }
    Else {
        Write-Host " - executable check failed. Please enter the correct folder path to your Valheim client install." -ForegroundColor Red      
    }
}
Until (($valheimClientFolderPathCheck -eq $true) -and ($valheimClientExecutableCheck -eq $true))

#Download client zip from Github
Write-Host "`nDownload client mod files" -ForegroundColor Yellow
Invoke-WebRequest -Method Get -Uri "https://github.com/CityHallin/valheim/raw/main/client_mods/$($modZipFile).zip" -OutFile ".\$($modZipFile).zip"
$downloadTest = Test-Path -Path ".\$($modZipFile).zip"
If ($downloadTest -eq $false) {
    Write-Host " - client mod zip failed to download" -ForegroundColor Red
    Exit-Script
}
Else {
    Write-Host " - client mod zip downloaded" -ForegroundColor Green
}

#Backup current Valheim folder
Write-Host "`nBackup current Valheim folder" -ForegroundColor Yellow
$timestamp = Get-Date -Format "yyyy-MM-dd.HH.mm.ss"
Copy-Item -LiteralPath $valheimClientFolderPath -Destination "$($valheimClientFolderPath)_$($timestamp)"
$backupFolderCheck = Test-Path -Path "$($valheimClientFolderPath)_$($timestamp)"
If ($backupFolderCheck -eq $false) {
    Write-Host " - backup of Valheim folder failed" -ForegroundColor Red
    Exit-Script
}
Else {
    Write-Host " - backed up folder here: $($valheimClientFolderPath)_$($timestamp)" -ForegroundColor Green
}

#Copy mod files into Valheim folder
Write-Host "`nCopying mod files to client folder" -ForegroundColor Yellow
Expand-Archive -Path ".\$($modZipFile).zip" -DestinationPath ".\$($modZipFile)" -Force
Copy-Item -Path ".\$($modZipFile)\*" -Destination $valheimClientFolderPath -Recurse -Force
$modFileCheck = Test-Path -Path "$($valheimClientFolderPath)\BepInEx\plugins\ValheimPlus.dll"
If ($modFileCheck -eq $false) {
    Write-Host " - valheimplus.dll file check failed" -ForegroundColor Red
    Exit-Script
}
Else {
    Write-Host " - valheimplus.dll file check successful" -ForegroundColor Green
}

#Clean-up
Write-Host "`nClean up downloaded files" -ForegroundColor Yellow
Remove-Item -Path ".\$($modZipFile).zip" -Force
Remove-Item -Path ".\$($modZipFile)" -Recurse -Force

#Complete
Write-Host "`nScript complete" -ForegroundColor Yellow
Exit-Script