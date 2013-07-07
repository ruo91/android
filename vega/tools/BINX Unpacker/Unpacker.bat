@echo off
title BINX Unpacker
setlocal enabledelayedexpansion
set binx=설정되어 있지 않음

:Start
echo.
echo.
echo      ^만든이: Mir ^ 작업할 BINX파일 명: %binx%
echo.
echo      이 툴은 BINX파일을 분해(Unpack)할 수 있는 툴 입니다
echo      binx파일을 BINX폴더에 넣어주세요
echo.
echo      설치를 위한 프로그램
echo      [Net Framework 4.0이상, Microsoft Visual Studio 2010 패키지]
echo      위 프로그램이 설치되어 있어야 합니다
echo.
echo      준비가 완료되셨다면 아무 버튼을 눌러주세요
pause
goto choosebinx

:choosebinx
cls
echo      ^만든이: Mir ^ 작업할 BINX파일 명: %binx%
echo.

set /A count=0
FOR %%F IN (BINX/*.binx) DO (
set /A count+=1
set a!count!=%%F
if /I !count! LEQ 9 (echo ^- !count!  - %%F )
if /I !count! GTR 10 (echo ^- !count! - %%F )
)

echo.
set /P choose=작업할 BINX파일을 선택하세요: %=%
if /I %choose%==0 (goto start)
if /I %choose% GTR !count! (goto chc)
if /I %choose% LSS 1 (goto chc)
set binx=!a%choose%!
goto binx

:binx
cls
echo      ^만든이: Mir ^ 작업할 BINX파일 명: %binx%
echo.
echo      BINX을 BIN으로 변환하는 작업을 거치고 있습니다
echo.
cd other
regsvr32 SkyUpdate.ocx
SkyBinTool "../BINX/%binx%" "../BINX/%binx%.bin"
echo      BINX파일을 BIN으로 변환했습니다
echo      이제 BIN파일을 해체합니다.
cd ../BINX
Extract -i %binx%.bin -o BINXfile -l -e
echo.
echo      BINX 분해가 완료되었습니다
echo      아무키를 누르시면 프로그램이 종료됩니다
pause
exit