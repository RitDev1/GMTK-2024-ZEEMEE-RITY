image_xscale = scale
image_yscale = scale

var move_h = keyboard_check(vk_right) - keyboard_check(vk_left)
var jump = keyboard_check(vk_up)

hspd = spd * move_h * (3 - scale / 3)

vspd += grav * scale

if place_meeting(x + hspd, y, obj_Wall) || place_meeting(x + hspd, y, obj_PurpleWall)
    {
    while !place_meeting(x + sign(hspd), y, obj_Wall) && !place_meeting(x + sign(hspd), y, obj_PurpleWall)
        {
        x += sign(hspd)
        }
    hspd = 0
    }

if place_meeting(x, y + vspd, obj_Wall) || place_meeting(x, y + vspd, obj_PurpleWall)
    {
    while !place_meeting(x, y + sign(vspd), obj_Wall) && !place_meeting(x, y + sign(vspd), obj_PurpleWall)
        {
        y += sign(vspd)
        }
    vspd = 0
    on_air = false
    }
else
    {
    on_air = true
    }

if jump
    {
    if !on_air && !place_meeting(x, y - 1, obj_Wall)
        {
        vspd = -spd * 1.5 * scale
        on_air = true
        }
    else if place_meeting(x-1, y, obj_PurpleWall)||place_meeting(x+1, y, obj_PurpleWall)
        {
        vspd = -spd * 1.5 * scale
        hspd = -sign(hspd) * spd * (4 - scale / 2)
        on_air = true
        }
    }

if keyboard_check(ord("Z"))
    {
    scale -= scale_speed
    }
else if keyboard_check(ord("X")) && !place_meeting(x, y, obj_Wall) && !place_meeting(x, y, obj_PurpleWall)
    {
    scale += scale_speed
    }

scale = max(1, scale)
scale = min(scale, 5)

if place_meeting(x, y, obj_Spike)
    {
    game_over = true
    }

if game_over
    {
    room_restart()
    }

if y > 300
    {
    game_over = true
    }

x += hspd
y += vspd

if place_meeting(x, y, obj_Door) && keyboard_check(vk_up)
    {
    if scale == 1
        room_goto_next()
    }
