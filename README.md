# Valheim Windows Client Instructions
These instructions detail how to setup your Valheim game running on your Windows workstation to use the Cityhallin Valehim modded server. The Cityhallin Valheim server is currently using the folliwng mods:

1. 0.9.9.9 ValheimPlus: Allows for quality of life modifications
2. Jotunn Valheim Library: Supports other mods to be used on the server
3. ValehimRAFT: Build bases on bots/rafts

In order to connect to this Valheim modded server, run through the following instrcutions:

## Install Valheim Mods

1. Download the most up to date version of Valehim on Steam. Search for your Valheim game folder on your Windows machine. Example below:
```
C:\Program Files\SteamLibrary\steamapps\common\Valheim
```
2. Navigate to this [GitHub repo](https://github.com/CityHallin/valheim), click the **Code** button and then click **Download ZIP**

<br />
<img src="./readme-files/gh1.png" width="500px">

3. Once downloaded, unzip this folder and find the client folder. 
4. The content of the client folder should have the following items
    - BepInEx Folder
    - doorstop_libs folder
    - unstripped_corlib folder
    - doorstop_config.ini
    - winhttp.dll

<br />
<img src="./readme-files/gh2.png" width="500px">

5. Copy all of these items from the client folder into your Valehim game folder

<br />
<img src="./readme-files/gh3.png" width="500px">

6. Once the mods are added to the Valehim game folder, you are ready to enter the game. 

## Connect to Valheim Server

1. Open the Steam Desktop App, click on **View**, click on **Servers**

<br />
<img src="./readme-files/gh4.png" width="300px">

2. Click **Add A server**

<br />
<img src="./readme-files/gh5.png" width="500px">

3. Enter the IP address and port of the Cityhallin Valheim server and click **Add this address to favorites**

<br />
<img src="./readme-files/gh6.png" width="500px">

4. The Cityhallin server should appear and show the live player count. Double-click on the server and another pop-up will appear asking for the password to the server. Enter the password and click **Connect**

<br />
<img src="./readme-files/gh7.png" width="700px">

5. The game will now start. If you see the BepInEx CMD prompt appear, just minimize it (do not close it).

<br />
<img src="./readme-files/gh8.png" width="500px">





