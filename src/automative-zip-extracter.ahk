#Requires AutoHotkey v2.0

#Include set-first-shortcut.ahk

; Activates the hotkeys only if the condition is respected
#HotIf manager.isStateActive() 

    Z::
    {
        ; Create a COM object to interact with File Explorer
        shell := ComObject("Shell.Application")

        for window in shell.Windows {
            ; Check if the window is File Explorer
            if InStr(window.FullName, "explorer.exe") {
                ; Get the selected items
                selected := window.document.SelectedItems()

                for item in selected {
                    zipPath := item.Path 

                    ; Check if the selected file has a .zip extension
                    if !InStr(zipPath, ".zip"){
                        MsgBox("All files must be .zip! Invalid file: " item.Path, , "AutoHotKey Error Message - 'Win + Z' command")
                        Exit
                    }
                }

                for item in selected {
                    ; Get the full path of the zip file
                    zipPath := item.Path 
                    
                    ; Access the zip file using Shell Namespace
                    ZipFile := shell.NameSpace(zipPath)

                    ; Check if the zip file exists
                    if (!ZipFile) {
                        MsgBox( "ZIP file not found!", "AutoHotKey Error Message - 'Win + Z' command")
                        Exit
                    }

                    ; Check if there's only one item (the folder) inside the zip
                    if (ZipFile.Items().Count() != 1) {
                        MsgBox("More that one file inside the zip (there should be only a folder)", "AutoHotKey Error Message - 'Win + Z' command")
                        Exit
                    }

                    ; Get the path of the folder inside the zip
                    filesFolderPath := ZipFile.Items().Item(0).Path
                    
                    ; Access the folder inside the zip
                    FilesFolder := shell.NameSpace(filesFolderPath)
                    if (!FilesFolder) {
                        MsgBox ("The folder inside the zip is invalid!", "AutoHotKey Error Message - 'Win + Z' command")
                        Exit
                    }

                    ; Get the destination folder where files will be extracted
                    SplitPath(zipPath, , &extractTo)  ; Get the path of the parent folder that contains the zip
                    Destination := shell.NameSpace(extractTo)

                    ; Check if the destination folder is valid
                    if !Destination {
                        MsgBox ("The destination folder is invalid!", "AutoHotKey Error Message - 'Win + Z' command")
                        Exit
                    }

                    ; Extract files from the folder inside the zip
                    for zItem in FilesFolder.Items() {
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
