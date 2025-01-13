@echo off

REM Verify that no required parameters are passed beyond the first optional parameter
if "%~2" NEQ "" (
    echo Error: Too many parameters.
    echo Usage: compile_all.cmd [ADD_TO_STARTUP]
    exit /b 1
)

REM Check if the optional first parameter is provided
set ADD_TO_STARTUP=0
if "%~1" NEQ "" (
    set ADD_TO_STARTUP=%~1
)

REM Validate the ADD_TO_STARTUP parameter
if not "%ADD_TO_STARTUP%" EQU "0" if not "%ADD_TO_STARTUP%" EQU "1" (
    echo Error: Invalid value for ADD_TO_STARTUP. It must be 0 or 1.
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

    REM Call the compile script with the ADD_TO_STARTUP parameter
    call compile-script.cmd "%%~nF" %ADD_TO_STARTUP%

    REM Capture the error level from the previous call
    set "LAST_ERRORLEVEL=%errorlevel%"

    REM Check for success
    if "%LAST_ERRORLEVEL%" neq "0" (
        exit /b 1
    )
)

exit /b 0
