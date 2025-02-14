@echo off
setlocal enabledelayedexpansion

:: Check the number of parameters
:: Counting
set argC=0
for %%x in (%*) do Set /A argC+=1

if "%argC%" LSS "1" (
    echo Error: Missing required parameter.
    echo Usage: compile_script FILENAME [ADD_TO_STARTUP] [RUN_SCRIPT]
    exit /b 1
)

if "%argC%" GTR "3" (
    echo Error: Too many parameters.
    echo Usage: compile_script FILENAME [ADD_TO_STARTUP] [RUN_SCRIPT]
    exit /b 1
)

:: Set the file name and paths
set FILENAME=%~1
set SRC_DIR=src
set BUILD_DIR=build
set COMPILER="C:\Program Files\AutoHotkey\Compiler\Ahk2Exe.exe"

:: Placeholder for the shell startup path
:: ----------SET YOUR OWN SHELL_STARTUP PATH-----------------------------
set SHELL_STARTUP_PATH=
:: --------------------------------------------------------------------------

:: Check if the optional parameters are provided
set ADD_TO_STARTUP=0
if "%argC%" GEQ "2" (
    set ADD_TO_STARTUP=%~2
)

set RUN_SCRIPT=0
if "%argC%" GEQ "3" (
    set RUN_SCRIPT=%~3
)

:: Validate the optional parameters
if not "%ADD_TO_STARTUP%" EQU "0" if not "%ADD_TO_STARTUP%" EQU "1" (
    echo Error: Invalid value for ADD_TO_STARTUP. It must be 0 or 1.
    exit /b 1
)
if not "%RUN_SCRIPT%" EQU "0" if not "%RUN_SCRIPT%" EQU "1" (
    echo Error: Invalid value for RUN_SCRIPT. It must be 0 or 1.
    exit /b 1
)

:: Check if the source file exists
if not exist "%SRC_DIR%\%FILENAME%.ahk" (
    echo Error: File "%FILENAME%.ahk" not found in "%SRC_DIR%" directory.
    exit /b 1
)

:: Check if the build dir exists
if not exist "%BUILD_DIR%" (
    echo Error: "%BUILD_DIR%" build dir not found.
    exit /b 1
)

:: Compile the file
echo Compiling "%SRC_DIR%\%FILENAME%.ahk" to "%BUILD_DIR%\%FILENAME%.exe"...
%COMPILER% /in "%SRC_DIR%\%FILENAME%.ahk" /out "%BUILD_DIR%\%FILENAME%.exe"

:: Check if the compilation succeeded
if %errorlevel% neq 0 (
    echo Error: Compilation failed.
    exit /b 1
)

echo Compilation successful!

:: Add to shell startup if requested
if "%ADD_TO_STARTUP%" EQU "1" (
    echo Adding "%BUILD_DIR%\%FILENAME%.exe" to shell startup...
    
    if "%SHELL_STARTUP_PATH%"=="" (
        echo Error: SHELL_STARTUP_PATH is not defined. Please set the path in the script.
        exit /b 1
    )

    :: Get the absolute path of the build directory
    for /f "delims=" %%i in ('cd') do set ABSOLUTE_BUILD_DIR=%%i\%BUILD_DIR%

    set SHORTCUT=%SHELL_STARTUP_PATH%\%FILENAME%.lnk

    :: If the shortcut is already there, it will be deleted
    if exist "!SHORTCUT!" (
        echo Shortcut "%FILENAME%.lnk" already exists. Deleting it...
        del "!SHORTCUT!"
    )

    powershell -NoProfile -Command ^
        "$ws = New-Object -ComObject WScript.Shell; " ^
        "$shortcut = $ws.CreateShortcut('!SHORTCUT!'); " ^
        "$shortcut.TargetPath = '!ABSOLUTE_BUILD_DIR!\\%FILENAME%.exe'; " ^
        "$shortcut.Save();"

    if !errorlevel! neq 0 (
        echo Error: Failed to create startup shortcut.
        exit /b 1
    )

    echo Shortcut created successfully at "!SHORTCUT!".
)

:: Run the script if requested
if "%RUN_SCRIPT%" EQU "1" (
    echo Running "%BUILD_DIR%\%FILENAME%.exe"...
    start "" "%BUILD_DIR%\%FILENAME%.exe"
)

exit /b 0