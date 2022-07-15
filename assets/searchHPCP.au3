Func searchHPCP($windowHor, $windowVer, $vDC, $hDll)
	Local $hpPosHor = $windowHor + 160
	Local $hpPosVer = $windowVer + 50

    While 1
        Local $rgb = _ColorGetRGB('0x' & _PixelGetColor_GetPixel($vDC, $hpPosHor, $hpPosVer, $hDll))
        Local $red = $rgb[0]
        Local $green = $rgb[1]
        Local $blue = $rgb[2]
        
        If $red > 125 And $green < 60 And $blue < 50 Then
            ExitLoop
        Else
            $hpPosVer += 1
        EndIf
    WEnd

    While _PixelGetColor_GetPixel($vDC, $hpPosHor, $hpPosVer, $hDll) <> 817964
        $hpPosHor += 1
    WEnd

    While _RGB2HSB(_ColorGetRGB('0x' & _PixelGetColor_GetPixel($vDC, $hpPosHor, $hpPosVer, $hDll)))[2] > 50
        $hpPosVer -= 1   
    WEnd

    $hpPosVer = $hpPosVer + 28
    $cpPosVer = $hpPosVer - 13

    $hpPosHor = $hpPosHor - 6
    $cpPosHor = $hpPosHor

    return [ $hpPosHor, $hpPosVer, $cpPosHor, $cpPosVer ]
EndFunc