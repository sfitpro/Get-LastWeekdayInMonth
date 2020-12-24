function Get-LastWeekdayInMonth {
  <#
    .SYNOPSIS
    A PowerShell function returns the last weekday in a month.

    .DESCRIPTION
    A PowerShell function returns the last weekday in a month by specifying the year and month parameters.
    If no year or month is specified, the last weekday in the current month is returned.

    .PARAMETER Month
    Specfiies the month.

    .PARAMETER Year
    Specfiies the year.

    .INPUTS
    None.

    .OUTPUTS
    None.

    .NOTES
    Created By:     Eddie Lu
    Last Update:    12/24/2020
    Version:        20201201 - first version

    .EXAMPLE
    Get-LastWeekdayInMonth

    .EXAMPLE
    Get-LastWeekdayInMonth -Month 1 -Year 2021
  #>

  [CmdletBinding()]
  Param (
    [Parameter(Position = 0)]
    [AllowNull()]
    [ValidateRange(1, 12)]
    [string]$Month,
    [AllowNull()]
    [Parameter(Position = 1)]
    [string]$Year
  )

  if ($Month -eq '' -or $Year -eq '') {
    [DateTime]$Date = [DateTime]::Now
  }
  else {
    [DateTime]$Date = $Month + '/1/' + $Year
  }

  $LastDay = [DateTime]::DaysInMonth($Date.Year, $Date.Month)
  $LastDate = [DateTime]::New($Date.Year, $Date.Month, $LastDay)

  $LastWeekdayInMonth = $LastDate

  while (@('Saturday', 'Sunday') -contains ($LastWeekdayInMonth).DayOfWeek) {
    $LastWeekdayInMonth = $LastWeekdayInMonth.AddDays(-1)
  }

  return $LastWeekdayInMonth
}

### Example 1

Write-Output "Get the last weekday in the current month"
Get-LastWeekdayInMonth

### Example 2

Write-Output "`nGet the last weekday in Jan 2021"
Get-LastWeekdayInMonth -Month 1 -Year 2021

### Example 3: run a task when today is the last weekeday in the month

Write-Output "`nRun task when today is the last weekday in the month"
# $Date = Get-LastWeekdayInMonth
# [DateTime]$Today = [DateTime]::Now

$Date = Get-LastWeekdayInMonth -Month 1 -Year 2021
[DateTime]$Today = Get-Date -Year 2021 -Month 1 -Day 29

if ($Today.Day -eq $Date.Day) {
  Write-Output "Start running the task now on $($Date.ToLongDateString())"
}
else {
  Write-Output "Task for $($Date.ToString('MMM yyyy')) will run on $($Date.ToLongDateString())"
}

