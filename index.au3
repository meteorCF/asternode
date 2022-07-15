#RequireAdmin
#include <GUIConstantsEx.au3>
#include <AutoItConstants.au3>
#include <StaticConstants.au3>
#include <MsgBoxConstants.au3>
#include <array.au3>
#include "assets\hsb.au3"
#include "assets\_PixelGetColor.au3"
#include "assets\searchHPCP.au3"
#include "assets\searchSkills.au3"
#include "assets\searchChat.au3"
#include "assets\searchFishingWindow.au3"
#include <Misc.au3>
#include <Color.au3>
#include <FileConstants.au3>

Global $hDll = DllOpen("gdi32.dll")
Global $isWorking = false
Global $fishingWindowFound = false
Global $fishingWinHor
Global $fishingWinVer

Func init()
	activateGame()
	if (isGameActive()) Then
		sleep(1000)
		coordRecognition()
		startFishing()
	EndIf
EndFunc
Func activateGame()
	WinActivate ( 'Asterios' )
	WinWaitActive ( 'Asterios' )
EndFunc
Func isGameActive()
   $searchName = StringInStr(WinGetTitle("[ACTIVE]"), "Asterios")
   if $searchName <> 0 Then
	   Return True
   Else
	   Return False
   EndIf
EndFunc
Func coordRecognition()	

	Local $windowPos   = WinGetPos("[ACTIVE]")
	Local $windowSize  = WinGetClientSize("[ACTIVE]")
;~ 	Передать $windowPos[0], $windowPos[1], $windowSize[0], $windowSize[1]
	
;~ 	Capture entire screen
	Local $vDC = _PixelGetColor_CreateDC($hDll)
	Local $vRegion = _PixelGetColor_CaptureRegion($vDC, 0, 0, @DesktopWidth, @DesktopHeight, $hDll)
	Local $hpcpArray = searchHPCP($windowPos[0], $windowPos[1], $vDC, $hDll)
	Local $skillsArray = searchSkills($windowPos[0], $windowPos[1], $windowSize[1], $vDC, $hDll)
	Local $chatArray = searchChat($windowPos[0], $windowPos[1], $windowSize[1], $vDC, $hDll)

	SendToNode('', [
		['hpHor', $hpcpArray[0]],
		['hpVer', $hpcpArray[1]],
		['cpHor', $hpcpArray[2]],
		['cpver', $hpcpArray[3]],
		['F2Hor', $skillsArray[0]],
		['F3Hor', $skillsArray[1]],
		['SkillsVerPos', $skillsArray[2]],
		['F10Hor', $skillsArray[3]],
		['F10Ver', $skillsArray[4]],
		['chatHor', $chatArray[0]],
		['chatVer', $chatArray[1]]
	])

	_PixelGetColor_ReleaseRegion($vRegion)
	_PixelGetColor_ReleaseDC($vDC,$hDll)
EndFunc
Func waitStart()
	
EndFunc
Func startFishing()
	Send("{F1}") ;~ Start fishing
	Sleep(1000)
	Send("{F9}") ;~ Pickup
	if $fishingWindowFound Then
		searchFishingWindow($windowPos[0], $windowPos[1], $windowSize[0], $windowSize[1], $hDll)
	Else
		Sleep(6500)
	EndIf
	if waitStart($hDll) == false Then
	;~   Пикнуть
    ;~   Run("index.exe", "", @SW_SHOWMAXIMIZED)
	EndIf
EndFunc
Func StartGUI()

	$gui = GUICreate("AsterGUI", 270, 50,@DesktopWidth-350,200)
	WinSetOnTop($gui, "", 1)
	GUISetState(@SW_SHOW, $gui)

	GUICtrlCreateLabel("Status:", 60, 15)
	Local $status = GUICtrlCreateLabel("Waiting start", 95, 15)
	Local $button = GUICtrlCreateButton("Start", 10, 10, 45, 25)
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop
			Case $button
				if $isWorking Then
					stopWork()
				Else
					init()
				EndIf
		EndSwitch
	WEnd

    GUIDelete($gui)
 EndFunc

StartGUI()

;~ Модули:
;~ 1) Граф интерфейс (+инициализация и контроль начала)
;~ Принимает:
;~ - Рыба поймана
;~ - Фатальная ошибка
;~ Отправляет:
;~ - Координаты
;~ - Изменение положения окна
;~ - Изменение размера окна
;~ - Рыбалка началась

;~ 2) Нажиматель кнопок
;~ Принимает:
;~ - Рыбалка началась
;~ - Остановиться
;~ Отправляет:
;~ - Нажато

;~ 3) Контроль HP/CP
;~ Принимает:
;~ - Начать контролировать
;~ Отправляет:
;~ - Warning

;~ 4) Контроль прогрессбара
;~ Принимает:
;~ - Начать контролировать
;~ Отправляет:
;~ - Положение

;~ 5) Контроль чата
;~ Принимает:
;~ - Начать контролировать
;~ Отправляет:
;~ - Не знаю, что-то по цветам


;~ Если есть окно астериос
;~ Распознать интерфейс
;~ Отдать данные на сервер
;~ Ожидать команд
