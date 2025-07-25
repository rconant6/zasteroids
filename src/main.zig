const std = @import("std");
const engine = @import("engine");

const Config = struct {
    const TARGET_FPS: f32 = 60.0;
    const TARGET_FRAME_TIME_US: i64 = @intFromFloat((1.0 / TARGET_FPS) * 1_000_000);
    const WIDTH: i32 = 1600;
    const HEIGHT: i32 = 900;
};

const GameActions = enum { Quit, Thrust, RotateLeft, RotateRight, Shoot };

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();
}
