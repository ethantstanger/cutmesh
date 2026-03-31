const std = @import("std");

const Puzzle = @This();

col_hints: []const ?u8,
row_hints: []const ?u8,
end_pairs: []const [2]struct { x: u8, y: u8 },

const ValidityError = error{ EndOutOfBounds, OverlappingEnds, InvalidColHint, InvalidRowHint };

pub fn validate(self: *const Puzzle) ValidityError!void {
    for (self.col_hints) |it| {
        const hint = it orelse continue;
        if (hint > self.row_hints.len) return ValidityError.InvalidColHint;
    }

    for (self.row_hints) |it| {
        const hint = it orelse continue;
        if (hint > self.col_hints.len) return ValidityError.InvalidRowHint;
    }

    const eql = std.meta.eql;
    for (self.end_pairs) |a| {
        if (eql(a[0], a[1])) return ValidityError.OverlappingEnds;

        for (a) |it| {
            if (it.x > self.col_hints.len) return ValidityError.EndOutOfBounds;
            if (it.y > self.row_hints.len) return ValidityError.EndOutOfBounds;
        }

        for (self.end_pairs) |b| {
            if (eql(a, b)) continue;
            if (eql(a[0], b[0]) or eql(a[0], b[1])) return ValidityError.OverlappingEnds;
            if (eql(a[1], b[0]) or eql(a[1], b[1])) return ValidityError.OverlappingEnds;
        }
    }
}

pub fn colCount(self: *const Puzzle) usize {
    return self.col_hints.len + 1;
}

pub fn rowCount(self: *const Puzzle) usize {
    return self.row_hints.len + 1;
}
