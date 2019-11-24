
# https://openweathermap.org/forecast16 (Daily Forecast)

# Read API Key from Environment Variable
$WEATHER_KEY = $env:WEATHER_KEY

if ([string]::IsNullOrEmpty($WEATHER_KEY)) {
    Write-Host "Please define a Environment Variable with name 'WEATHER_KEY' with your api key."
} else {
    Write-Host "Your using following api key: $WEATHER_KEY"
}

function Start-App {
    
    $weather = Get-Weather-Forecast("Zürich", "CH");
    Show-Weather-Data($weather)

}

function Get-Weather-Forecast([String]$Location, [string]$CountryCode, [int]$AmountDays = 5) {

    try {
        $result = Invoke-RestMethod -Uri "https://api.openweathermap.org/data/2.5/forecast?q=London,us&appid=$($WEATHER_KEY)"
    } catch {
        Write-Host "StatusCode:" $_.Exception.Response.StatusCode.value__ 
        Write-Host "StatusDescription:" $_.Exception.Response
    }

    return $result

}

function Show-Weather-Data($InputWeather) {
    foreach ($w in $InputWeather.list){
        Convert-FromUnixDate($w.dt)
     }
}

function Write-Forecast($date) {
   
}

Function Convert-FromUnixDate ([int]$UnixDate) {
    [timezone]::CurrentTimeZone.ToLocalTime(([datetime]'1/1/1970').AddSeconds($UnixDate))
}


Start-App