image_xscale = scale
image_yscale = scale

var move_h = keyboard_check(vk_right) - keyboard_check(vk_left)
var jump = keyboard_check(vk_up)

hspd = spd*move_h

if (!on_air && jump)
{
	vspd = -spd*1.5
	on_air = true
}

vspd += grav	

if place_meeting(x + hspd, y, obj_Wall)
{
	while !place_meeting(x + sign(hspd), y, obj_Wall)
	{
		x += sign(hspd)
	}
	hspd = 0
}

if place_meeting(x, y + vspd, obj_Wall)
{
	while !place_meeting(x, y + sign(vspd), obj_Wall)
	{
		y += sign(vspd)
	}
	vspd = 0
	on_air = false
}

if (keyboard_check_pressed(ord("Z")))
{
	scale -= 1
}
else if (keyboard_check_pressed(ord("X")))
{
	scale += 1
}

scale = max(1, scale)
scale = min(scale, 5)


x += hspd
y += vspd