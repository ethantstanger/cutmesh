const std = @import("std");
const Puzzle = @import("Puzzle.zig");
const Solver = @import("Solver.zig");

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const a = arena.allocator();

    const puzzle = Puzzle{
        .col_hints = &.{ 1, 3, 4, 3 },
        .row_hints = &.{ 1, 3, 2, 1 },
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
