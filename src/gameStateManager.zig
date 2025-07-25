const std = @import("std");

const gss = @import("gameStates.zig");
const GameState = gss.GameState;
const PlayingState = gss.PlayingState;
const MenuState = gss.MenuState;
const PausedState = gss.PausedState;
const GameOverState = gss.GameOverState;

const bge = @import("bridge.zig");
const KeyCodes = bge.GameKeyCode;
const KeyEvent = bge.KeyEvent;
const StateTransitions = bge.StateTransitions;
const GameStateContext = bge.GameStateContext;

pub const GameStateManager = struct {
    current: GameState,
    // ecs: ECS, // not started yet
    // other things needed
    pub fn init() GameStateManager {
        return GameStateManager{
            .current = gss.GameState{ .MenuState = gss.MenuState{} },
        };
    }
    pub fn deinit(self: *GameStateManager) void {
        _ = self;
    }

    pub fn processKeyEvent(self: *GameStateManager, event: KeyEvent) void {
        var transition: ?StateTransitions = null;
        if (event.isPressed) {
            if (event.keyCode == .Esc) {
                // Transition to the MenuState
            } else {
                transition = self.current.handleInput(event); // let the state do it
                // std.debug.print("[GSMANAGER] - Need to transtion to: {any}\n", .{transition});
            }
        }
        if (transition) |t| self.changeState(t);
    }

    pub fn update(self: *GameStateManager, dt: f32) void {
        // std.debug.print("[GAMESTATEMANAGER] - update\n", .{});
        self.current.update(dt);
    }

    fn changeState(self: *GameStateManager, stateTrans: StateTransitions) void {
        var newGameState: GameState = undefined;
        switch (stateTrans) {
            .MenuToPlay => {
                // std.debug.print("[GSMANAGER] - MenuToPlay\n", .{});
                newGameState = GameState{ .PlayingState = PlayingState{} };
            },
            .PauseToPlay => {
                // std.debug.print("[GSMANAGER] - PauseToPlay\n", .{});
                // turn on everything paused again
                // this probably just stores the playstate and restores it when it leaves?
                newGameState = GameState{ .PlayingState = PlayingState{} };
            },
            .PlayToPause => {
                // std.debug.print("[GSMANAGER] - PlayToPause\n", .{});
                newGameState = GameState{ .PausedState = PausedState{} };
                // turn off all the game systems
            },
            .PauseToMenu => {
                // std.debug.print("[GSMANAGER] - PauseToMenu\n", .{});
                newGameState = GameState{ .MenuState = MenuState{} };
                // kill the old gamestate
            },
            .PlayToMenu => {
                // std.debug.print("[GSMANAGER] - PlayToMenu\n", .{});
                newGameState = GameState{ .MenuState = MenuState{} };
                // kill the old game state
            },
            .PlayToGameOver => {
                // std.debug.print("[GSMANAGER] - PauseToGameOver\n", .{});
                newGameState = GameState{ .GameOverState = GameOverState{} };
                // kill the systems
                // remember some state for stats?
            },
            .GameOverToMenu => {
                // std.debug.print("[GSMANAGER] - GameOverToMenu\n", .{});
                newGameState = GameState{ .MenuState = MenuState{} };
                // kill the old game state and reset anew
            },
        }

        const ctx: GameStateContext = GameStateContext{};
        self.current.exit(ctx);
        self.current = newGameState;
        self.current.enter(ctx);
    }
};
