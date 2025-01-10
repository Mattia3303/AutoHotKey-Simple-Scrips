@echo off

:: Check the number of parameters
:: Counting
set argC=0
for %%x in (%*) do Set /A argC+=1

if "%argC%" NEQ "1" (
    echo Error: number of parameter wrong.
    echo Usage: compile_script FILENAME 
    exit /b 1
)

:: Set the file name and paths
set FILENAME=%~1
set SRC_DIR=src
set BUILD_DIR=build
set COMPILER="C:\Program Files\AutoHotkey\Compiler\Ahk2Exe.exe"

:: Check if the source file exists
if not exist "%SRC_DIR%\%FILENAME%.ahk" (
    echo Error: File "%FILENAME%.ahk" not found in "%SRC_DIR%" directory.
    exit /b 1
)

:: Check if the build dir exists
if not exist "%BUILD_DIR%" (
    echo Error: "%BUILD_DIR%" build dir non found.
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
exit /b 0