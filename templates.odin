package main
import rl "vendor:raylib"
//
basicTemplate :: entity {
    isEnabled = true,
}

playerTemplate := basicTemplate {
    position = [2]f32{500,500},
    size = [2]f32{16,16},
    defaultColor = rl.PURPLE,
    type = PLAYER,
    speed = 128.0,
}
