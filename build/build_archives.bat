::
:: Set variables
::

SET /P version= Enter the version number: 

set tempFolder=temp
set outputFolder=output

set higurashiData=HigurashiEp01_Data

set changelog=cambiamenti.txt

set readme=leggimi.txt
set readmeInstaller=leggimi_07th_mod_installer.txt
set readmeManual=leggimi_manuale.txt

set assets=sharedassets0.assets
set assetsWindows=sharedassets0.assets
set assetsLinuxMacOs=LinuxMac-GOG-MG-Steam-5.2.2f1.languagespecificassets

set output07th=onikakushi_ita_07th_mod_installer.7z
set outputWindows=onikakushi_ita_windows_%version%.7z
set outputLinuxMacOs=onikakushi_ita_macos_linux_%version%.7z


::
:: Create folders
::

rmdir /Q /S .\%tempFolder%
md .\%tempFolder%

md .\%outputFolder%


::
:: Delete old archives
::

del .\%outputFolder%\%output07th%
del .\%outputFolder%\%outputWindows%
del .\%outputFolder%\%outputLinuxMacOs%


::
:: Create 07th archive
::

robocopy ..\%higurashiData% .\%tempFolder%\%higurashiData% /E /MIR
copy ..\%changelog% .\%tempFolder%\%changelog%
copy ..\%readmeInstaller% .\%tempFolder%\%readme%

7za a .\%outputFolder%\%output07th% .\%tempFolder%\* -ssw -mx9


::
:: Initialize common manual archive
::

del .\%tempFolder%\%readme%

copy ..\%readmeManual% .\%tempFolder%\%readme%


::
:: Create Windows manual archive
::

del .\%tempFolder%\%higurashiData%\%assets%
del .\%tempFolder%\%higurashiData%\%assetsWindows%
del .\%tempFolder%\%higurashiData%\%assetsLinuxMacOs%

copy ..\%higurashiData%\%assetsWindows% .\%tempFolder%\%higurashiData%\%assets%

7za a .\%outputFolder%\%outputWindows% .\%tempFolder%\* -ssw -mx9


::
:: Create Linux/MacOS manual archive
::

del .\%tempFolder%\%higurashiData%\%assets%
del .\%tempFolder%\%higurashiData%\%assetsWindows%
del .\%tempFolder%\%higurashiData%\%assetsLinuxMacOs%

copy ..\%higurashiData%\%assetsLinuxMacOs% .\%tempFolder%\%higurashiData%\%assets%

7za a .\%outputFolder%\%outputLinuxMacOs% .\%tempFolder%\* -mx9


::
:: Remove temp files
::

rmdir /Q /S .\%tempFolder%