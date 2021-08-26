::
:: Set variables
::

set tempFolder=temp
set outputFolder=output

set higurashiData=HigurashiEp01_Data

set changelog=cambiamenti.txt

set readme=leggimi.txt
set readmeInstaller=leggimi_07th_mod_installer.txt
set readmeManual=leggimi_manuale.txt

set assets=sharedassets0.assets
set assetsWindows=sharedassets0.assets
set assetsMacOsLinux=LinuxMac-GOG-MG-Steam-5.2.2f1.languagespecificassets

set output07th=onikakushi_ita_07th_mod_installer.7z
set outputWindows=onikakushi_ita_windows_XXX.7z
set outputMacOsLinux=onikakushi_ita_macos_linux_XXX.7z


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
del .\%outputFolder%\%outputMacOsLinux%


::
:: Create 07th archive
::

robocopy ..\%higurashiData% .\%tempFolder%\%higurashiData% /E /MIR
copy ..\%changelog% .\%tempFolder%\%changelog%
copy ..\%readmeInstaller% .\%tempFolder%\%readme%

7z a .\%outputFolder%\%output07th% .\%tempFolder%\* -ssw -mx9


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
del .\%tempFolder%\%higurashiData%\%assetsMacOsLinux%

copy ..\%higurashiData%\%assetsWindows% .\%tempFolder%\%higurashiData%\%assets%

7z a .\%outputFolder%\%outputWindows% .\%tempFolder%\* -ssw -mx9


::
:: Create MacOs/Linux manual archive
::

del .\%tempFolder%\%higurashiData%\%assets%
del .\%tempFolder%\%higurashiData%\%assetsWindows%
del .\%tempFolder%\%higurashiData%\%assetsMacOsLinux%

copy ..\%higurashiData%\%assetsMacOsLinux% .\%tempFolder%\%higurashiData%\%assets%

7z a .\%outputFolder%\%outputMacOsLinux% .\%tempFolder%\* -mx9


::
:: Remove temp files
::

rmdir /Q /S .\%tempFolder%