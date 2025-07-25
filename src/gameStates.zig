const std = @import("std");

const plat = @import("platform");
const KeyCodes = plat.GameKeyCode;
const KeyEvent = plat.KeyEvent;

// MARK: GameState bridging
pub const GameStateContext = struct {
    // hold what needs to be passed to start a stage
    // this probably collects alot of optional stuff
    // that each GameState will copy/set in its enter function
    // exit can take a pointer to update it
};

pub const StateTransitions = enum {
    MenuToPlay,
    PauseToPlay,
    PauseToMenu,
    PlayToMenu,
    PlayToPause,
    PlayToGameOver,
    GameOverToMenu,
};

pub const MenuState = struct {
    // game gets setup and waits for game start
    // add the 4 required functions plus whatever else is needed

    pub fn enter(self: *MenuState, ctx: GameStateContext) void {
        std.debug.print("[MENUSTATE] - enter\n", .{});
        _ = self;
        _ = ctx;
        // do what needs to be done
    }

    pub fn exit(self: *MenuState, ctx: GameStateContext) void {
        std.debug.print("[MENUSTATE] - exit\n", .{});
        _ = self;
        _ = ctx;
        // do what needs to be done
    }

    pub fn update(self: *MenuState, dt: f32) void {
        _ = self;
        _ = dt;
        // do what needs to be done
    }
    pub fn handleInput(self: *MenuState, input: KeyEvent) ?StateTransitions {
        _ = self;
        return switch (input.keyCode) {
            .P => .MenuToPlay,
            else => null,
        };
    }
};

pub const PlayingState = struct {
    pub fn enter(self: *PlayingState, ctx: GameStateContext) void {
        std.debug.print("[PLAYINGSTATE] - enter\n", .{});
        _ = self;
        _ = ctx;
        // do what needs to be done
    }

    pub fn exit(self: *PlayingState, ctx: GameStateContext) void {
        std.debug.print("[PLAYINGSTATE] - exit\n", .{});
        _ = self;
        _ = ctx;
        // do what needs to be done
    }

    pub fn update(self: *PlayingState, dt: f32) void {
        _ = self;
        _ = dt;
        // do what needs to be done
    }
    pub fn handleInput(self: *PlayingState, input: KeyEvent) ?StateTransitions {
        _ = self;
        return switch (input.keyCode) {
            .P => .PlayToPause,
            .GameOver => .PlayToGameOver, // how will this get triggered?
            else => null,
        };
    }
};

pub const PausedState = struct {
    pub fn enter(self: *PausedState, ctx: GameStateContext) void {
        std.debug.print("[PAUSEDSTATE] - enter\n", .{});
        _ = self;
        _ = ctx;
        // do what needs to be done
    }

    pub fn exit(self: *PausedState, ctx: GameStateContext) void {
        std.debug.print("[PAUSEDSTATE] - exit\n", .{});
        _ = self;
        _ = ctx;
        // do what needs to be done
    }

    pub fn update(self: *PausedState, dt: f32) void {
        _ = self;
        _ = dt;
        // do what needs to be done
    }
    pub fn handleInput(self: *PausedState, input: KeyEvent) ?StateTransitions {
        _ = self;
        return switch (input.keyCode) {
            .P => .PauseToPlay,
            else => null,
        };
    }
};

pub const GameOverState = struct {
    pub fn enter(self: *GameOverState, ctx: GameStateContext) void {
        std.debug.print("[GAMEOVERSTATE] - enter\n", .{});
        _ = self;
        _ = ctx;
        // do what needs to be done
    }

    pub fn exit(self: *GameOverState, ctx: GameStateContext) void {
        std.debug.print("[GAMEOVERSTATE] - exit\n", .{});
        _ = self;
        _ = ctx;
        // do what needs to be done
    }

    pub fn update(self: *GameOverState, dt: f32) void {
        _ = self;
        _ = dt;
        // do what needs to be done
    }
    pub fn handleInput(self: *GameOverState, input: KeyEvent) ?StateTransitions {
        _ = self;
        _ = input;
        return null;
    }
};
pub const GameState = union(enum) {
    MenuState: MenuState,
    PlayingState: PlayingState,
    PausedState: PausedState,
    GameOverState: GameOverState,

    pub fn enter(self: *GameState, ctx: GameStateContext) void {
        switch (self.*) {
            inline else => |*s| s.enter(ctx),
        }
    }

    pub fn exit(self: *GameState, ctx: GameStateContext) void {
        switch (self.*) {
            inline else => |*s| s.exit(ctx),
        }
    }

    pub fn update(self: *GameState, dt: f32) void {
        switch (self.*) {
            inline else => |*s| s.update(dt),
        }
    }
    pub fn handleInput(self: *GameState, input: KeyEvent) ?StateTransitions {
        switch (self.*) {
            inline else => |*s| return s.handleInput(input),
        }
    }
};
