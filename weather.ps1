
# https://openweathermap.org/forecast5

function Start-App {
    Get-Weather-Forecast("Zürich", "CH");
}


function Get-Weather-Forecast([String]$Location, [string]$CountryCode) {
 
    $weather_data = Invoke-RestMethod -Uri "https://samples.openweathermap.org/data/2.5/forecast?q=$($Location),$($CountryCode)&appid=b6907d289e10d714a6e88b30761fae22"

    foreach ($w in $weather_data.list){
        Convert-FromUnixDate($w.dt)
     }

}

Function Convert-FromUnixDate ([int]$UnixDate) {
    [timezone]::CurrentTimeZone.ToLocalTime(([datetime]'1/1/1970').AddSeconds($UnixDate))
 }

Start-App