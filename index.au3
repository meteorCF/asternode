#RequireAdmin
#include <GUIConstantsEx.au3>
#include <AutoItConstants.au3>
#include <StaticConstants.au3>
#include <MsgBoxConstants.au3>
#include <array.au3>
#include "assets\winHttp.au3"
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

Func init()
	activateGame()
	if (isGameActive()) Then
		sleep(1000)
		coordRecognition()
		startFishing()
	EndIf
EndFunc
Func activateGame()
	setState('Activating window')
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

	Global $windowPos   = WinGetPos("[ACTIVE]")
	Global $windowSize  = WinGetClientSize("[ACTIVE]")
;~ 	Передать $windowPos[0], $windowPos[1], $windowSize[0], $windowSize[1]
	
;~ 	Capture entire screen
	Local $vDC = _PixelGetColor_CreateDC($hDll)
	Local $vRegion = _PixelGetColor_CaptureRegion($vDC, 0, 0, @DesktopWidth, @DesktopHeight, $hDll)
	setState('HP/CP coords')
	Local $hpcpArray = searchHPCP($windowPos[0], $windowPos[1], $vDC, $hDll)
	setState('Skills coords')
	Local $skillsArray = searchSkills($windowPos[0], $windowPos[1], $windowSize[1], $vDC, $hDll)
	setState('Chat coords')
	Local $chatArray = searchChat($windowPos[0], $windowPos[1], $windowSize[1], $vDC, $hDll)

	Local $sendData = [ _
		['hpX', $hpcpArray[0]], _
		['hpY', $hpcpArray[1]], _
		['cpX', $hpcpArray[2]], _
		['cpY', $hpcpArray[3]], _
		['F2X', $skillsArray[0]], _
		['F3X', $skillsArray[1]], _
		['SkillsYPos', $skillsArray[2]], _
		['F10X', $skillsArray[3]], _
		['F10Y', $skillsArray[4]], _
		['chatX', $chatArray[0]], _
		['chatY', $chatArray[1]] _
	]
	
	setState('Sending init coords')
	SendToNode('initCoords', $sendData)

	_PixelGetColor_ReleaseRegion($vRegion)
	_PixelGetColor_ReleaseDC($vDC,$hDll)
EndFunc
Func waitStart()
	Exit
EndFunc
Func startFishing()
	setState('Starting fishing')
	Send("{F1}")
	Sleep(1000)
	Send("{F9}")

		setState('Searching fishing window')
		$fishingWindow = searchFishingWindow($windowPos[0], $windowPos[1], $windowSize[0], $windowSize[1], $hDll)
		$fishingWindowFound = true
		
		setState('Fishing window found')
		Local $sendData = [ _
			['fishWindowY', $fishingWindow[0]], _
			['fishWindowFromX', $fishingWindow[1]], _
			['fishWindowEndX', $fishingWindow[2]], _
			['fishWindowCenter', $fishingWindow[3]], _
			['barFromX', $fishingWindow[4]], _
			['barFromY', $fishingWindow[5]] _
		]

		setState('Sending f. window coords')
		SendToNode('fishingWindow', $sendData)

		setState('Waiting')
		Sleep(4500)

	if waitStart($hDll) == false Then
	;~   Пикнуть
    ;~   Run("index.exe", "", @SW_SHOWMAXIMIZED)
	EndIf
EndFunc
Func StartGUI()
	$gui = GUICreate("AsterGUI", 270, 50, @DesktopWidth-350, 200)
	WinSetOnTop($gui, "", 1)
	GUISetState(@SW_SHOW, $gui)

	GUICtrlCreateLabel("Status:", 60, 15)
	Global $status = GUICtrlCreateLabel("Waiting start", 95, 15, 175)
	Global $button = GUICtrlCreateButton("Start", 10, 10, 45, 25)
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
Func setState($text)
	GUICtrlSetData($status, $text)
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
