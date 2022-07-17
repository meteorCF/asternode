Func searchChat($windowX, $windowY, $windowHeight, $vDC, $hDll)

    Local $searchX = $windowX + 17
    Local $searchY = $windowY + $windowHeight +30 -285
    Local $YMax = $searchY - 500
    Local $XMax = $searchX + 500

    While _PixelGetColor_GetPixel($vDC, $searchX, $searchY, $hDll) <> '7D7768' And $searchY > $YMax
        $searchY -= 1
    WEnd
    While _PixelGetColor_GetPixel($vDC, $searchX, $searchY, $hDll) == '7D7768' And $searchX < $XMax
            $searchX += 1
    WEnd

    $firstLineX = $searchX + 9
    $firstLineY = $searchY + 91

    Local $return = [ $firstLineX, $firstLineY ]
    return $return
EndFunc