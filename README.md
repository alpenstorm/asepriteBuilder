 asepriteBuilder is a simple utility designed to make it easy to build the popular sprite editing tool [Aseprite](https://www.aseprite.com) using the source code found [here](https://github.com/aseprite/aseprite/).


## Dependencies:
- [Microsoft Visual Studio 2022](https://visualstudio.microsoft.com/vs/community/)
- [CMake](https://cmake.org/download/)
- [Ninja Build System](https://ninja-build.org/)
  (if you've read Aseprite's install instructions, you might see that we're missing the Skia library, but that is automatically downloaded by the script)

## How to use
### Setup
 1. Install CMake by running the executable you downloaded.
 2. Download VS2022 and SDK
    1. In the Visual Studio Installer app, click "Install" on the icon of the VS2022 editor and check the "Desktop development with C++" and ESPECIALLY the "Windows 11 SDK" in the sidebar:
   <img src="https://dfstudios.neocities.org/img/aseprite/01.png">
   <img src="https://dfstudios.neocities.org/img/aseprite/02.png">
3. Download and extract Ninja (anywhere, but it's recommended to save it to C:\ninja to make the next steps easier).
### Environment Variables
1. Go to Windows Environment variables:
   <img src="https://dfstudios.neocities.org/img/aseprite/03.png">
2. Under Environment Variables >  System Variables > Path, click Edit > New and add the variables:
   <img src="https://dfstudios.neocities.org/img/aseprite/04.png">
   `C:\ninja` (or the FOLDER where you saved Ninja)
   `C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.30.30705\bin\Hostx64\x64\cl.exe`

### Running the Script
1. Before running, please paste the batch file and the config.cfg file into the folder ABOVE your aseprite folder (e.g. if you have aseprite source code in D:\source\aseprite, put the files in D:\source).
2. Check the config.cfg and assign the variables:
- asepriteFolder: the folder in which the aseprite source code is, for example 'D:\source\aseprite' (it's recommended to clone the aseprite repository with `https://github.com/aseprite/aseprite.git`).
- skiaLocation: the location where you want to place Skia (or where you have Skia, if you installed it), it will create this folder automatically and place Skia inside. Don't set skiaLocation to somewhere inside your source code folder.
- updateGit: set to `yes` (case sensitive) if you want the script to automatically sync your version of the source code with the version on GitHub. Leave it blank if you don't want to use this option.
3. Run the [build_aseprite.bat](build_aseprite.bat) file and the build will atomatically start!