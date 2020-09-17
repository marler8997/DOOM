const std = @import("std");
const Allocator = std.mem.Allocator;

const argv = @import("./argv.zig");

const c = @cImport({
    @cInclude("d_main.h");
});


var gpa_mem = std.heap.GeneralPurposeAllocator(.{}){};
pub const gpa = &gpa_mem.allocator;

// Game mode handling - identify IWAD version
//  to handle IWAD dependend animations etc.
const GameMode = enum {
    shareware,   // DOOM 1 shareware, E1, M9
    registered,  // DOOM 1 registered, E3, M27
    commercial,  // DOOM 2 retail, E1 M34
    retail,      // DOOM 1 retail, E4, M36
    indetermined // Well, no IWAD found.
};
const Language = enum {
    english,
    french,
    german,
};

const VersionDef = struct {
    file: []const u8,
    mode: GameMode,
    lang: Language,
};
const versionDefs = [_]VersionDef {
    .{ .file = "doom1.wad"   , .mode = .shareware , .lang = .english},
    .{ .file = "doomu.wad"   , .mode = .retail    , .lang = .english},
    .{ .file = "doom.wad"    , .mode = .registered, .lang = .english },
    .{ .file = "doom2.wad"   , .mode = .commercial, .lang = .english },
    .{ .file = "plutonia.wad", .mode = .commercial, .lang = .english },
    .{ .file = "tnt.wad"     , .mode = .commercial, .lang = .english },
    .{ .file = "doom2f.wad"  , .mode = .commercial, .lang = .french },
};

const Version = struct {
    def: *const VersionDef,
    file: []const u8,
};
pub fn identifyVersion(allocator: *Allocator, dir: []const u8) !Version {
    // TODO: enable/test these if I get the debug files necessary
//    if (M_CheckParm ("-shdev"))
//    {
//	gamemode = shareware;
//	devparm = true;
//	D_AddFile (DEVDATA"doom1.wad");
//	D_AddFile (DEVMAPS"data_se/texture1.lmp");
//	D_AddFile (DEVMAPS"data_se/pnames.lmp");
//	strcpy (basedefault,DEVDATA"default.cfg");
//	return;
//    }
//
//    if (M_CheckParm ("-regdev"))
//    {
//	gamemode = registered;
//	devparm = true;
//	D_AddFile (DEVDATA"doom.wad");
//	D_AddFile (DEVMAPS"data_se/texture1.lmp");
//	D_AddFile (DEVMAPS"data_se/texture2.lmp");
//	D_AddFile (DEVMAPS"data_se/pnames.lmp");
//	strcpy (basedefault,DEVDATA"default.cfg");
//	return;
//    }
//
//    if (M_CheckParm ("-comdev"))
//    {
//	gamemode = commercial;
//	devparm = true;
//	/* I don't bother
//	if(plutonia)
//	    D_AddFile (DEVDATA"plutonia.wad");
//	else if(tnt)
//	    D_AddFile (DEVDATA"tnt.wad");
//	else*/
//	    D_AddFile (DEVDATA"doom2.wad");
//
//	D_AddFile (DEVMAPS"cdata/texture1.lmp");
//	D_AddFile (DEVMAPS"cdata/pnames.lmp");
//	strcpy (basedefault,DEVDATA"default.cfg");
//	return;
//    }


    var match : ?Version = null;
    for (versionDefs) |*versionDef| {
        const file = try std.fs.path.join(allocator, &[_][]const u8 {dir, versionDef.file});
        if (std.fs.cwd().access(file, .{})) {
            if (match) |v| {
                // TODO: if there are multiple, would be better to
                //       populate the game select menu
                std.debug.warn("Error: found multiple game version files, '{}' and '{}'\n", .{v.file, file});
                return error.FatalErrorReported;
            }
            match = Version { .def = versionDef, .file = file };
        } else |e| {
             allocator.free(file);
             switch (e) {
                 error.FileNotFound => {},
                 else => return e,
             }
        }
    }
    if (match) |v| {
        std.debug.warn("matched version {}\n", .{v.def});
        return v;
    }
    std.debug.warn("Error: unable to find any of the following game version files:\n", .{});
    for (versionDefs) |versionDef| {
        std.debug.warn("    {}\n", .{versionDef.file});
    }
    return error.FatalErrorReported;
}

//
// Find a Response File
//
pub fn findResponseFile() void {
    const MAXARGVS = 100;
    for (argv.cmd_args()) |arg| {
        if (arg[0] == '@') {
            @panic("reponse files not implemented");
//            FILE *          handle;
//            int             size;
//            int             k;
//            int             index;
//            int             indexinfile;
//            char    *infile;
//            char    *file;
//            char    *moreargs[20];
//            char    *firstargv;
//
//            // READ THE RESPONSE FILE INTO MEMORY
//            handle = fopen (&myargv[i][1],"rb");
//            if (!handle)
//            {
//                printf ("\nNo such response file!");
//                exit(1);
//            }
//            printf("Found response file %s!\n",&myargv[i][1]);
//            fseek (handle,0,SEEK_END);
//            size = ftell(handle);
//            fseek (handle,0,SEEK_SET);
//            file = malloc (size);
//            fread (file,size,1,handle);
//            fclose (handle);
//
//            // KEEP ALL CMDLINE ARGS FOLLOWING @RESPONSEFILE ARG
//            for (index = 0,k = i+1; k < myargc; k++)
//                moreargs[index++] = myargv[k];
//
//            firstargv = myargv[0];
//            myargv = malloc(sizeof(char *)*MAXARGVS);
//            memset(myargv,0,sizeof(char *)*MAXARGVS);
//            myargv[0] = firstargv;
//
//            infile = file;
//            indexinfile = k = 0;
//            indexinfile++;  // SKIP PAST ARGV[0] (KEEP IT)
//            do
//            {
//                myargv[indexinfile++] = infile+k;
//                while(k < size &&
//                      ((*(infile+k)>= ' '+1) && (*(infile+k)<='z')))
//                    k++;
//                *(infile+k) = 0;
//                while(k < size &&
//                      ((*(infile+k)<= ' ') || (*(infile+k)>'z')))
//                    k++;
//            } while(k < size);
//
//            for (k = 0;k < index;k++)
//                myargv[indexinfile++] = moreargs[k];
//            myargc = indexinfile;
//
//            // DISPLAY ARGS
//            printf("%d command-line args:\n",myargc);
//            for (k=1;k<myargc;k++)
//                printf("%s\n",myargv[k]);
//
//            break;
        }
    }
}


pub fn main() !u8 {
    main2() catch |e| switch (e) {
        error.FatalErrorReported => return 0xff,
        else => return e,
    };
    return 0;
}
pub fn main2() !void {
    argv.myargc = @intCast(i32, std.os.argv.len);
    argv.myargv = std.os.argv.ptr;
    findResponseFile();
    // TODO: should we support the environment variable? DOOMWADDIR?
    //       not sure why it exists, why not just support a command-line option?
    //       this is an exe not a library so command-line should work
    const version = try identifyVersion(gpa, ".");
    c.D_DoomMain();
}
