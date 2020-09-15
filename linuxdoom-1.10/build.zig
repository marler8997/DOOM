const std = @import("std");
const Builder = std.build.Builder;

pub fn build(b: *Builder) void {
    const mode = b.standardReleaseOptions();
    const target = b.standardTargetOptions(.{});
    //const target = b.standardTargetOptions(.{
    //    .whitelist = &[_]std.build.Target{
    //        .{
    //            .cpu_arch = .i386,
    //            .os_tag = .linux,
    //            .abi = .musl,
    //        },
    //        // gnu not working right now
    //        //.{
    //        //    .cpu_arch = .i386,
    //        //    .os_tag = .windows,
    //        //    .abi = .gnu,
    //        //},
    //    },
    //});
    //const target = std.build.Target {
    //    .cpu_arch = .i386,
    //    .os_tag = .linux,
    //    // gnu not working: https://github.com/ziglang/zig/issues/4926
    //    //.abi = .gnu,
    //    .abi = .musl,
    //};

    const exe = b.addExecutable("doom", "main.zig");
    exe.setBuildMode(mode);
    exe.setTarget(target);
    exe.linkSystemLibrary("c");
    exe.linkSystemLibrary("x11");
    exe.linkSystemLibrary("xext");
    addSource(exe);

    b.default_step.dependOn(&exe.step);
    exe.install();

    const run = b.step("run", "Run the demo");
    const run_cmd = exe.run();
    run.dependOn(&run_cmd.step);
}

fn addSource(exe: *std.build.LibExeObjStep) void {
    const cflags = &[_][]const u8 {
        "-std=c99",
        "-DLINUX",
        "-DNORMALUNIX",
        "-DSNDSERV",
        // Use to ignore undefined behavior
        //"-fno-sanitize=undefined",
    };
    exe.addIncludeDir(".");
    exe.addCSourceFile("doomdef.c", cflags);
    exe.addCSourceFile("doomstat.c", cflags);
    exe.addCSourceFile("dstrings.c", cflags);
    exe.addCSourceFile("i_system.c", cflags);
    exe.addCSourceFile("i_sound.c", cflags);
    exe.addCSourceFile("i_video.c", cflags);
    exe.addCSourceFile("i_net.c", cflags);
    exe.addCSourceFile("tables.c", cflags);
    exe.addCSourceFile("f_finale.c", cflags);
    exe.addCSourceFile("f_wipe.c", cflags);
    exe.addCSourceFile("d_main.c", cflags);
    exe.addCSourceFile("d_net.c", cflags);
    exe.addCSourceFile("d_items.c", cflags);
    exe.addCSourceFile("g_game.c", cflags);
    exe.addCSourceFile("m_menu.c", cflags);
    exe.addCSourceFile("m_misc.c", cflags);
    exe.addCSourceFile("m_argv.c", cflags);
    exe.addCSourceFile("m_bbox.c", cflags);
    exe.addCSourceFile("m_fixed.c", cflags);
    exe.addCSourceFile("m_swap.c", cflags);
    exe.addCSourceFile("m_cheat.c", cflags);
    exe.addCSourceFile("m_random.c", cflags);
    exe.addCSourceFile("am_map.c", cflags);
    exe.addCSourceFile("p_ceilng.c", cflags);
    exe.addCSourceFile("p_doors.c", cflags);
    exe.addCSourceFile("p_enemy.c", cflags);
    exe.addCSourceFile("p_floor.c", cflags);
    exe.addCSourceFile("p_inter.c", cflags);
    exe.addCSourceFile("p_lights.c", cflags);
    exe.addCSourceFile("p_map.c", cflags);
    exe.addCSourceFile("p_maputl.c", cflags);
    exe.addCSourceFile("p_plats.c", cflags);
    exe.addCSourceFile("p_pspr.c", cflags);
    exe.addCSourceFile("p_setup.c", cflags);
    exe.addCSourceFile("p_sight.c", cflags);
    exe.addCSourceFile("p_spec.c", cflags);
    exe.addCSourceFile("p_switch.c", cflags);
    exe.addCSourceFile("p_mobj.c", cflags);
    exe.addCSourceFile("p_telept.c", cflags);
    exe.addCSourceFile("p_tick.c", cflags);
    exe.addCSourceFile("p_saveg.c", cflags);
    exe.addCSourceFile("p_user.c", cflags);
    exe.addCSourceFile("r_bsp.c", cflags);
    exe.addCSourceFile("r_data.c", cflags);
    exe.addCSourceFile("r_draw.c", cflags);
    exe.addCSourceFile("r_main.c", cflags);
    exe.addCSourceFile("r_plane.c", cflags);
    exe.addCSourceFile("r_segs.c", cflags);
    exe.addCSourceFile("r_sky.c", cflags);
    exe.addCSourceFile("r_things.c", cflags);
    exe.addCSourceFile("w_wad.c", cflags);
    exe.addCSourceFile("wi_stuff.c", cflags);
    exe.addCSourceFile("v_video.c", cflags);
    exe.addCSourceFile("st_lib.c", cflags);
    exe.addCSourceFile("st_stuff.c", cflags);
    exe.addCSourceFile("hu_stuff.c", cflags);
    exe.addCSourceFile("hu_lib.c", cflags);
    exe.addCSourceFile("s_sound.c", cflags);
    exe.addCSourceFile("z_zone.c", cflags);
    exe.addCSourceFile("info.c", cflags);
    exe.addCSourceFile("sounds.c", cflags);
}
