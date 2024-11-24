const std = @import("std");

fn get_user_input() ![]const u8 {
    var it = std.process.args();
    _ = it.next();

    if (it.next()) |arg| {
        return arg;
    } else {
        return error.InvalidArgument;
    }
}

pub fn read_file() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const filename = try get_user_input();

    const file = try std.fs.cwd().openFile(filename, .{});
    defer file.close();

    const file_size = try file.getEndPos();

    const buffer = try file.readToEndAlloc(allocator, file_size);

    defer allocator.free(buffer);

    try std.io.getStdOut().writer().writeAll(buffer);
}
