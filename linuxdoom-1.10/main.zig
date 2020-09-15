const std = @import("std");

const c = @cImport({
    @cInclude("d_main.h");
    @cInclude("m_argv.h");
});

pub fn main() void {
    c.myargc = @intCast(i32, std.os.argv.len);
    c.myargv = @ptrCast([*c][*c]u8, std.os.argv.ptr);
    c.D_DoomMain();
}