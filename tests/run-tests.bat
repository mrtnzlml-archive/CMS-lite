@ECHO OFF
SET BIN_TARGET=%~dp0/../vendor/bin/tester.bat
"%BIN_TARGET%" -c php-win.ini --coverage-src ./../app/ --coverage ./coverage.html %* ./../tests
