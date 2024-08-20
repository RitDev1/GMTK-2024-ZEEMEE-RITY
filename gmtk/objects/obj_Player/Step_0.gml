// Movimento horizontal
image_xscale = scale;
image_yscale = scale;

// Obtém input do jogador
var move_h = keyboard_check(vk_right) - keyboard_check(vk_left);
var jump = keyboard_check(vk_up);

// Movimento horizontal
hspd = spd * move_h * (3 - scale / 3);

// Gravidade
vspd += grav * scale;

// Checa colisão horizontal
if place_meeting(x + hspd, y, obj_Wall) || place_meeting(x + hspd, y, obj_PurpleWall) || place_meeting(x + hspd, y, obj_RedWall) || place_meeting(x + hspd, y, obj_BlueWall) || place_meeting(x + hspd, y, obj_GreenWall)
{
    while !place_meeting(x + sign(hspd), y, obj_Wall) && !place_meeting(x + sign(hspd), y, obj_PurpleWall) && !place_meeting(x + sign(hspd), y, obj_RedWall) && !place_meeting(x + sign(hspd), y, obj_BlueWall) && !place_meeting(x + sign(hspd), y, obj_GreenWall)
    {
        x += sign(hspd);
    }
    hspd = 0;
}

// Checa colisão vertical
if place_meeting(x, y + vspd, obj_Wall) || place_meeting(x, y + vspd, obj_PurpleWall) || place_meeting(x, y + vspd, obj_RedWall) || place_meeting(x, y + vspd, obj_BlueWall) || place_meeting(x, y + vspd, obj_GreenWall)
{
    while !place_meeting(x, y + sign(vspd), obj_Wall) && !place_meeting(x, y + sign(vspd), obj_PurpleWall) && !place_meeting(x, y + sign(vspd), obj_RedWall) && !place_meeting(x, y + sign(vspd), obj_BlueWall) && !place_meeting(x, y + sign(vspd), obj_GreenWall)
    {
        y += sign(vspd);
    }
    vspd = 0;
    on_air = false;
}
else
{
    if place_meeting(x - 5 * hspd, y, obj_Wall) on_air = false;
    else on_air = true;
}

// Colisão com plataforma móvel
if (vspd >= 0)
{
    if place_meeting(x, y + vspd, obj_MovPlat) && !place_meeting(x, y, obj_MovPlat)
    {
        while !place_meeting(x, y + 1 - obj_MovPlat.spd, obj_MovPlat)
        {
            y += 1;
        }
        movplat = true;
    }
    else if place_meeting(x, y + 1, obj_MovPlat)
    {
        if obj_MovPlat.up {
            y = obj_MovPlat.y;
            movplat = true;
            if obj_MovPlat.spd < 0 {
                vspd = obj_MovPlat.spd * -1;
            }
            else vspd = 0;
            on_air = false;
        }
        else {
            y = obj_MovPlat.y;
            x += obj_MovPlat.spd * -1;
            movplat = true;
            on_air = false;
            vspd = 0;
        }
    }
}

if (movplat && !place_meeting(x, y + 1, obj_MovPlat))
{
    movplat = false;
}

// Checa colisão com paredes coloridas para alteração de escala
if place_meeting(x, y + 1, obj_RedWall)
{
    scale -= 0.4; 
}

if place_meeting(x, y + 1, obj_BlueWall) && !place_meeting(x-2, y-5, obj_Wall) && !place_meeting(x, y, obj_PurpleWall) && !place_meeting(x, y, obj_RedWall) && !place_meeting(x, y, obj_BlueWall) && !place_meeting(x, y, obj_GreenWall)
{
    scale += 0.4; 
}

// Colisão com a GreenWall que muda de tamanho junto com o jogador
if place_meeting(x, y + 1, obj_GreenWall)
{
    // A GreenWall deve ajustar sua escala com base na escala do jogador
    with (obj_GreenWall)
    {
        image_xscale = other.scale;
        image_yscale = other.scale;
    }
}

// Verifica se o jogador está pulando
if jump
{
    movplat = false;
    if !on_air && !place_meeting(x, y - 1, obj_Wall)
    {
        vspd = -spd * 1.5 * scale;
    }
    else if place_meeting(x - 1, y, obj_PurpleWall) || place_meeting(x + 1, y, obj_PurpleWall)
    {
        vspd = -spd * 1.5 * scale;
        hspd = -sign(hspd) * spd * (4 - scale / 2);
        on_air = true;
    }
}

// Alteração de escala com teclas Z e X
if keyboard_check(ord("Z"))
{
    scale -= scale_speed;
}
else if keyboard_check(ord("X")) && !place_meeting(x-1, y-1, obj_Wall) && !place_meeting(x-1, y-1, obj_PurpleWall) && !place_meeting(x, y, obj_RedWall) && !place_meeting(x, y, obj_BlueWall) && !place_meeting(x, y, obj_GreenWall)
{
    scale += scale_speed;
}

// Limita a escala
scale = max(1, scale);
scale = min(scale, 5);

// Checa colisão com espinhos
if place_meeting(x, y, obj_Spike)
{
    game_over = true;
}

// Reinicia o jogo
if game_over
{
    room_restart();
}

// Se o jogador cair do nível
if y > 300
{
    game_over = true;
}

// Movimenta o jogador
x += hspd;
y += vspd;

// Checa colisão com a porta
if place_meeting(x, y, obj_Door) && keyboard_check(vk_up)
{
    if scale < 2.5 
        room_goto_next();
}
