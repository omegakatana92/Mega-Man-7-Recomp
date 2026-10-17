param(
    [Parameter(Mandatory = $true)]
    [string]$RomPath,

    [string]$Recompiler = "snesrecomp.exe",

    [string]$CompilerBin = "C:\msys64\mingw64\bin"
)

$ErrorActionPreference = "Stop"
$Project = $PSScriptRoot
$Build = Join-Path $Project "build-release"

$ExpectedSHA256 = "a255fec32453739903a1954149f19bc9658f4a415600b44badf1d4e5e13a16f9"
$ExpectedCRC32 = "2d947536"

$RomPath = (Resolve-Path -LiteralPath $RomPath).Path

if (Test-Path -LiteralPath $CompilerBin) {
    $env:PATH = "$CompilerBin;$env:PATH"
}

Write-Host "`n=== VERIFY ROM ===" -ForegroundColor Cyan

& $Recompiler verify-rom `
    --rom $RomPath `
    --expected-sha256 $ExpectedSHA256 `
    --expected-crc32 $ExpectedCRC32

if ($LASTEXITCODE -ne 0) {
    throw "ROM verification failed."
}

Write-Host "`n=== GENERATE NATIVE C SOURCE ===" -ForegroundColor Cyan

& $Recompiler generate `
    --rom $RomPath `
    --cfg-dir (Join-Path $Project "config") `
    --out-dir (Join-Path $Project "generated") `
    --project-root $Project `
    --expected-sha256 $ExpectedSHA256 `
    --expected-crc32 $ExpectedCRC32

if ($LASTEXITCODE -ne 0) {
    throw "ROM recompilation failed."
}

Write-Host "`n=== CONFIGURE NATIVE WINDOWS BUILD ===" -ForegroundColor Cyan

cmake -S $Project -B $Build -G Ninja `
    "-DCMAKE_C_COMPILER=$CompilerBin\gcc.exe" `
    "-DCMAKE_CXX_COMPILER=$CompilerBin\g++.exe" `
    "-DCMAKE_BUILD_TYPE=Release" `
    "-DSNESRECOMP_ENABLE_TRACE=ON"

if ($LASTEXITCODE -ne 0) {
    throw "CMake configuration failed."
}

Write-Host "`n=== BUILD MEGA MAN 7 ===" -ForegroundColor Cyan

cmake --build $Build --target MegaMan7 --parallel 8

if ($LASTEXITCODE -ne 0) {
    throw "Native compilation failed."
}

Write-Host "`n=== BUILD COMPLETE ===" -ForegroundColor Green
Write-Host "Executable: $(Join-Path $Build 'MegaMan7.exe')"
