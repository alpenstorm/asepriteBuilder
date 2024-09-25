@echo off

echo ***************************
echo Welcome to the Aseprite building tool by alpenstorm!
echo ***************************
timeout 10

REM load variables from config.cfg
for /f "delims=" %%x in (config.cfg) do (set "%%x")

echo.
echo Loaded variables

cd %asepriteFolder%

if exist build (
    rmdir /s /q build

    echo.
    echo Removed previous build directory
)

if "%updateGit%"=="yes" (
    git pull
    git submodule update --init --recursive

    echo.
    echo Updated GitHub repo
)

REM check for and download prerequisites
REM ============================================
if not exist %skiaLocation% (
    echo.
    echo Skia not found. Downloading and extracting...
    
    curl -L -o "%temp%\Skia-Windows-Release-x64.zip" "https://github.com/aseprite/skia/releases/download/m102-861e4743af/Skia-Windows-Release-x64.zip"
    PowerShell Expand-Archive "%temp%\Skia-Windows-Release-x64.zip" "%skiaLocation%"
    del "%temp%\Skia-Windows-Release-x64.zip"

    echo.
    echo Skia downloaded and extracted to %skiaLocation%
)

if not exist %ninjaLocation% (
    echo.
    echo Ninja not found. Downloading and extracting...

    curl -L -o "%temp%\ninja-win.zip" "https://github.com/ninja-build/ninja/releases/download/v1.12.1/ninja-win.zip"
    PowerShell Expand-Archive "%temp%\ninja-win.zip" "%ninjaLocation%"
    setx path "%PATH%;%ninjaLocation%"
    del "%temp%\ninja-win.zip"
    
    echo.
    echo Ninja downloaded and extracted to %skiaLocation%
)
REM ============================================

call "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\Tools\VsDevCmd.bat" -arch=x64

mkdir build
cd build

echo.
echo STARTING BUILD...
timeout 3

cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo -DLAF_BACKEND=skia -DSKIA_DIR=%skiaLocation% -DSKIA_LIBRARY_DIR=%skiaLocation%\out\Release-x64 -DSKIA_LIBRARY=%skiaLocation%\out\Release-x64\skia.lib -G Ninja ..
ninja aseprite

cls
echo Finished! Check %asepriteFolder%\build\bin for your executable!
timeout 10
exit