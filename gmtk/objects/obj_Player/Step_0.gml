var move_h = keyboard_check(vk_right) - keyboard_check(vk_left)

hspd = spd*move_h

x += hspd