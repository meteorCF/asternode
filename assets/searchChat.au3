Func searchChat($windowHor, $windowVer, $windowHeight, $vDC, $hDll)

    Local $searchHor = $windowHor + 17
    Local $searchVer = $windowVer + $windowHeight +30 -285
    Local $verticalMax = $searchVer - 100

    While _PixelGetColor_GetPixel($vDC, $searchHor, $searchVer, $hDll) <> '7D7768'
        $searchVer -= 1
    WEnd
    While _PixelGetColor_GetPixel($vDC, $searchHor, $searchVer, $hDll) == '7D7768'
            $searchHor += 1
    WEnd

    $firstLineHor = $searchHor + 9
    $firstLineVer = $searchVer + 91

    return [ $firstLineHor, $firstLineVer ]
EndFunc