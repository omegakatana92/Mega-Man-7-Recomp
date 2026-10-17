#include "desktop/host_main.h"
#include "generic_frame_driver.h"

int main(int argc, char **argv) {
    SnesDesktopHostGame game = {0};

    game.display_name = "Mega Man 7";
    game.window_title = "Mega Man 7 (Recompiled)";
    game.region = "USA";
    game.rom_file = "Mega Man 7 (USA).sfc";
    game.expected_sha256_hex =
        "a255fec32453739903a1954149f19bc9658f4a415600b44badf1d4e5e13a16f9";
    game.expected_crc32_hex = "2d947536";
    game.build_version = "dev";
    game.game_info = snes_generic_frame_driver_game_info("mega7");
    game.num_players = 1;
    game.frame_width = 256;
    game.frame_height = 224;

    return snesrecomp_desktop_main(&game, argc, argv);
}