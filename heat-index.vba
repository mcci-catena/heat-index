'
' Module: heat-index.vba
'
' Function:
'       Calculate NWS Heat Index from temperature and RH for Excel
'
' Copyright and License:
'       See accompanying LICENSE file.
'
' Author:
'       Terry Moore, MCCI Corporation
'

Option Explicit

Public Function CalculateHeatIndex(T As Double, RH As Double) As Variant
  '
  ' Calculate farenheit Heat Index per NWS formula from:
  '     https://www.wpc.ncep.noaa.gov/html/heatindex_equation.shtml
  '
  ' T is the dry-bulb (conventional) temperature, in degrees Farenheit
  ' RH is in the range [0,100] -- i.e., it's the percentage, not
  '     the fraction.
  '
  ' Result was checked against the full chart at iweathernet.com:
  '    https://www.iweathernet.com/wxnetcms/wp-content/uploads/2015/07/heat-index-chart-relative-humidity-2.png
  '
  Dim T2 As Double, RH2 As Double
  Dim Adjustment As Double
  Dim Simple As Double
  Dim vError As Variant
  vError = CVErr(xlErrValue)
  
  T2 = T * T
  RH2 = RH * RH
  
  ' it's simpler to calculate Simple outside the if, and anyway T and RH are usually in range.
  Simple = 0.5 * (T + 61# + ((T - 68#) * 1.2) + (RH * 0.094))
  
  If (T < 75.5 Or T > 126.5 Or RH < 0# Or RH > 100#) Then
    CalculateHeatIndex = vError
  ElseIf (Simple + T) / 2# < 80# Then
    CalculateHeatIndex = Simple
  Else
    CalculateHeatIndex = _
      -42.379 + 2.04901523 * T + 10.14333127 * RH - 0.22475541 * T * RH - 0.00683783 * T2 _
      - 0.05481717 * RH2 + 0.00122874 * T2 * RH + 0.00085282 * T * RH2 - 0.00000199 * T2 * RH2
    
    If RH < 13# And 80# <= T And T <= 112# Then
      Adjustment = -((13# - RH) / 4#) * Sqr((17# - Abs(T - 95#)) / 17#)
    ElseIf RH > 85# And 80# <= T And T <= 87# Then
      Adjustment = ((RH - 85#) / 10#) * ((87# - T) / 5#)
    Else
      Adjustment = 0
    End If
    
    CalculateHeatIndex = CalculateHeatIndex + Adjustment
  End If

End Function
