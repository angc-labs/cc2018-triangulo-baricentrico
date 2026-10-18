const rl = @import("raylib");

pub const Triangle = struct {
    a: rl.Vector2, // a - rojo
    b: rl.Vector2, // b - verde
    c: rl.Vector2, // c - azul
};

// calcula el doble del area con signo
pub fn edgeFunction(p1: rl.Vector2, p2: rl.Vector2, p3: rl.Vector2) f32 {
    return (p2.x - p1.x) * (p3.y - p1.y) - (p2.y - p1.y) * (p3.x - p1.x);
}

// calcula el baricentro geometrico del triangulo
pub fn triangleCenter(tri: Triangle) rl.Vector2 {
    return .{
        .x = (tri.a.x + tri.b.x + tri.c.x) / 3.0,
        .y = (tri.a.y + tri.b.y + tri.c.y) / 3.0,
    };
}

// dibuja el triangulo interpolando colores mediante coordenadas baricentricas
// el punto p cambia la proporcion de area
pub fn drawBarycentricTriangle(image: *rl.Image, tri: Triangle, p_center: ?rl.Vector2) void {
    const area = edgeFunction(tri.a, tri.b, tri.c);
    if (area == 0) return;

    // escalas de proporcion de cada color calculadas a partir de la posicion de p
    var scale_a: f32 = 1.0;
    var scale_b: f32 = 1.0;
    var scale_c: f32 = 1.0;

    if (p_center) |p| {
        const pa = @max(0.001, edgeFunction(tri.b, tri.c, p) / area);
        const pb = @max(0.001, edgeFunction(tri.c, tri.a, p) / area);
        const pc = @max(0.001, edgeFunction(tri.a, tri.b, p) / area);

        // p actua como el centro neutral (1/3, 1/3, 1/3) de interpolacion
        // al mover p hacia un lado opuesto, el color del vertice alejado se extiende hacia p
        scale_a = (1.0 / 3.0) / pa;
        scale_b = (1.0 / 3.0) / pb;
        scale_c = (1.0 / 3.0) / pc;
    }

    const min_x: i32 = @intFromFloat(@max(0.0, @floor(@min(tri.a.x, @min(tri.b.x, tri.c.x)))));
    const max_x: i32 = @intFromFloat(@min(@as(f32, @floatFromInt(image.width - 1)), @ceil(@max(tri.a.x, @max(tri.b.x, tri.c.x)))));
    const min_y: i32 = @intFromFloat(@max(0.0, @floor(@min(tri.a.y, @min(tri.b.y, tri.c.y)))));
    const max_y: i32 = @intFromFloat(@min(@as(f32, @floatFromInt(image.height - 1)), @ceil(@max(tri.a.y, @max(tri.b.y, tri.c.y)))));

    var py = min_y;
    while (py <= max_y) : (py += 1) {
        const y = @as(f32, @floatFromInt(py)) + 0.5;
        var px = min_x;
        while (px <= max_x) : (px += 1) {
            const x = @as(f32, @floatFromInt(px)) + 0.5;
            const pt: rl.Vector2 = .{ .x = x, .y = y };

            // coordenadas baricentricas estandar del punto
            const w_a = edgeFunction(tri.b, tri.c, pt) / area;
            const w_b = edgeFunction(tri.c, tri.a, pt) / area;
            const w_c = edgeFunction(tri.a, tri.b, pt) / area;

            // pertenece al triangulo si todas son >= 0
            if (w_a >= 0.0 and w_b >= 0.0 and w_c >= 0.0) {
                // ponderacion modulada por el punto p
                const wa_s = w_a * scale_a;
                const wb_s = w_b * scale_b;
                const wc_s = w_c * scale_c;
                const sum = wa_s + wb_s + wc_s;

                const r_weight = if (sum > 0) wa_s / sum else w_a;
                const g_weight = if (sum > 0) wb_s / sum else w_b;
                const b_weight = if (sum > 0) wc_s / sum else w_c;

                const r: u8 = @intFromFloat(@min(255.0, @max(0.0, r_weight * 255.0)));
                const g: u8 = @intFromFloat(@min(255.0, @max(0.0, g_weight * 255.0)));
                const b: u8 = @intFromFloat(@min(255.0, @max(0.0, b_weight * 255.0)));

                image.drawPixel(px, py, .{ .r = r, .g = g, .b = b, .a = 255 });
            }
        }
    }
}
