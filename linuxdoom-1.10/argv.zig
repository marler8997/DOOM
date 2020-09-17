pub export var myargc: i32 = undefined;
pub export var myargv: [*][*:0]u8 = undefined;

fn toupper(a: u8) u8 {
    return if (a >= 'a' and a <= 'z') a - ('a' - 'A') else a;
}

fn strcasecmp(a: [*:0]u8, b: [*:0]u8) bool {
    var i: usize = 0;
    while (true) : (i += 1) {
        if (toupper(a[i]) != toupper(b[i]))
            return false;
        if (a[i] == 0)
            return true;
    }
}

//
// M_CheckParm
// Checks for the given parameter
// in the program's command line arguments.
// Returns the argument number (1 to argc-1)
// or 0 if not present
pub export fn M_CheckParm(check: [*:0]u8) i32 {
    var i : i32 = 1;
    while (i < myargc) : (i += 1) {
        if (strcasecmp(check, myargv[@intCast(u32, i)]))
            return i;
    }
    return 0;
}
