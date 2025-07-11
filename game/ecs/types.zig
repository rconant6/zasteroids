pub const rend = @import("renderer");
pub const Entity = @import("entity.zig").Entity;
pub const EntityConfig = @import("entityConfig.zig");
pub const EntityHandle = @import("entityHandle.zig").EntityHandle;
pub const EntityManager = @import("manager.zig").EntityManager;
pub const InputManager = @import("../inputManager.zig").InputManager;

const comps = @import("components.zig");
pub const ControlComp = comps.ControlComp;
pub const PlayerComp = comps.PlayerComp;
pub const RenderComp = comps.RenderComp;
pub const TransformComp = comps.TransformComp;
pub const VelocityComp = comps.VelocityComp;

const storage = @import("compStorage.zig");
pub const ControlCompStorage = storage.ControlCompStorage;
pub const PlayerCompStorage = storage.PlayerCompStorage;
pub const RenderCompStorage = storage.RenderCompStorage;
pub const TransformCompStorage = storage.TransformCompStorage;
pub const VelocityCompStorage = storage.VelocityCompStorage;

const command = @import("commands.zig");
pub const InputCommand = command.InputCommand;
pub const Command = command.Command;
pub const EntityCommand = command.EntityCommand;
pub const InputWrapper = command.InputWrapper;

// MARK: Types
pub const ComponentTag = enum {
    Control,
    Player,
    Render,
    Transform,
    Velocity,
};

pub const ComponentType = union(ComponentTag) {
    Control: ControlComp,
    Player: PlayerComp,
    Render: RenderComp,
    Transform: TransformComp,
    Velocity: VelocityComp,
};
