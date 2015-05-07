@ECHO OFF
SET BIN_TARGET=%~dp0/../vendor/bin/tester.bat
"%BIN_TARGET%" %* ./../tests
