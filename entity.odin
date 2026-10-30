package main
import rl "vendor:raylib"

DEFAULT :: 0
PLAYER :: 1 << 1

entity :: struct
{
    position, size, pivot, previousPosition : rl.Vector2,
    defaultColor : rl.Color,
    type : uint,
    speed : f32,
    isEnabled : bool
}
