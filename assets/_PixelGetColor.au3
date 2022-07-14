#include <ScreenCapture.au3>
#include-once

Func _PixelGetColor_CreateDC($hDll = "gdi32.dll")
	$iPixelGetColor_MemoryContext = DllCall($hDll, "int", "CreateCompatibleDC", "int", 0)
	If @error Then Return SetError(@error,0,0)
	Return $iPixelGetColor_MemoryContext[0]
EndFunc

Func _PixelGetColor_CaptureRegion($iPixelGetColor_MemoryContext, $iLeft = 0, $iTop = 0, $iRight = -1, $iBottom = -1, $fCursor = False, $hDll = "gdi32.dll")
	$HBITMAP = _ScreenCapture_Capture("", $iLeft, $iTop, $iRight, $iBottom, $fCursor)
	DllCall($hDll, "hwnd", "SelectObject", "int", $iPixelGetColor_MemoryContext, "hwnd", $HBITMAP)
	Return $HBITMAP
EndFunc

Func _PixelGetColor_GetPixel($iPixelGetColor_MemoryContext,$iX,$iY, $hDll = "gdi32.dll")
	$iColor = DllCall($hDll,"int","GetPixel","int",$iPixelGetColor_MemoryContext,"int",$iX,"int",$iY)
	If $iColor[0] = -1 then Return SetError(1,0,-1)
	$sColor = Hex($iColor[0],6)
	Return StringRight($sColor,2) & StringMid($sColor,3,2) & StringLeft($sColor,2)
EndFunc

Func _PixelGetColor_GetPixelRaw($iPixelGetColor_MemoryContext,$iX,$iY, $hDll = "gdi32.dll")
	$iColor = DllCall($hDll,"int","GetPixel","int",$iPixelGetColor_MemoryContext,"int",$iX,"int",$iY)
	Return $iColor[0]
EndFunc

Func _PixelGetColor_ReleaseRegion($HBITMAP)
	_WinAPI_DeleteObject($HBITMAP)
EndFunc

Func _PixelGetColor_ReleaseDC($iPixelGetColor_MemoryContext, $hDll = "gdi32.dll")
	DllCall($hDll, "int", "DeleteDC", "hwnd", $iPixelGetColor_MemoryContext)
EndFunc