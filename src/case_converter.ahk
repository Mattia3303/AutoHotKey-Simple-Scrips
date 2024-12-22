#Requires AutoHotkey v2.0

#Include C:\Documenti\Mattia\_Code\AutoHotKey\set-first-shortcut.ahk

ShowErrorMessage(shortCut){
    MsgBox("No text was selected", "AutoHotKey Error Message - '" shortCut "' command")
    Exit
}

GetSelectedText(shortCut){
    ; Copy the selected text to the CLIPBOARD
    Send "^c"
    Sleep 100
    if !ClipWait(1) ; wait up to 1 second to ensure the text is copied
    {
        ShowErrorMessage(shortCut)
    }

    ; Get the text from the clipboard
    text := A_Clipboard

    ; Check if the last character of the copied text is a newline
    if (SubStr(text, -1) = "`n" || SubStr(text, -1) = "`r") {
        ShowErrorMessage(shortCut)
    }

    ; Check if a file was copied (in the clipboard there would be the file path)
    if (FileExist(text)){
        ShowErrorMessage(shortCut)
    }

    return text
}

PasteText(text){
    ; Set the modified text in the clipboard
    A_Clipboard := text

    ; Paste the modified text
    Send "^v"
}

; Activates the hotkeys only if the condition is respected
#HotIf manager.isStateActive() 
    u::
    {
        text := GetSelectedText("'CTRL + A' -> 'U'")
        ; Convert to uppercase
        text := StrUpper(text)

        PasteText(text)

        manager.resetState()
    }


    l::
    {
        text := GetSelectedText("'CTRL + A' -> 'L'")

        ; Convert to lowercase
        text := StrLower(text)

        PasteText(text)

        manager.resetState()
    }
#HotIf 


