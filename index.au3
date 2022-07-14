#RequireAdmin
#include <GUIConstantsEx.au3>
#include <AutoItConstants.au3>
#include <StaticConstants.au3>
#include <MsgBoxConstants.au3>
#include <array.au3>
#include "assets\_PixelGetColor.au3"
#include <Misc.au3>
#include <Color.au3>
#include <FileConstants.au3>

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
	
EndFunc
Func waitStart()
	
EndFunc

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
