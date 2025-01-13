#Requires AutoHotkey v2.0

#Include ..\lib\set-first-shortcut.ahk
#Include ..\lib\utils.ahk


GetSelectedText(shortCut){
    ; Copy the selected text to the CLIPBOARD
    Send "^c"
    Sleep 100
    if !ClipWait(1) ; wait up to 1 second to ensure the text is copied
    {
        ShowErrorMessage("No text was selected", shortCut)
    }

    ; Get the text from the clipboard
    text := A_Clipboard

    ; Check if the last character of the copied text is a newline
    if (SubStr(text, -1) = "`n" || SubStr(text, -1) = "`r") {
        ShowErrorMessage("No text was selected", shortCut)
    }

    ; Check if a file was copied (in the clipboard there would be the file path)
    if (FileExist(text)){
        ShowErrorMessage("No text was selected", shortCut)
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
        shortCut := "U"
        text := GetSelectedText(shortCut)
        ; Convert to uppercase
        text := StrUpper(text)

        PasteText(text)

        manager.resetState()
    }


    l::
    {
        shortCut := "L"
        text := GetSelectedText(shortCut)

        ; Convert to lowercase
        text := StrLower(text)

        PasteText(text)

        manager.resetState()
    }
#HotIf 


