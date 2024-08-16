var move_h = keyboard_check(vk_right) - keyboard_check(vk_left)
var jump = keyboard_check(vk_up)

hspd = spd*move_h

if (!on_air && jump)
{
	vspd = -spd
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
		y += sign(hspd)
	}
	vspd = 0
	on_air = false
}


x += hspd
y += vspd