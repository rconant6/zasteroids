const std = @import("std");

const Colors = @import("colors.zig").Colors;
const EntityType = @import("entity.zig").EntityType;
const Shape = @import("common.zig").Shape;
const Vec2 = @import("raylib").Vector2;
// MARK: Ships
pub const ShipTemplate = struct {
    shapes: []const Shape, // Hull, Cockpit, LWing, RWing, Engine, EnginePort, InnerFlame, OuterFlame
};

pub fn getShipTemplate(shipType: EntityType) ?ShipTemplate {
    const typeStr = @tagName(shipType);
    return shipTemplates.get(typeStr);
}

pub const shipTemplates = std.StaticStringMap(ShipTemplate).initComptime(.{
    .{
        // player
        "PlayerShip", ShipTemplate{
            .shapes = &[_]Shape{
                .{ // Hull
                    .points = &[_]Vec2{
                        Vec2.init(0, 0.5), // nose 0
                        Vec2.init(0.15, 0.2), // upper right 1
                        Vec2.init(0.25, -0.1), // mid right 2
                        Vec2.init(0.2, -0.3), // lower right curve 3
                        Vec2.init(0.1, -0.35), // lower right end 4
                        Vec2.init(-0.1, -0.35), // lower left end 5
                        Vec2.init(-0.2, -0.3), // lower left curve 6
                        Vec2.init(-0.25, -0.1), // mid left 7
                        Vec2.init(-0.15, 0.2), // upper left 8
                    },
                    .vertices = &[_][3]usize{
                        [3]usize{ 0, 1, 7 },
                        [3]usize{ 0, 1, 2 },
                        [3]usize{ 0, 2, 3 },
                        [3]usize{ 0, 3, 4 },
                        [3]usize{ 0, 4, 5 },
                        [3]usize{ 0, 5, 6 },
                        [3]usize{ 0, 6, 7 },
                        [3]usize{ 0, 7, 8 },
                    },
                    .fill = Colors.Ship.hullFill,
                    .outline = Colors.Ship.hullOutline,
                    .thickness = 1.0,
                },
                .{ // Cockpit
                    .points = &[_]Vec2{
                        Vec2.init(0, 0.3), // top
                        Vec2.init(0.05, 0.2), // right CP
                        Vec2.init(0.05, 0.1), // right bot CP
                        Vec2.init(0, 0.05), // bottom
                        Vec2.init(-0.05, 0.1), // left bot CP
                        Vec2.init(-0.05, 0.2), // left CP
                        Vec2.init(0, 0.3), // close loop
                    },
                    .vertices = &[_][3]usize{
                        [3]usize{ 6, 0, 1 },
                        [3]usize{ 6, 1, 2 },
                        [3]usize{ 6, 2, 3 },
                        [3]usize{ 6, 3, 4 },
                        [3]usize{ 6, 4, 5 },
                        [3]usize{ 6, 5, 6 },
                    },
                    .fill = Colors.Ship.cockpitFill,
                    .outline = Colors.Ship.cockpitOutline,
                    .thickness = 1.0,
                },
                .{ // Lwing
                    .points = &[_]Vec2{
                        Vec2.init(0.25, -0.1),
                        Vec2.init(0.3, 0),
                        Vec2.init(0.15, 0.2),
                    },
                    .vertices = &[_][3]usize{
                        [3]usize{ 0, 2, 1 },
                    },
                    .fill = Colors.Ship.hullFill,
                    .outline = Colors.Ship.hullOutline,
                    .thickness = 0.8,
                },
                .{ // Rwing
                    .points = &[_]Vec2{
                        Vec2.init(-0.25, -0.1),
                        Vec2.init(-0.3, 0),
                        Vec2.init(-0.15, 0.2),
                    },
                    .vertices = &[_][3]usize{
                        [3]usize{ 0, 1, 2 },
                    },
                    .fill = Colors.Ship.hullFill,
                    .outline = Colors.Ship.hullOutline,
                    .thickness = 0.8,
                },
                .{ // Engine
                    .points = &[_]Vec2{
                        Vec2.init(-0.1, -0.45),
                        Vec2.init(0.1, -0.45),
                        Vec2.init(0.1, -0.35),
                        Vec2.init(-0.1, -0.35),
                    },
                    .vertices = &[_][3]usize{
                        [3]usize{ 0, 2, 1 },
                        [3]usize{ 0, 3, 2 },
                    },
                    .fill = Colors.Ship.engineHousing,
                    .outline = Colors.Ship.engineHousing,
                    .thickness = 1.0,
                },
                .{ // EnginePort
                    .points = &[_]Vec2{
                        Vec2.init(-0.05, -0.45),
                        Vec2.init(0.05, -0.45),
                        Vec2.init(0.05, -0.42),
                        Vec2.init(-0.05, -0.42),
                    },
                    .vertices = &[_][3]usize{
                        [3]usize{ 0, 2, 1 },
                        [3]usize{ 0, 3, 2 },
                    },
                    .fill = Colors.Ship.inactivePort,
                    .outline = Colors.Ship.inactivePortOutline,
                    .thickness = 1.5,
                },
                .{ // InnerFlame
                    .points = &[_]Vec2{
                        Vec2.init(-0.04, -0.45),
                        Vec2.init(-0.06, -0.58),
                        Vec2.init(-0.03, -0.64),
                        Vec2.init(0, -0.75),
                        Vec2.init(0.03, -0.64),
                        Vec2.init(0.06, -0.58),
                        Vec2.init(0.04, -0.45),
                    },
                    .vertices = &[_][3]usize{
                        [3]usize{ 0, 2, 1 },
                        [3]usize{ 0, 3, 2 },
                        [3]usize{ 0, 4, 3 },
                        [3]usize{ 0, 5, 4 },
                        [3]usize{ 0, 6, 5 },
                    },
                    .fill = Colors.Ship.innerFlame,
                    .outline = null,
                    .thickness = null,
                },
                .{ // OuterFlame
                    .points = &[_]Vec2{
                        Vec2.init(-0.05, -0.45),
                        Vec2.init(-0.08, -0.55),
                        Vec2.init(-0.05, -0.6),
                        Vec2.init(0, -0.7),
                        Vec2.init(0.05, -0.6),
                        Vec2.init(0.08, -0.55),
                        Vec2.init(0.05, -0.45),
                    },
                    .vertices = &[_][3]usize{
                        [3]usize{ 0, 2, 1 },
                        [3]usize{ 0, 3, 2 },
                        [3]usize{ 0, 4, 3 },
                        [3]usize{ 0, 5, 4 },
                        [3]usize{ 0, 6, 5 },
                    },
                    .fill = Colors.Ship.outerFlame,
                    .outline = null,
                    .thickness = null,
                },
            },
        },
    },
});

// MARK: Asteroids
pub const AsteroidTemplate = struct {
    shapes: []const Shape,
    baseVelocity: Vec2,
    scoreValue: u32,
    scale: f32,
    rotationSpeed: f32,
};

pub fn getAsteroidTemplate(asteroidType: EntityType) ?AsteroidTemplate {
    const typeStr = @tagName(asteroidType);
    return asteroidTemplates.get(typeStr);
}

pub const AsteroidSpawnConfig = struct {
    minVelocity: f32 = 0.1,
    maxVelocity: f32 = 1.0,
    // Add other spawn parameters as needed
};

pub const asteroidSpawnConfig = AsteroidSpawnConfig{
    .minVelocity = 0.1,
    .maxVelocity = 1.0,
};

pub const asteroidTemplates = std.StaticStringMap(AsteroidTemplate).initComptime(
    .{
        .{
            "LargeAst", AsteroidTemplate{
                .scale = 35.0,
                .baseVelocity = Vec2.init(0.5, 0.15),
                .scoreValue = 50,
                .rotationSpeed = 0.2,
                .shapes = &[_]Shape{
                    .{
                        .points = &[_]Vec2{
                            Vec2.init(0.2, 0.9),
                            Vec2.init(0.7, 0.5),
                            Vec2.init(0.9, 0.0),
                            Vec2.init(0.6, -0.5),
                            Vec2.init(0.8, -0.8),
                            Vec2.init(0.4, -0.9),
                            Vec2.init(-0.2, -0.7),
                            Vec2.init(-0.6, -0.8),
                            Vec2.init(-0.9, -0.3),
                            Vec2.init(-0.7, 0.2),
                            Vec2.init(-0.9, 0.5),
                            Vec2.init(-0.3, 0.8),
                        },
                        .vertices = &[_][3]usize{},
                        .fill = Colors.Asteroid.rustyBrown,
                        .outline = Colors.Asteroid.copper,
                        .thickness = 1.5,
                    },
                    // other shapes if requried
                },
            },
        },
        .{ "MediumAst", AsteroidTemplate{
            .scale = 28.0,
            .baseVelocity = Vec2.init(0.5, 0.15),
            .scoreValue = 100,
            .rotationSpeed = 0.1,
            .shapes = &[_]Shape{
                .{
                    .points = &[_]Vec2{
                        Vec2.init(0.1, 0.6),
                        Vec2.init(0.5, 0.3),
                        Vec2.init(0.6, 0.0),
                        Vec2.init(0.3, -0.4),
                        Vec2.init(0.5, -0.5),
                        Vec2.init(0.2, -0.6),
                        Vec2.init(-0.3, -0.5),
                        Vec2.init(-0.5, -0.2),
                        Vec2.init(-0.4, 0.2),
                        Vec2.init(-0.5, 0.5),
                    },
                    .vertices = &[_][3]usize{},
                    .fill = Colors.Asteroid.darkRust,
                    .outline = Colors.Asteroid.rustRed,
                    .thickness = 1.0,
                },
            },
        } },
        .{ "SmallAst", AsteroidTemplate{
            .scale = 20.0,
            .baseVelocity = Vec2.init(0.5, -0.25),
            .scoreValue = 200,
            .rotationSpeed = 0.5,
            .shapes = &[_]Shape{
                .{
                    .points = &[_]Vec2{
                        Vec2.init(0.0, 0.4),
                        Vec2.init(0.3, 0.2),
                        Vec2.init(0.4, -0.1),
                        Vec2.init(0.2, -0.3),
                        Vec2.init(-0.1, -0.3),
                        Vec2.init(-0.3, -0.2),
                        Vec2.init(-0.3, 0.0),
                        Vec2.init(-0.2, 0.3),
                    },
                    .vertices = &[_][3]usize{},
                    .fill = Colors.Asteroid.charcoal,
                    .outline = Colors.Asteroid.darkGreyBrown,
                    .thickness = 0.8,
                },
            },
        } },
    },
);
