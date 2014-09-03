class Particle
{
  float  x,y,vx,vy,rad;
  float  fx,fy,wt;
  float colR, colG, colB;


  Particle(float _x, float _y)
  {
    vx = 0;
    vy = 0;
    x = _x;
    y = _y;
    rad = 1;

    
  }
  
  void display(){
    colR = map(wt, 0, 5, 0, 255);
    colG = map(vx, -1, 1, 0, 128);
    colB = map(vy, -1, 1, 0, 185);
    stroke(color(colR, colG, colB));

    point(x, y);
    
    //print("vx =" + vx + "\n");


    
  }
}
