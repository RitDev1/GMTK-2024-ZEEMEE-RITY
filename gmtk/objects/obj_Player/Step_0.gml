image_xscale = scale
image_yscale = scale

var move_h = keyboard_check(vk_right) - keyboard_check(vk_left)
var jump = keyboard_check(vk_up)

hspd = spd*move_h

if place_meeting(x, y + 1, obj_Wall)
{
	if (!on_air && jump)
	{
		vspd = -spd*1.5
		on_air = true
	}
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

if (place_meeting(x, y, obj_Door) && keyboard_check(vk_up))
{
	
	if (scale == 1) room_goto_next()
}

if (keyboard_check(ord("Z")))
{
	
		scale -= scale_speed 
}
else if (keyboard_check(ord("X")))
{
	if(!place_meeting(x, y, obj_Wall)) {
	scale += scale_speed }
}

scale = max(1, scale)
scale = min(scale, 5)

if(place_meeting(x,y,obj_Spike)) {
	game_over = true
}

if(game_over == true) {
	room_restart() 
}

if(y > 300) {
	game_over = true
}

x += hspd
y += vspd