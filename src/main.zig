const std = @import("std");
const Puzzle = @import("Puzzle.zig");
const Solver = @import("Solver.zig");

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const a = arena.allocator();

    const puzzle = Puzzle{
        .cut_hints = &.{
            .{ .col = 1, .row = 1 },
            .{ .col = 3, .row = 3 },
            .{ .col = 4, .row = 2 },
            .{ .col = 3, .row = 1 },
        },
        .end_pairs = &.{
            .{ .{ .x = 1, .y = 0 }, .{ .x = 4, .y = 2 } },
            .{ .{ .x = 1, .y = 2 }, .{ .x = 3, .y = 4 } },
            .{ .{ .x = 3, .y = 1 }, .{ .x = 1, .y = 3 } },
            .{ .{ .x = 2, .y = 2 }, .{ .x = 2, .y = 3 } },
        },
    };

    var solver = try Solver.from(a, &puzzle);
    try solver.solve();
    solver.printData();
    solver.printGrid();
}
