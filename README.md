# Mega Man 7 Recomp

A native Windows recompilation project for **Mega Man 7 (SNES)**,
built using RetroPortingToolKit's SNESRecomp framework.

The project includes a graphical configuration launcher that allows
players to select their own compatible ROM before starting the game.

## Features

- Native Windows executable (`MegaMan7.exe`)
- Graphical pre-game configuration launcher
- User-supplied ROM selection
- ROM SHA-256 and CRC32 verification
- SNESRecomp-generated native C code
- SDL-based desktop runtime
- Recomp-UI launcher integration

## Current Status

The Windows executable has been built and tested locally.
The launcher opens, accepts a compatible ROM, and starts gameplay.

## ROM Requirements

You must supply your own compatible Mega Man 7 ROM.

Expected version: Mega Man 7 (USA)

SHA-256:
`a255fec32453739903a1954149f19bc9658f4a415600b44badf1d4e5e13a16f9`

CRC32:
`2d947536`

ROM files and ROM-derived generated source files are not distributed.

## Building on Windows

Requirements:

- Windows
- CMake
- Ninja
- MSYS2 MinGW-w64 GCC/G++
- Compatible SNESRecomp CLI
- SNESRecomp runtime source
- Recomp-UI submodule
- Your own compatible Mega Man 7 ROM

Clone the repository with submodules:

```powershell
git clone --recurse-submodules https://github.com/omegakatana92/Mega-Man-7-Recomp.git
cd Mega-Man-7-Recomp
```

Make the compatible SNESRecomp runtime available under `snesrecomp/`,
or use the dependency setup instructions provided with the project.

Build using:

```powershell
.\build.ps1 -RomPath "C:\path\to\Mega Man 7 (USA).sfc" `
    -Recompiler "C:\path\to\snesrecomp.exe"
```

The default compiler directory is:

`C:\msys64\mingw64\bin`

The compiled executable is placed at:

`build-release\MegaMan7.exe`

## Running

1. Launch `MegaMan7.exe`.
2. Open the configuration launcher.
3. Select your compatible Mega Man 7 ROM.
4. Click Play.

## Legal and Licensing

Mega Man and Mega Man 7 are properties of Capcom.

This is an unofficial fan recompilation project and is not
affiliated with or endorsed by Capcom.

No copyrighted ROM or ROM-derived generated game code is
included in this repository.

SNESRecomp is developed by RetroPortingToolKit and is subject
to the PolyForm Noncommercial License 1.0.0.

The SNESRecomp runtime includes third-party components with
separate licenses and attribution requirements.

Recomp-UI is maintained by RetroPortingToolKit and retains
its own license and copyright notices.

See the dependency license files for applicable terms.
