**_··如何快速搭建服务器··_**

1.  运行Update_Palworld.bat文件（此文件是steamcmd下载并安装Palworld服务器的自动化脚本，支持自动更新服务器，在版本更新时只需再次运行此文件即可完成更新）。
2.  运行StartAll.bat文件（此文件是npc网络中转服务器和Palworld服务器的启动脚本，使用这个文件即可启动服务器，若要关闭服务器，只需将窗口全部关闭，注意在启动服务器时请不要关闭任意窗口，否则需要重新启动本脚本）。
3.  若想在本地游玩，只需启动palworld_server\\Pal.exe，若要启动网络中转服务器，需要再启动windows_amd64_client\\start_npc.bat

**_··如何进入服务器··_**

1.  启动游戏在游戏客户端的加入服务器中输入本服务器的地址:端口就可以加入服务器。

**_··如何配置服务器（需要启动已有存档）··_**

1.  将Saved\\XXXXXX的存档文件拷贝至palworld_server\\Pal\\Save\\0 文件夹中后启动游戏即可运行已有存档。若已有Saved文件夹，请用已有存档覆盖文件夹中的内容。

2.  服务器密码在palworld_server\\Pal\\Saved\\Config\\WindowsServer\\PalWorldSettings.ini配置文件中设置，若没有上述文件则将PalServer\\DefaultPalWorldSettings.ini文件拷贝至上述文件夹中并重命名为PalWorldSettings.ini

3.  设置服务器参数请改动palworld_server\\Pal\\Saved\\Config\\WindowsServer\\PalWorldSettings.ini文件，参数设置请参考下面的官网地址。

[Configuration parameters | Palworld Server Guide](https://docs.palworldgame.com/settings-and-operation/configuration)

4.  网络中转服务器的配置在StartAll.bat中

右键->编辑找到npc -server=206.237.127.163:8024 -vkey=123456 -type=tcp修改相关参数

**_··小工具··_**

1.  [存档更改工具](https://github.com/deafdudecomputers/PalworldSaveTools?tab=readme-ov-file)