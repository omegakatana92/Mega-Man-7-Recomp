cmake_minimum_required(VERSION 3.20)
project(Mega_Man_7Recomp C)
set(CMAKE_C_STANDARD 11)

file(GLOB GENERATED_SOURCES CONFIGURE_DEPENDS
  "${CMAKE_CURRENT_SOURCE_DIR}/generated/*.c")
add_library(snesrecomp_game STATIC ${GENERATED_SOURCES})
target_include_directories(snesrecomp_game PRIVATE
  "${CMAKE_CURRENT_SOURCE_DIR}/config"
  "${CMAKE_CURRENT_SOURCE_DIR}/snesrecomp/runner/src"
  "${CMAKE_CURRENT_SOURCE_DIR}/snesrecomp/runner/src/snes")
if(NOT MSVC)
  target_compile_options(snesrecomp_game PRIVATE
    -w -Wno-implicit-function-declaration)
endif()

# Mega Man 7 native Windows desktop host.
set(SNESRECOMP_ROOT "${CMAKE_CURRENT_SOURCE_DIR}/snesrecomp"
    CACHE PATH "Path to SNESRecomp")

include("${SNESRECOMP_ROOT}/runner/runner.cmake")

add_executable(MegaMan7
    mega7_main.c
    ${SNESRECOMP_RUNNER_SOURCES}
)

target_include_directories(MegaMan7 PRIVATE
    "${CMAKE_CURRENT_SOURCE_DIR}/config"
    ${SNESRECOMP_RUNNER_INCLUDE_DIRS}
)

snesrecomp_target_generated_code(
    MegaMan7
    "${CMAKE_CURRENT_SOURCE_DIR}/generated"
)

snesrecomp_target_desktop_host(MegaMan7)
snesrecomp_target_sdl(MegaMan7)
snesrecomp_target_mod_catalog(MegaMan7 NONE)

# Windows networking functions used by the SNESRecomp debug server.
if(WIN32)
    target_link_libraries(MegaMan7 PRIVATE ws2_32)
endif()

# Official RetroPortingToolKit pre-game launcher.
include("${CMAKE_CURRENT_SOURCE_DIR}/recomp-ui/recomp_ui.cmake")
recomp_target_launcher_ui(MegaMan7 CONSOLE snes)

