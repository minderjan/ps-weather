
# https://openweathermap.org/forecast16 (Daily Forecast)

# Read API Key from Environment Variable
$WEATHER_KEY = $env:WEATHER_KEY

if ([string]::IsNullOrEmpty($WEATHER_KEY)) {
    Write-Host "Please define a Environment Variable with name 'WEATHER_KEY' with your api key."
} else {
    Write-Host "Your using following api key: $WEATHER_KEY"
}

function Start-App {
    
    $weather = Get-Weather-Forecast -Location "zurich" -CountryCode "ch"
    Show-Weather-Data($weather)

}

function Get-Weather-Forecast([String]$Location,[string]$CountryCode) {

    try {
        Write-Host $Location
        $url = "https://api.openweathermap.org/data/2.5/forecast?q=$($Location),$($CountryCode)&appid=$($WEATHER_KEY)"
        Write-Host "Request to: $url"
        $result = Invoke-RestMethod -Uri $url
    } catch {
        Write-Host "StatusCode:" $_.Exception.Response.StatusCode.value__ 
        Write-Host "StatusDescription:" $_.Exception.Response
    }

    return $result

}

function Show-Weather-Data($InputWeather) {
    foreach ($w in $InputWeather.list){
        Convert-FromUnixDate -UnixDate $w.dt
     }
}

function Write-Forecast($date) {
   
}

Function Convert-FromUnixDate ([int]$UnixDate) {
    [timezone]::CurrentTimeZone.ToLocalTime(([datetime]'1/1/1970').AddSeconds($UnixDate))
}


Start-App