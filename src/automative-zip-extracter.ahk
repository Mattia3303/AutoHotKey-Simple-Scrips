#Requires AutoHotkey v2.0

#Include ..\lib\set-first-shortcut.ahk
#Include ..\lib\utils.ahk


; Activates the hotkeys only if the condition is respected
#HotIf manager.isStateActive() 

    Z::
    {
        shortCut := "Z"
        ; Create a COM object to interact with File Explorer
        shell := ComObject("Shell.Application")

        for window in shell.Windows {
            ; Check if the window is File Explorer
            if InStr(window.FullName, "explorer.exe") {
                ; Get the selected items
                selected := window.document.SelectedItems()

                ; Show error message if no items are selected
                if !selected.Count {
                    ShowErrorMessage("No files selected!", shortCut)
                }

                for item in selected {
                    zipPath := item.Path 

                    ; Check if the selected file has a "zip" extension
                    if !checkExtension(zipPath, "zip") {
                        ShowErrorMessage("All files must be .zip! Invalid file: " item.Path, shortCut)
                    }
                }

                for item in selected {
                    ; Get the full path of the zip file
                    zipPath := item.Path 

                    ; Access the zip file using Shell Namespace
                    ZipFile := shell.NameSpace(zipPath)

                    ; Check if the zip file exists
                    if (!ZipFile) {
                        ShowErrorMessage("ZIP file not found!", shortCut)
                    }

                    ; Get the destination folder where files will be extracted
                    SplitPath(zipPath, , &extractTo)  ; Get the path of the parent folder that contains the zip
                    Destination := shell.NameSpace(extractTo)

                    ; Check if the destination folder is valid
                    if !Destination {
                        ShowErrorMessage("The destination folder is invalid!", shortCut)
                    }

                    ; Extract all files from the zip
                    for zItem in ZipFile.Items() {
                        Destination.CopyHere(zItem)
                    }

                    ; Delete the original zip file after extraction
                    FileDelete(zipPath)
                }
            }
        }

        manager.resetState()
    }

#HotIf
