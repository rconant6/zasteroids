const rl = @import("raylib");

pub const GameColors = struct {
    pub const Ship = struct {
        pub const hullFill = rl.Color.init(51, 68, 85, 255);
        pub const hullOutline = rl.Color.init(136, 153, 170, 255);
        pub const cockpitFill = rl.Color.init(136, 221, 255, 255);
        pub const cockpitOutline = rl.Color.white;
        pub const engineHousing = rl.Color.init(68, 85, 102, 255);
        pub const inactivePort = rl.Color.init(51, 51, 51, 255);
        pub const inactivePortOutline = rl.Color.init(85, 85, 85, 255);
        pub const outerFlame = rl.Color.init(255, 221, 24, 255);
        pub const innerFlame = rl.Color.init(255, 102, 34, 255);
        pub const engineGlow = rl.Color.init(255, 102, 34, 80);
        pub const thrusterGlow = rl.Color.init(255, 102, 34, 51);
    };

    pub const PlayerMissile = struct {
        pub const missileBody = rl.Color.init(136, 221, 255, 255);
        pub const missileOutline = rl.Color.white;
        pub const entergyCore = rl.Color.white;
        pub const thrusterGlow = rl.Color.init(68, 170, 255, 255);
        pub const energyTail = rl.Color.init(138, 221, 255, 100);
    };
    pub const UFOMissile = struct {
        pub const missileBody = rl.Color.orange;
        pub const missileOutline = rl.Color.init(255, 170, 102, 255);
        pub const missileCoreOuter = rl.Color.init(255, 221, 34, 255);
        pub const missileCoreInner = rl.Color.init(255, 255, 255, 255);
        pub const plasmaTrail = rl.Color.init(255, 102, 34, 100);
        pub const heatRripples = rl.Color.init(255, 170, 68, 255);
    };

    pub const UFO = struct {
        pub const mainBody = rl.Color.init(120, 130, 180, 255);
        pub const upperSection = rl.Color.init(170, 200, 230, 255);
        pub const saucerRim = rl.Color.init(190, 210, 180, 255);
        pub const bottomDetails = rl.Color.init(80, 90, 130, 255);
    };

    pub const Asteroid = struct {
        // Grey-brown tones (common asteroid colors)
        pub const rustyBrown = rl.Color{ .r = 120, .g = 110, .b = 100, .a = 255 };
        pub const darkGreyBrown = rl.Color{ .r = 90, .g = 85, .b = 75, .a = 255 };
        pub const lightStone = rl.Color{ .r = 135, .g = 125, .b = 115, .a = 255 };

        // Darker accents
        pub const charcoal = rl.Color{ .r = 70, .g = 65, .b = 60, .a = 255 };
        pub const darkRust = rl.Color{ .r = 85, .g = 75, .b = 65, .a = 255 };

        // Lighter highlights
        pub const paleStone = rl.Color{ .r = 160, .g = 150, .b = 140, .a = 255 };
        pub const tan = rl.Color{ .r = 150, .g = 140, .b = 120, .a = 255 };

        // Subtle mineral tones
        pub const boulderGrey = rl.Color{ .r = 110, .g = 100, .b = 90, .a = 255 };
        pub const mossyRock = rl.Color{ .r = 100, .g = 95, .b = 80, .a = 255 };
        pub const sandyBrown = rl.Color{ .r = 130, .g = 115, .b = 95, .a = 255 };

        // Reddish iron-rich patches
        pub const rustRed = rl.Color{ .r = 140, .g = 100, .b = 85, .a = 255 };
        pub const copper = rl.Color{ .r = 125, .g = 95, .b = 75, .a = 255 };

        pub const fill = null;
    };

    pub const Game = struct {
        pub const background = rl.Color.init(16, 16, 32, 255);
        pub const text = rl.Color.init(85, 85, 102, 255);
    };
};
