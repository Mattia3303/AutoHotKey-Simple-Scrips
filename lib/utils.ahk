#Requires AutoHotkey v2.0



/**
 * 
 * @param fileName String: the file name/path
 * @param ext String: the extension
 * @returns Integer: 1 if the file has the 'ext' extension, 0 otherwise
 */
checkExtension(fileName, ext) {
    nameLen := StrLen(fileName)
    extLen := StrLen(ext)

    if (InStr(fileName, "." . ext, 1, nameLen - extLen)) {
        return 1
    }
    else {
        return 0
    }
}


ShowErrorMessage(message, shortCut){
    MsgBox(message, "AutoHotKey Error Message - '" shortCut "' command")
    Exit
}

