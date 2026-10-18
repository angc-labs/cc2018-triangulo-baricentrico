const rl = @import("raylib");
const baricentrico = @import("baricentrico.zig");
const Triangle = baricentrico.Triangle;

const DragHandle = enum {
    none,
    vertex_a,
    vertex_b,
    vertex_c,
    point_p,
};

fn distSq(p1: rl.Vector2, p2: rl.Vector2) f32 {
    const dx = p1.x - p2.x;
    const dy = p1.y - p2.y;
    return dx * dx + dy * dy;
}

fn drawControlPoint(pos: rl.Vector2, inner_color: rl.Color, radius: f32) void {
    rl.drawCircleV(pos, radius + 2.0, .white);
    rl.drawCircleV(pos, radius, inner_color);
}

pub fn main() !void {
    const screenWidth = 800;
    const screenHeight = 450;

    rl.initWindow(screenWidth, screenHeight, "Triangulo Baricentrico");
    defer rl.closeWindow();

    rl.setTargetFPS(60);

    // triangulo inicial
    var current_tri = Triangle{
        .a = .{ .x = 20, .y = 430 },
        .b = .{ .x = 400, .y = 20 },
        .c = .{ .x = 780, .y = 430 },
    };

    // imagen y textura para la ventana interactiva
    var img = rl.genImageColor(screenWidth, screenHeight, .black);
    defer img.unload();

    var point_p = baricentrico.triangleCenter(current_tri);
    baricentrico.drawBarycentricTriangle(&img, current_tri, point_p);

    const texture = try rl.loadTextureFromImage(img);
    defer texture.unload();

    var active_handle: DragHandle = .none;
    var prev_mouse = rl.getMousePosition();
    var needs_update = false;

    while (!rl.windowShouldClose()) {
        const mouse = rl.getMousePosition();
        const grab_radius_sq: f32 = 16.0 * 16.0;

        // iniciar arrastre con clic izquierdo
        if (rl.isMouseButtonPressed(.left)) {
            if (distSq(mouse, point_p) <= grab_radius_sq) {
                active_handle = .point_p;
            } else if (distSq(mouse, current_tri.a) <= grab_radius_sq) {
                active_handle = .vertex_a;
            } else if (distSq(mouse, current_tri.b) <= grab_radius_sq) {
                active_handle = .vertex_b;
            } else if (distSq(mouse, current_tri.c) <= grab_radius_sq) {
                active_handle = .vertex_c;
            }
        }

        if (rl.isMouseButtonReleased(.left)) {
            active_handle = .none;
        }

        // arrastrar el punto activo
        if (active_handle != .none and rl.isMouseButtonDown(.left)) {
            const dx = mouse.x - prev_mouse.x;
            const dy = mouse.y - prev_mouse.y;

            if (dx != 0 or dy != 0) {
                switch (active_handle) {
                    .vertex_a => {
                        current_tri.a.x += dx;
                        current_tri.a.y += dy;
                    },
                    .vertex_b => {
                        current_tri.b.x += dx;
                        current_tri.b.y += dy;
                    },
                    .vertex_c => {
                        current_tri.c.x += dx;
                        current_tri.c.y += dy;
                    },
                    .point_p => {
                        point_p.x += dx;
                        point_p.y += dy;
                    },
                    .none => {},
                }
                needs_update = true;
            }
        }
        prev_mouse = mouse;

        // actualizar la textura solo cuando cambie la geometria o el punto p
        if (needs_update) {
            rl.imageClearBackground(&img, .black);
            baricentrico.drawBarycentricTriangle(&img, current_tri, point_p);
            rl.updateTexture(texture, img.data);
            needs_update = false;
        }

        // dibujar en pantalla
        rl.beginDrawing();
        defer rl.endDrawing();

        rl.clearBackground(.black);
        rl.drawTexture(texture, 0, 0, .white);

        drawControlPoint(current_tri.a, .red, 7.0);
        drawControlPoint(current_tri.b, .green, 7.0);
        drawControlPoint(current_tri.c, .blue, 7.0);
        drawControlPoint(point_p, .white, 8.0);
    }
}
