package main

import "core:fmt"
import rl "vendor:raylib"

firstFreeIndex : int = 0
capacity : int = 4
entities : [dynamic]entity

GetEntityCorner :: proc(entity : ^entity) -> rl.Vector2
{
    offset : rl.Vector2 = entity^.pivot * entity^.size
    return entity^.position - offset
}

addEntity :: proc(newEntity : entity)
{
    append(&entities, newEntity);
    firstFreeIndex += 1;
    // if(newEntity.type == ENEMY) { enemiesCount++; }
}

UpdatePlayerMovement :: proc()
{
    for i : int = 0; i < firstFreeIndex; i += 1
    {
        if(entities[i].type != PLAYER) { continue; }
        player : ^entity = &entities[i];
        speed : f32 = player^.speed * rl.GetFrameTime();
        // player^.dashDirection = [2]f32{0,0};
        if(rl.IsKeyDown(rl.KeyboardKey.W))
        {
            player^.position.y -= speed;
            // player^.dashDirection.y = -1;
        }
        if(rl.IsKeyDown(rl.KeyboardKey.S))
        {
            player^.position.y += speed;
            // player->dashDirection.y = 1;
        }
        if(rl.IsKeyDown(rl.KeyboardKey.A))
        {
            player^.position.x -= speed;
            // player->dashDirection.x = -1;
        }
        if(rl.IsKeyDown(rl.KeyboardKey.D))
        {
            player^.position.x += speed;
            // player->dashDirection.x = 1;
        }
    }
}


main :: proc() {
    fmt.println("Hellope!")

    // rl.SetConfigFlags(rl.FLAG_VSYNC_HINT);
    rl.InitWindow(1280, 720, "GameRunner - Raylib - Odin")

    addEntity(entity {
        position=[2]f32{400,400},
        size=[2]f32{10,10},
        defaultColor=rl.GREEN,
        type=DEFAULT
        }
    );
    addEntity(GetPlayerTemplate);
    for !rl.WindowShouldClose()
    {
        rl.BeginDrawing()
            rl.ClearBackground(rl.SKYBLUE)
            UpdatePlayerMovement();
            rl.DrawFPS(0,0)
            for i : int = 0; i < firstFreeIndex; i+= 1
            {
                if !entities[i].isEnabled { continue }
                startPos : rl.Vector2 = GetEntityCorner(&entities[i])
                rl.DrawRectangleV(startPos, entities[i].size, entities[i].defaultColor);
            }
        rl.EndDrawing()
    }

    rl.CloseWindow()
}
