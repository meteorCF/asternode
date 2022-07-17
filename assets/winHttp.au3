#include-once

Global Const $HTTP_STATUS_OK = 200
Global Const $HTTP_PORT = 3117

Func SendToNode($SECTION, $dataArray)
    Local $jsonArray[UBound($dataArray)]
    For $i = 0 to UBound($dataArray)-1
        $jsonArray[$i] = '"' & $dataArray[$i][0] & '": ' & $dataArray[$i][1]
    Next
    Local $json = '{ ' & _ArrayToString($jsonArray, ', ') & ' }'
    ConsoleWrite($json)
    HttpPost('http://localhost:' & $HTTP_PORT & '/' & $SECTION, $json)
EndFunc

Func HttpPost($sURL, $sData = "")
    Local $oHTTP = ObjCreate("WinHttp.WinHttpRequest.5.1")
    $oHTTP.Open("POST", $sURL, False)
    If (@error) Then Return SetError(1, 0, 0)
    $oHTTP.SetRequestHeader("Content-Type", "application/json")
    $oHTTP.Send($sData)
    If (@error) Then Return SetError(2, 0, 0)
    If ($oHTTP.Status <> $HTTP_STATUS_OK) Then Return SetError(3, 0, 0)
    Return SetError(0, 0, $oHTTP.ResponseText)
EndFunc

Func HttpGet($sURL, $sData = "")
    Local $oHTTP = ObjCreate("WinHttp.WinHttpRequest.5.1")
    $oHTTP.Open("GET", $sURL & "?" & $sData, False)
    If (@error) Then Return SetError(1, 0, 0)
    $oHTTP.Send()
    If (@error) Then Return SetError(2, 0, 0)
    If ($oHTTP.Status <> $HTTP_STATUS_OK) Then Return SetError(3, 0, 0)
    Return SetError(0, 0, $oHTTP.ResponseText)
EndFunc