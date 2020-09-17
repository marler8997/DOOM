const std = @import("std");
const argv = @import("./argv.zig");

const c = @cImport({
    @cInclude("d_main.h");
});

pub fn main() void {
    argv.myargc = @intCast(i32, std.os.argv.len);
    argv.myargv = std.os.argv.ptr;
    c.D_DoomMain();
}
