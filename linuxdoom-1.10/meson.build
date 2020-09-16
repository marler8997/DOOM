project('doom', 'c')

libx11 = dependency('x11')
libxext = dependency('xext')

cc = meson.get_compiler('c')
libm = cc.find_library('m')

dependencies = [
    libm,
    libx11,
    libxext,
]

c_args = [
    '-std=c99',
    '-DLINUX',
    '-DNORMALUNIX',
    '-DSNDSERV',
]

if get_option('ubsan')
    dependencies += cc.find_library('ubsan')
    c_args += '-fsanitize=undefined'
endif

executable('doom',
    'doomdef.c',
    'doomstat.c',
    'dstrings.c',
    'i_main.c',
    'i_system.c',
    'i_sound.c',
    'i_video.c',
    'i_net.c',
    'tables.c',
    'f_finale.c',
    'f_wipe.c',
    'd_main.c',
    'd_net.c',
    'd_items.c',
    'g_game.c',
    'm_menu.c',
    'm_misc.c',
    'm_argv.c',
    'm_bbox.c',
    'm_fixed.c',
    'm_swap.c',
    'm_cheat.c',
    'm_random.c',
    'am_map.c',
    'p_ceilng.c',
    'p_doors.c',
    'p_enemy.c',
    'p_floor.c',
    'p_inter.c',
    'p_lights.c',
    'p_map.c',
    'p_maputl.c',
    'p_plats.c',
    'p_pspr.c',
    'p_setup.c',
    'p_sight.c',
    'p_spec.c',
    'p_switch.c',
    'p_mobj.c',
    'p_telept.c',
    'p_tick.c',
    'p_saveg.c',
    'p_user.c',
    'r_bsp.c',
    'r_data.c',
    'r_draw.c',
    'r_main.c',
    'r_plane.c',
    'r_segs.c',
    'r_sky.c',
    'r_things.c',
    'w_wad.c',
    'wi_stuff.c',
    'v_video.c',
    'st_lib.c',
    'st_stuff.c',
    'hu_stuff.c',
    'hu_lib.c',
    's_sound.c',
    'z_zone.c',
    'info.c',
    'sounds.c',
    c_args : c_args,
    dependencies : dependencies,
    install : true,
)
