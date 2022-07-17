Func searchFishingWindow($windowX, $windowY, $windowWidth, $windowHeight, $hDll)
    Local $vDC = _PixelGetColor_CreateDC($hDll)
    Local $vRegion = _PixelGetColor_CaptureRegion($vDC, 0, 0, @DesktopWidth, @DesktopHeight, $hDll)

    Local $searchX = Round($windowX + $windowWidth/2-100, -1)
    Local $searchY = Round($windowY + $windowHeight/2+305, -1)

    While _PixelGetColor_GetPixel($vDC, $searchX, $searchY, $hDll) <> 'B2A38D'
        $searchY -= 1
        If $searchY<$windowY/2 Then
            MsgBox(4096, "Ошибка", "Fishing window not found", 10)
            Exit
        EndIf
    WEnd

    Local $toTheLeft = $searchX
    While _PixelGetColor_GetPixel($vDC, $toTheLeft, $searchY, $hDll) == 'B2A38D'
            MouseMove($toTheLeft, $searchY, 0)
            $toTheLeft -= 1
    WEnd

    Local $toTheRight = $searchX
    While _PixelGetColor_GetPixel($vDC, $toTheRight, $searchY, $hDll) == 'B2A38D'
            MouseMove($toTheLeft, $searchY, 0)
            $toTheRight += 1
    WEnd

    _PixelGetColor_ReleaseRegion($vRegion)
	_PixelGetColor_ReleaseDC($vDC,$hDll)
    
    Local $hpFrom = $toTheLeft + 10
    Local $ramkaPos = [$searchY, $toTheLeft, $toTheRight, Round(($toTheRight-$toTheLeft)/2 + $toTheLeft,-1), $hpFrom, $searchY-40]
    Return $ramkaPos
EndFunc