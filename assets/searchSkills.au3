Func searchSkills($windowHor, $windowVer, $windowHeight, $vDC, $hDll)

   Local $searchHor = $windowHor + 380
   Local $searchVer = $windowVer + $windowHeight + 30 - 40
   Local $horizontalMax = $searchHor + 150

   While $searchHor < $horizontalMax
	  $lumen = _RGB2HSB(_ColorGetRGB('0x' & _PixelGetColor_GetPixel($vDC, $searchHor, $searchVer, $hDll)))[2]
		 If $lumen > 64 Then

            ;~ Просчитываем вверх
			$upward = $searchVer - 1
			$pxupward = 0
			While _RGB2HSB(_ColorGetRGB('0x' & _PixelGetColor_GetPixel($vDC, $searchHor, $upward, $hDll)))[2] > 64
			   $pxupward += 1
			   $upward   -= 1
			WEnd

            ;~ Просчитываем вниз
			$downward = $searchVer + 1
			$pxdownward = 0
			While _RGB2HSB(_ColorGetRGB('0x' & _PixelGetColor_GetPixel($vDC, $searchHor, $downward, $hDll)))[2] > 64
			   $pxdownward += 1
			   $downward   += 1
			WEnd

            ;~ Проверяем полную высоту
			$foundHeight = 1 + $pxupward + $pxdownward
			If $foundHeight == 34 Then
			   ExitLoop
			EndIf

		 EndIf
	  $searchHor += 1
   WEnd

    ;~ F2 & F3 горазонтальное расположение
    $F2Hor = $searchHor+37+15
    $F3Hor = $searchHor+74+15

    ;~ Вертикальное расположение F2 & F3
    $SkillsVerPos = $searchVer - $pxupward+1+3

    ;~ F10 Soulshots
    Global $F10Hor = $F2Hor+37*8
    Global $F10Ver = $SkillsVerPos-4

	return [ $F2Hor, $F3Hor, $SkillsVerPos, $F10Hor, $F10Ver ]
EndFunc