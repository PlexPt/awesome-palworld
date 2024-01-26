$ErrorActionPreference = "Stop"

$DirectoryPath = "C:\Program Files\PalServer\"
if (Test-Path -Path $DirectoryPath) {
    Remove-Item -Path "$DirectoryPath*" -Recurse -Force
} else {
    New-Item -ItemType Directory -Path $DirectoryPath | Out-Null
}

# 下载安装 C++ 运行库
Write-Host "Start download vc_redist.x64.exe..."
$VcUrl = "https://aka.ms/vs/17/release/vc_redist.x64.exe"
$VcOutput = "C:\Program Files\PalServer\vc_redist.x64.exe"
Invoke-WebRequest -Uri $VcUrl -OutFile $VcOutput
Write-Host "Installing vc_redist.x64.exe..."
Start-Process -FilePath $VcOutput -Args '/install', '/quiet', '/norestart' -Wait
Remove-Item -Path $VcOutput

# 下载安装 DirectX 支持库
Write-Host "Start download dxwebsetup.exe..."
$DxUrl = "https://download.microsoft.com/download/1/7/1/1718CCC4-6315-4D8E-9543-8E28A4E18C4C/dxwebsetup.exe"
$DxOutput = "C:\Program Files\PalServer\dxwebsetup.exe"
Invoke-WebRequest -Uri $DxUrl -OutFile $DxOutput
Write-Host "Installing dxwebsetup.exe..."
Start-Process -FilePath $DxOutput -Args '/Q' -Wait
Remove-Item -Path $DxOutput

# 下载 Steamcmd
Write-Host "Start download steamcmd.zip..."
$StUrl = "https://steamcdn-a.akamaihd.net/client/installer/steamcmd.zip"
$StOutput = "C:\Program Files\PalServer\steamcmd.zip"
$StUnzipPath = "C:\Program Files\PalServer\steam\"
Invoke-WebRequest -Uri $StUrl -OutFile $StOutput
Expand-Archive -LiteralPath $StOutput -DestinationPath $StUnzipPath
Remove-Item -Path $StOutput

# 运行 SteamCMD 更新服务器
Write-Host "Running steamcmd.exe..."
Set-Location -Path $StUnzipPath
Start-Process ".\steamcmd.exe" -ArgumentList "+login anonymous +app_update 2394010 validate +quit" -Wait

# 设置开机自启动
Write-Host "Setting scheduled task..."
$TaskName = "PalServerAutoStart"
$TaskDescription = "Automatically starts PalServer on system startup and restarts on failure."
$TaskExecutable = "C:\Program Files\PalServer\steam\steamapps\common\PalServer\PalServer.exe"
$TaskAction = New-ScheduledTaskAction -Execute $TaskExecutable
$TaskTrigger = New-ScheduledTaskTrigger -AtStartup
$TaskPrincipal = New-ScheduledTaskPrincipal -UserId "SYSTEM" -LogonType ServiceAccount -RunLevel Highest

# 设置任务失败后的重启策略，失败后等待 1 分钟，最多尝试 3 次
$RestartInterval = New-TimeSpan -Minutes 1
$RestartCount = 3
$TaskSettings = New-ScheduledTaskSettingsSet -RestartInterval $RestartInterval -RestartCount $RestartCount
Register-ScheduledTask -TaskName $TaskName -Description $TaskDescription -Action $TaskAction -Trigger $TaskTrigger -Principal $TaskPrincipal -Settings $TaskSettings -Force | Out-Null

# 运行 PalServer
Write-Host "Running PalServer.exe..."
Start-ScheduledTask -TaskName $TaskName