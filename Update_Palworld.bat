@echo off
setlocal
title Palworld Server One-Click Installer

:: ================================
:: 设置路径（默认当前文件夹下）
:: ================================
set "STEAMCMD_PATH=%~dp0steamcmd"
set "SERVER_PATH=%~dp0palworld_server"
set "APP_ID=2394010"
set "MAX_RETRIES=5"
set "RETRY_COUNT=0"

echo ===========================================
echo    Palworld 服务器一键下载/更新脚本
echo ===========================================

:: 1. 检查并下载 SteamCMD
if not exist "%STEAMCMD_PATH%\steamcmd.exe" (
    echo [*] 正在下载 SteamCMD...
    mkdir "%STEAMCMD_PATH%"
    powershell -Command "& {Invoke-WebRequest -Uri 'https://steamcdn-a.akamaihd.net/client/installer/steamcmd.zip' -OutFile '%STEAMCMD_PATH%\steamcmd.zip'}"
    echo [*] 正在解压 SteamCMD...
    powershell -Command "& {Expand-Archive -Path '%STEAMCMD_PATH%\steamcmd.zip' -DestinationPath '%STEAMCMD_PATH%' -Force}"
    del "%STEAMCMD_PATH%\steamcmd.zip"
) else (
    echo [OK] 发现已存在的 SteamCMD。
)

:: 2. 下载/更新 Palworld 服务端
echo [*] 正在清理旧缓存以防报错...
if exist "%STEAMCMD_PATH%\appcache" rd /s /q "%STEAMCMD_PATH%\appcache"

:retry_loop
set /a RETRY_COUNT+=1
echo.
echo ========================================================
echo    正在进行第 %RETRY_COUNT% 次尝试 (共 %MAX_RETRIES% 次)
echo ========================================================

:: 1. 每次重试前清理缓存，防止 "Missing configuration" 持续存在
echo [*] 正在执行深度清理...
if exist "%STEAMCMD_PATH%\appcache" rd /s /q "%STEAMCMD_PATH%\appcache"
if exist "%STEAMCMD_PATH%\package" rd /s /q "%STEAMCMD_PATH%\package"

echo [*] 正在启动 SteamCMD 预热并同步配置 (请等待 10-20 秒)...

:: 核心逻辑：先运行一次 app_info_print 强制拉取配置，然后再运行 update
"%STEAMCMD_PATH%\steamcmd.exe" +login anonymous +app_info_update 1 +app_info_print 2394010 +quit

echo [*] 正在开始正式安装...
"%STEAMCMD_PATH%\steamcmd.exe" +force_install_dir "%SERVER_PATH%" +login anonymous +app_update 2394010 validate +quit

:: 3. 验证关键文件是否存在
if exist "%SERVER_PATH%\PalServer.exe" (
    echo.
    echo ========================================================
    echo [成功] 服务器已成功安装/更新！
    echo ========================================================
    goto success
) else (
    echo.
    echo [警告] 第 %RETRY_COUNT% 次尝试失败。
    if !RETRY_COUNT! LSS %MAX_RETRIES% (
        echo [*] 等待 5 秒后自动重试...
        timeout /t 5 /nobreak > nul
        goto retry_loop
    ) else (
        goto failed
    )
)

:success
echo.
echo 提示：你可以现在运行根目录下的启动脚本（StartAll.bat）了。
::检查是否成功
if exist "%SERVER_PATH%\PalServer.exe" (
    echo.
    echo ===========================================
    echo [成功] 服务器已安装完成！
    echo 路径: %SERVER_PATH%
    echo ===========================================
) else (
    echo.
    echo [错误] 安装似乎失败，请检查网络或重试。
)

pause
exit

:failed
echo.
echo ========================================================
echo [错误] 已达到最大重试次数，安装依然失败。
echo 建议解决方案：
echo 1. 请检查网络连接，或开启加速器（加速Steam商店/社区）。
echo 2. 确保磁盘空间充足（至少需要 5GB 空间）。
echo 3. 手动尝试删除 steamcmd 文件夹后重新运行此脚本。
echo ========================================================
pause
exit