const std = @import("std");
const eng = @import("engine");
const Engine = eng.Engine;
const EngineConfig = eng.EngineConfig;
const InputManager = eng.InputManager;

// const GameActions = enum { Quit, Thrust, RotateLeft, RotateRight, Shoot };
const GameActions = enum { Quit };

const Game = struct {
    actions: eng.input.ActionManager(GameActions),

    pub fn init(allocator: std.mem.Allocator, engine: *eng.Engine) !Game {
        return Game{ .actions = engine.createActionManager(GameActions, allocator) };
    }
    pub fn deinit(self: *Game) void {
        self.actions.deinit();
    }

    pub fn update(self: *Game, engine: *Engine, dt: f32) void {
        std.debug.print("[GAME] - updated called\n", .{});

        if (engine.inputManager.keyboard.wasKeyJustPressed(.Esc)) {
            std.debug.print("[RAW] Esc detected\n", .{});
        }

        if (self.actions.wasActionJustPressed(.Quit)) {
            std.debug.print("I want to quit the engine\n", .{});
            engine.stopRunning();
        }

        _ = dt;
        return;
    }
};

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const config = EngineConfig.toEngineNamedConfig("ZASTEROIDS");
    var engine = try Engine.init(allocator, config);
    defer engine.deinit();

    var game = try Game.init(allocator, &engine);
    try setupQuitBindings(&game.actions);

    defer game.deinit();

    try engine.run(&game);
}

fn setupQuitBindings(actions: *eng.input.ActionManager(GameActions)) !void {
    try actions.addBinding(.{
        .action = .Quit,
        .source = .{ .Key = .Esc },
    });

    try actions.addBinding(.{
        .action = .Quit,
        .source = .{ .MouseButton = .Right },
    });

    try actions.addBinding(.{
        .action = .Quit,
        .source = .{ .KeyCombo = .{ .modifier = .Command, .key = .Q } },
    });
}
