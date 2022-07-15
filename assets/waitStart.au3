Func waitStart($hDll)

    Local $tiempoParaBuscar = TimerInit()
    Local $relojVer = $ramkaPos[0]-59

    While TimerDiff($tiempoParaBuscar) < 70000
        Sleep(200)
        Local $watchHor = $ramkaPos[3]-30
        Local $watchHorMax = $watchHor+35
        Local $colorsLine = ''
        Local $vDC = _PixelGetColor_CreateDC($hDll)
        Local $vRegion = _PixelGetColor_CaptureRegion($vDC, 0,0,@DesktopWidth,@DesktopHeight,$hDll)
            While $watchHor < $watchHorMax
            $colorsLine = $colorsLine & _PixelGetColor_GetPixel($vDC, $watchHor, $relojVer, $hDll)
            if StringInStr($colorsLine, "DED3ADB2AA84DED3ADDED3ADA5A5A5313031A5A5A5DEDBDEDED3B5DED3B5979179") <> 0 Then
                $gameTime = TimerInit()
                return true
            EndIf
            $watchHor += 1
            WEnd
    WEnd

    return false
EndFunc