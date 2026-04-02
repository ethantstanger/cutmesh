const std = @import("std");

const Puzzle = @This();

cut_hints: []const struct { col: ?u8, row: ?u8 },
end_pairs: []const [2]struct { x: u8, y: u8 },

const ValidityError = error{ EndOutOfBounds, OverlappingEnds, InvalidCutHint };

pub fn validate(self: *const Puzzle) ValidityError!void {
    for (self.cut_hints) |it| {
        if (it.col) |hint| if (hint > self.size()) return ValidityError.InvalidCutHint;
        if (it.row) |hint| if (hint > self.size()) return ValidityError.InvalidCutHint;
    }

    const eql = std.meta.eql;
    for (self.end_pairs) |a| {
        if (eql(a[0], a[1])) return ValidityError.OverlappingEnds;

        for (a) |it| {
            if (it.x > self.cut_hints.len) return ValidityError.EndOutOfBounds;
            if (it.y > self.cut_hints.len) return ValidityError.EndOutOfBounds;
        }

        for (self.end_pairs) |b| {
            if (eql(a, b)) continue;
            if (eql(a[0], b[0]) or eql(a[0], b[1])) return ValidityError.OverlappingEnds;
            if (eql(a[1], b[0]) or eql(a[1], b[1])) return ValidityError.OverlappingEnds;
        }
    }
}

pub fn size(self: *const Puzzle) usize {
    return self.cut_hints.len + 1;
}
