@echo off

:: Check the number of parameters
:: Counting
set argC=0
for %%x in (%*) do Set /A argC+=1


if "%argC%" GTR "2" (
    echo Error: Too many parameters.
    echo Usage: compile_script FILENAME [ADD_TO_STARTUP] [RUN_SCRIPT]
    exit /b 1
)


REM Check if the optional parameters are provided
set ADD_TO_STARTUP=0
if "%argC%" GEQ "1" (
    set ADD_TO_STARTUP=%~1
)

set RUN_SCRIPT=0
if "%argC%" GEQ "2" (
    set RUN_SCRIPT=%~2
)


REM Validate the optional parameters
if not "%ADD_TO_STARTUP%" EQU "0" if not "%ADD_TO_STARTUP%" EQU "1" (
    echo Error: Invalid value for ADD_TO_STARTUP. It must be 0 or 1.
    exit /b 1
)
if not "%RUN_SCRIPT%" EQU "0" if not "%RUN_SCRIPT%" EQU "1" (
    echo Error: Invalid value for RUN_SCRIPT. It must be 0 or 1.
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
    call compile-script.cmd "%%~nF" %ADD_TO_STARTUP% %RUN_SCRIPT%

    REM Capture the error level from the previous call
    set "LAST_ERRORLEVEL=%errorlevel%"

    REM Check for success
    if "%LAST_ERRORLEVEL%" neq "0" (
        exit /b 1
    )
)

exit /b 0
