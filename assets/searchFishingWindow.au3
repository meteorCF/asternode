Func searchFishingWindow($windowHor, $windowVer, $windowWidth, $windowHeight, $hDll)

    Local $vDC = _PixelGetColor_CreateDC($hDll)
    Local $vRegion = _PixelGetColor_CaptureRegion($vDC, 0, 0, @DesktopWidth, @DesktopHeight, $hDll)

    Local $searchHor = $windowHor + $windowWidth/2-100
    Local $searchVer = $windowVer + $windowHeight/2+305

    While _PixelGetColor_GetPixel($vDC, $searchHor, $searchVer, $hDll) <> 'B2A38D'
        $searchVer -= 1
        If $searchVer<$windowVer/2 Then
            MsgBox(4096, "Ошибка", "Fishing window not found", 10)
            Exit
        EndIf
    WEnd

    Local $toTheLeft = $searchHor
    While _PixelGetColor_GetPixel($vDC, $toTheLeft, $searchVer, $hDll) == 'B2A38D'
            $toTheLeft -= 1
    WEnd

    Local $toTheRight = $searchHor
    While _PixelGetColor_GetPixel($vDC, $toTheRight, $searchVer, $hDll) == 'B2A38D'
            $toTheRight += 1
    WEnd

    _PixelGetColor_ReleaseRegion($vRegion)
	_PixelGetColor_ReleaseDC($vDC,$hDll)

    Global $hpFrom = $toTheLeft + 10
    Global $ramkaPos = [$searchVer, $toTheLeft, $toTheRight, ($toTheRight-$toTheLeft)/2+$toTheLeft]
EndFunc