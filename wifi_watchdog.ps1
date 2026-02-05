$WifiName = "TallMoose_5GEXT"
$PingTarget = "8.8.8.8"
$IntervalSeconds = 2
$LogFile = "$PSScriptRoot\wifi_log.txt"

Write-Host "Wi-Fi watchdog started..."

while ($true) {
    $ping = Test-Connection -ComputerName $PingTarget -Count 1 -Quiet

    if (-not $ping) {
        $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        Add-Content $LogFile "$timestamp - Connection lost. Reconnecting..."

        Write-Host "Connection lost. Reconnecting Wi-Fi..."

        netsh wlan disconnect | Out-Null
        Start-Sleep -Seconds 2
        netsh wlan connect name="$WifiName" | Out-Null

        Start-Sleep -Seconds 10
    }

    Start-Sleep -Seconds $IntervalSeconds
}