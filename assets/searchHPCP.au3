Func searchHPCP($windowX, $windowY, $vDC, $hDll)
	Local $hpPosX = $windowX + 160
	Local $hpPosY = $windowY + 50

    While 1
        Local $rgb = _ColorGetRGB('0x' & _PixelGetColor_GetPixel($vDC, $hpPosX, $hpPosY, $hDll))
        Local $red = $rgb[0]
        Local $green = $rgb[1]
        Local $blue = $rgb[2]
        
        If $red > 125 And $green < 60 And $blue < 50 Then
            ExitLoop
        Else
            $hpPosY += 1
        EndIf
    WEnd

    While _PixelGetColor_GetPixel($vDC, $hpPosX, $hpPosY, $hDll) <> 817964
        $hpPosX += 1
    WEnd

    While _RGB2HSB(_ColorGetRGB('0x' & _PixelGetColor_GetPixel($vDC, $hpPosX, $hpPosY, $hDll)))[2] > 50
        $hpPosY -= 1   
    WEnd

    $hpPosY = $hpPosY + 28
    $cpPosY = $hpPosY - 13

    $hpPosX = $hpPosX - 6
    $cpPosX = $hpPosX

    Local $return = [$hpPosX, $hpPosY, $cpPosX, $cpPosY]
    return $return
EndFunc