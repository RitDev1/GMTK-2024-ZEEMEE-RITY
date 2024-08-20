if up
{
	y -= spd
	if (y > y0 or y< y0 - range*16){
		spd *= -1;
	}

}
else
{
	x -= spd
	if (x> x0 or x< x0 - range*16){
		spd *= -1;
	}
}