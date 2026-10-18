pub const packages = struct {
    pub const @"N-V-__8AAEXAmAArH0MVL51g7bvErPrgngfsOY9pTJEZCb8O" = struct {
        pub const build_root = "/home/angc__/UVG/graficas/c2018-triangulo-baricentrico/zig-pkg/N-V-__8AAEXAmAArH0MVL51g7bvErPrgngfsOY9pTJEZCb8O";
        pub const deps: []const struct { []const u8, []const u8 } = &.{};
    };
    pub const @"N-V-__8AAJl1DwBezhYo_VE6f53mPVm00R-Fk28NPW7P14EQ" = struct {
        pub const build_root = "/home/angc__/UVG/graficas/c2018-triangulo-baricentrico/zig-pkg/N-V-__8AAJl1DwBezhYo_VE6f53mPVm00R-Fk28NPW7P14EQ";
        pub const deps: []const struct { []const u8, []const u8 } = &.{};
    };
    pub const @"N-V-__8AALShqgXkvqYU6f__FrA22SMWmi2TXCJjNTO1m8XJ" = struct {
        pub const available = false;
    };
    pub const @"N-V-__8AAPPCmABYkTrLoRGTR6whFQP1bvg7p5vpLsKIcn4G" = struct {
        pub const available = false;
    };
    pub const @"raylib-6.0.0-whq8uM2eNwXVGGNZwCSIfww2flgpamJLoaJ9Tau5lbJa" = struct {
        pub const build_root = "/home/angc__/UVG/graficas/c2018-triangulo-baricentrico/zig-pkg/raylib-6.0.0-whq8uM2eNwXVGGNZwCSIfww2flgpamJLoaJ9Tau5lbJa";
        pub const build_zig = @import("raylib-6.0.0-whq8uM2eNwXVGGNZwCSIfww2flgpamJLoaJ9Tau5lbJa");
        pub const deps: []const struct { []const u8, []const u8 } = &.{
            .{ "xcode_frameworks", "N-V-__8AALShqgXkvqYU6f__FrA22SMWmi2TXCJjNTO1m8XJ" },
            .{ "raygui", "N-V-__8AAPPCmABYkTrLoRGTR6whFQP1bvg7p5vpLsKIcn4G" },
            .{ "emsdk", "N-V-__8AAJl1DwBezhYo_VE6f53mPVm00R-Fk28NPW7P14EQ" },
        };
    };
    pub const @"raylib_zig-6.0.0-KE8REN2mBQC2nQqk9ILHtZgMfQ-3tZpKCvyhmyUPra_3" = struct {
        pub const build_root = "/home/angc__/UVG/graficas/c2018-triangulo-baricentrico/zig-pkg/raylib_zig-6.0.0-KE8REN2mBQC2nQqk9ILHtZgMfQ-3tZpKCvyhmyUPra_3";
        pub const build_zig = @import("raylib_zig-6.0.0-KE8REN2mBQC2nQqk9ILHtZgMfQ-3tZpKCvyhmyUPra_3");
        pub const deps: []const struct { []const u8, []const u8 } = &.{
            .{ "raygui", "N-V-__8AAEXAmAArH0MVL51g7bvErPrgngfsOY9pTJEZCb8O" },
            .{ "emsdk", "N-V-__8AAJl1DwBezhYo_VE6f53mPVm00R-Fk28NPW7P14EQ" },
            .{ "raylib", "raylib-6.0.0-whq8uM2eNwXVGGNZwCSIfww2flgpamJLoaJ9Tau5lbJa" },
        };
    };
};

pub const root_deps: []const struct { []const u8, []const u8 } = &.{
    .{ "raylib_zig", "raylib_zig-6.0.0-KE8REN2mBQC2nQqk9ILHtZgMfQ-3tZpKCvyhmyUPra_3" },
};
