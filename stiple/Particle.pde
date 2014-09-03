class Particle
{
  float  x,y,vx,vy,rad;
  float  fx,fy,wt;

  Particle(float _x, float _y)
  {
    vx = 0;
    vy = 0;
    x = _x;
    y = _y;
    rad = 1;
  }
}
