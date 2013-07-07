@echo off
title SKY Offline Self Updater
mode con:cols=82 lines=30
setlocal enabledelayedexpansion
set binx=NOBINX
cls

:Start
echo.
echo.
echo      ☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆
echo      ☆                     SKY Offline Self Updater                       ☆
echo      ☆                                                                    ☆
echo      ☆          이 툴은 인터넷에 연결하지 않아도 BINX를 이용하여          ☆
echo      ☆           셀프 업그레이드를 사용할 수 있게 하는 툴입니다           ☆
echo      ☆                                                                    ☆
echo      ☆                 꼭 글을 모두 읽으신 다음 진행해 주세요             ☆
echo      ☆                                                                    ☆
echo      ☆  Made by su_ky  /  Script made Mir                                 ☆
echo      ☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆
echo.
echo.
echo      현재 업그레이드를 하고자 하는 기기의 모델명을 적어주세요 (예:IM-A750K)
echo.
set /P model=기기의 모델명을 입력해 주세요: %=%
set model=%model%
goto Model

:Model
cls
mkdir .\sky_update\%model%
echo.
echo.
echo      업그레이드 할 기기는 "%model%" 입니다
echo.
echo      sky_update폴더을 보시면 입력하신 "%model%" 폴더가 생성되어 있을겁니다
echo      폴더안에 BINX파일을 넣어주신다음 다음으로 진행해 주세요
echo.
pause
goto obinx

:obinx
set /A count=0
FOR %%F IN (sky_update/%model%/*.binx) DO (
set /A count+=1
set tmpstore=%%~nF%%~xF
)
if %count%==1 (set binx=%tmpstore%)
if %binx%==NOBINX (goto BINX1)
goto inf1

:inf1
echo.
echo.
echo      폴더 탐색 결과 하나의 BINX가 발견되었습니다
echo      BINX 파일 이름 : "%binx%"
echo.
echo      아무 키를 눌러 다음으로 넘어가 주세요
echo.
pause
goto continue

:BINX1
cls
echo.
echo.
echo      탐색결과 폴더내 2개이상의 BINX가 존재합니다
echo      아래 목록에서 사용할 BINX를 선택해 주세요
echo.
echo.
echo      ----- BINX 파일 목록
echo.
set /A count=0
FOR %%F IN (sky_update/%model%/*.binx) DO (
set /A count+=1
set a!count!=%%F
if /I !count! LEQ 9 (echo ^- !count!  - %%F )
if /I !count! GTR 10 (echo ^- !count! - %%F )
)
set /P INPUT=사용할 BINX파일의 숫자를 입력해 주세요: %=%
if /I %INPUT% GTR !count! (goto chc)
if /I %INPUT% LSS 1 (goto chc)
set binx=!a%INPUT%!
goto BINX2

:BINX2
cls
echo.
echo.
echo      수동으로 BINX파일을 지정하였습니다
echo      BINX 파일 이름 : "%binx%"
echo.
echo      아무 키를 눌러 다음으로 넘어가 주세요
echo.
pause
goto continue

:continue
cls
echo.
echo.
echo      [작업을 시작합니다]
File\busybox echo "[%model%]" > ./sky_update/download.inf
File\busybox echo "Version=S1231153" >> ./sky_update/download.inf
File\busybox echo "FileName=%binx%" >> ./sky_update/download.inf
File\busybox echo "FSVersion=21" >> ./sky_update/download.inf
File\busybox echo "NVVersion=22" >> ./sky_update/download.inf
File\busybox echo "Size=433927235" >> ./sky_update/download.inf
File\busybox echo "CRC=26266" >> ./sky_update/download.inf
echo.
echo      download.inf 수정을 완료했습니다
regsvr32 /s File\SkyUpdate.ocx
echo.
echo      SkyUpdate.ocx등록을 완료했습니다
echo.
echo      HFS를 실행합니다 프로그램창을 닫지 마시고 분홍색 폴더를 클릭해 주세요
echo.
pause
start File\hfs sky_update
echo      분홍색 폴더를 클릭하신다음 아무키를 눌러주세요
pause
echo.
echo      Self Upgrade창이 나타납니다 기기를 연결한다음 "업그레이드 시작"버튼을 눌러주세요
start http://localhost/sky_update/index.html
goto exit

:exit
echo.
echo      만약 Log.dll등의 오류가 발생한다면 Del_ActiveX.cmd를 실행해 주세요
echo.
echo      -------------------------------------------------------------
echo      모든 작업이 완료되었습니다 아무키를 누르시면 이 창이 닫힙니다
echo      -------------------------------------------------------------
pause
exit