@echo off
title Palworld Server + NPC Launcher
echo 正在准备启动程序...

:: 2. 启动 NPC (穿透/代理客户端)
:: 注意：如果你的 npc.exe 需要参数（如 -server=xxx -vkey=xxx），请直接加在引号后面

echo [*] 正在启动 NPC 客户端...
start "NPC Client" /d "%~dp0windows_amd64_client" "%~dp0windows_amd64_client\npc.exe" -server=206.237.127.163:8024 -vkey=123456 -type=tcp

:: 等待 2 秒，确保第一个程序已初始化
timeout /t 2 /nobreak > nul

:: 1. 启动 PalServer (幻兽帕鲁服务端)
:: /d 指定运行目录，确保程序能正确读取内部配置文件

echo [*] 正在启动 PalServer...
start "Palworld Server" /d "%~dp0palworld_server" "%~dp0palworld_server\PalServer.exe" -useperfthreads -NoAsyncLoadingThread -UseMultithreadForDS

echo ==========================================
echo 两个程序已尝试启动。
echo 请检查弹出的两个新窗口是否运行正常。
echo ==========================================
echo 服务器已经正常开启，在游戏客户端的加入服务器中输入本服务器的地址:端口，就可以开始愉快地玩耍了！！！
echo 请保持另外两个窗口处于开启状态，此窗口可以关闭~
pause