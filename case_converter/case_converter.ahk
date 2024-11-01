#Requires AutoHotkey v2.0

ShowErrorMessage(shortCut){
    MsgBox("No text was selected", "AutoHotKey Error Message - '" shortCut "' command")
}

^!U::
{
    ; Save the previous clipboard content to verify it changes after executing the CTRL + C command
    previusClipBoardText := A_Clipboard

    ; Copy the selected text to the clipboard
    Send "^c"
    Sleep 100
    if !ClipWait(1) || previusClipBoardText = A_Clipboard ; wait up to 1 second to ensure the text is copied
    {
        ShowErrorMessage("CTRL + ALT + U")
        Exit
    }

    ; Get the text from the clipboard
    text := A_Clipboard

    ; Check if the last character of the copied text is a newline
    if (SubStr(text, -1) = "`n" || SubStr(text, -1) = "`r") {
        ShowErrorMessage("CTRL + ALT + U")
        Exit
    }

    ; Convert to uppercase
    text := StrUpper(text)

    ; Set the modified text in the clipboard
    A_Clipboard := text

    ; Paste the modified text
    Send "^v"
}


^!L::
{
    ; Save the previous clipboard content to verify it changes after executing the CTRL + C command
    previusClipBoardText := A_Clipboard

    ; Copy the selected text to the clipboard
    Send "^c"
    Sleep 100
    if !ClipWait(1) || previusClipBoardText = A_Clipboard ; wait up to 1 second to ensure the text is copied
    {
        ShowErrorMessage("CTRL + ALT + U")
        Exit
    }

    ; Get the text from the clipboard
    text := A_Clipboard

    ; Check if the last character of the copied text is a newline
    if (SubStr(text, -1) = "`n" || SubStr(text, -1) = "`r") {
        ShowErrorMessage("CTRL + ALT + U")
        Exit
    }

    ; Convert to uppercase
    text := StrLower(text)

    ; Set the modified text in the clipboard
    A_Clipboard := text

    ; Paste the modified text
    Send "^v"
}


