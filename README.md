# AutoHotKey Simple Scripts

## Description
This repository contains some simple AHK scripts that associate a shortcut to an action, making your life easier while using your PC.

## About the language
**AutoHotkey** is a free and open-source custom scripting language for Microsoft Windows, primarily designed to provide easy keyboard shortcuts or hotkeys, fast macro-creation, and software automation to allow users of most computer skill levels to automate repetitive tasks in any Windows application. Tutorials and documentation on this [link](https://www.autohotkey.com/docs/v2/).

## Prerequisites
- Windows OS (I have Windows 10, don't know if it works even with the 11th)
- [AutoHotkey v2.0](https://www.autohotkey.com/download/)

## Current Scripts
1. `case_converter.ahk`: it converts a selected text in an editor to *uppercase* or *lowercase*, depending on the shortcut pressed
2. `zip-exctracter.ahk`: it automatically extract all the files from a *zip file*
   
And more to come :)

## Installation
To install the shortcut, follow these simple steps:
1. Open *AutoHotKey Dash* and select the `Compile` option.
2. **Download** the `.ahk` file and browse it on the dash.
3. Choose the destination of the `.exe` file and **convert it**.
4. **Run** the `.exe` file: 
```sh
"path\to\your\script.exe"
```

**Suggestion**: If you want to have the shortcut always available, you can add the script to the *Windows Startup Folder* (guide on [this link](https://www.dell.com/support/kbdoc/en-us/000124550/how-to-add-app-to-startup-in-windows-10#:~:text=Add%20apps%20to%20startup%20in%20Windows%2010.&text=In%20the%20Run%20command%20field,key%20to%20open%20Startup%20folder.&text=Copy%20and%20paste%20the%20app,app%20is%20added%20to%20startup.)).  
Windows will run the script at your PC startup.

## Usage
Every hotkey needs two consecutive shortcuts to be activated:  
`CTRL + A`, same for all, and then the specific shortcut for that script (see README file inside *src* directory)

## Contributions
If you would like to contribute to this project, by adding new scripts or suggesting updates on existing, feel free to fork the repository and submit a *pull request*!
