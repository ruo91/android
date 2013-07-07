@echo off
title Delete Active X Tool
mode con:cols=82 lines=30
setlocal enabledelayedexpansion
cls

:Start
echo.
echo.
echo      ☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆
echo      ☆                         Delete Active X Tool                       ☆
echo      ☆                                                                    ☆
echo      ☆               Offline Updater을 사용한뒤 발생할 수 있는            ☆
echo      ☆                    Dll오류를 해결할 수 있습니다                    ☆
echo      ☆  Script made Mir                                                   ☆
echo      ☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆
echo.
echo.
echo      SkyUpdate.ocx의 등록과 Self Update Active X를 제거해 줍니다
echo      Log.dll오류가 발생할경우 사용해 주세요
echo.
echo.
pause
regsvr32 /u /s File\SkyUpdate.ocx
File\busybox rm -f C:\Windows\Downloaded Program Files\SkyUpdate.inf
echo.
echo      -------------------------------------------------------------
echo      모든 작업이 완료되었습니다 아무키를 누르시면 이 창이 닫힙니다
echo      -------------------------------------------------------------
echo.
pause