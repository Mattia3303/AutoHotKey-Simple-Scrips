@echo off

REM Verify that no parameters have been passed
if "%~1" NEQ "" (
    echo Error: You should not pass any parameters to this script.
    echo Usage: compile_all.cmd
    exit /b 1
)

REM Source directory
set SRC_DIR=src

REM Check if the source directory exists
if not exist "%SRC_DIR%" (
    echo Error: The directory "%SRC_DIR%" does not exist.
    exit /b 1
)

REM Loop through all .ahk files in the SRC directory
for %%F in ("%SRC_DIR%\*.ahk") do (
    echo -----------------------------------

    REM Call the compile script
    call compile-script.cmd "%%~nF"

    REM Capture the error level from the previous call
    set "LAST_ERRORLEVEL=%errorlevel%"

    REM Check for success
    if "%LAST_ERRORLEVEL%" neq "0" (
        exit /b 1
    )
)

exit /b 0
