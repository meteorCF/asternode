Контролим CP, HP, чат

Local $VidaHor = $hpFrom
Local $ultimo = 0
While $VidaHor < $hpFrom + 230
	$Hue = _RGB2HSB(_ColorGetRGB('0x' & _PixelGetColor_GetPixel($vDC, $VidaHor,$ramkaPos[0]-40, $hDll)))[0]
	If $ultimo == 0 Then
		$ultimo = $Hue
	Else
		If $ultimo - $Hue > 10 Then
		$ultimo = $Hue

		$VidaHor -= 1
		$Hue = _RGB2HSB(_ColorGetRGB('0x' & _PixelGetColor_GetPixel($vDC, $VidaHor,$ramkaPos[0]-40, $hDll)))[0]
		While $Hue - $ultimo < 10
			$VidaHor -= 1
			$Hue = _RGB2HSB(_ColorGetRGB('0x' & _PixelGetColor_GetPixel($vDC, $VidaHor,$ramkaPos[0]-40, $hDll)))[0]
		WEnd
		ExitLoop
		Else
		$ultimo = $Hue
		EndIf
	EndIf
	$VidaHor += 5
WEnd

$hpAhora = $VidaHor-$hpFrom