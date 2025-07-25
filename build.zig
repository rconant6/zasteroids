const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // Get engine dependency
    const engine_dep = b.dependency("engine", .{
        .target = target,
        .optimize = optimize,
    });

    const zasteroids = b.addExecutable(.{
        .name = "zasteroids",
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });

    // Add engine module
    zasteroids.root_module.addImport("engine", engine_dep.module("engine"));

    // Platform-specific linking (copied from engine)
    const target_info = target.result;
    switch (target_info.os.tag) {
        .macos => {
            zasteroids.addLibraryPath(engine_dep.path("zig-out/lib"));
            zasteroids.linkSystemLibrary("macOSBridge");
            zasteroids.linkFramework("Cocoa");
        },
        .windows => {
            @panic("Windows platform bridge not implemented yet");
        },
        .linux => {
            @panic("Linux platform bridge not implemented yet");
        },
        else => {
            @panic("Unsupported platform for engine bridge");
        },
    }

    b.installArtifact(zasteroids);

    // Run step
    const run_cmd = b.addRunArtifact(zasteroids);
    const run_step = b.step("run", "Run zasteroids");
    run_step.dependOn(&run_cmd.step);
}
