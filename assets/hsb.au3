Func _RGB2HSB($aRGB)
	Local $Min = 255, $Max = 0
    Local $HSB[3], $D, $H

	For $i = 0 To 2
		If $aRGB[$i] > $Max Then
			$Max = $aRGB[$i]
		EndIf
		If $aRGB[$i] < $Min Then
			$Min = $aRGB[$i]
		EndIf
	Next
    If $Min = $Max Then
        $HSB[0] = 0
        $HSB[1] = 0
        $HSB[2] = $Max / 255
    Else
        If $aRGB[0] = $Min Then
            $D = $aRGB[1] - $aRGB[2]
            $H = 3
        Else
			If $aRGB[1] = $Min Then
				$D = $aRGB[2] - $aRGB[0]
				$H = 5
			Else
				$D = $aRGB[0] - $aRGB[1]
				$H = 1
			EndIf
		EndIf
        $HSB[0] = ($H - ($D / ($Max - $Min))) / 6
        $HSB[1] = ($Max - $Min) / $Max
        $HSB[2] = $Max / 255
    EndIf
	$HSB[0] = Round($HSB[0] * 360)
	If $HSB[0] = 360 Then
		$HSB[0] = 0
	EndIf
	For $i = 1 To 2
		$HSB[$i] = Round($HSB[$i] * 100)
	Next
    Return $HSB
 EndFunc