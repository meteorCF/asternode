Func searchSkills($windowX, $windowY, $windowHeight, $vDC, $hDll)

   Local $searchX = $windowX + 380
   Local $searchY = $windowY + $windowHeight + 30 - 40
   Local $XizontalMax = $searchX + 150

   While $searchX < $XizontalMax
	  $lumen = _RGB2HSB(_ColorGetRGB('0x' & _PixelGetColor_GetPixel($vDC, $searchX, $searchY, $hDll)))[2]
		 If $lumen > 64 Then

            ;~ Просчитываем вверх
			$upward = $searchY - 1
			$pxupward = 0
			While _RGB2HSB(_ColorGetRGB('0x' & _PixelGetColor_GetPixel($vDC, $searchX, $upward, $hDll)))[2] > 64
			   $pxupward += 1
			   $upward   -= 1
			WEnd

            ;~ Просчитываем вниз
			$downward = $searchY + 1
			$pxdownward = 0
			While _RGB2HSB(_ColorGetRGB('0x' & _PixelGetColor_GetPixel($vDC, $searchX, $downward, $hDll)))[2] > 64
			   $pxdownward += 1
			   $downward   += 1
			WEnd

            ;~ Проверяем полную высоту
			$foundHeight = 1 + $pxupward + $pxdownward
			If $foundHeight == 34 Then
			   ExitLoop
			EndIf

		 EndIf
	  $searchX += 1
   WEnd

    ;~ F2 & F3 горазонтальное расположение
    $F2X = $searchX+37+15
    $F3X = $searchX+74+15

    ;~ Вертикальное расположение F2 & F3
    $SkillsYPos = $searchY - $pxupward+1+3

    ;~ F10 Soulshots
    Global $F10X = $F2X+37*8
    Global $F10Y = $SkillsYPos-4

	Local $return = [ $F2X, $F3X, $SkillsYPos, $F10X, $F10Y ]
	return $return
EndFunc