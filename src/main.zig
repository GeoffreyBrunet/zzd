const lib = @import("lib.zig");

pub fn main() !void {
    try lib.read_file();
}
