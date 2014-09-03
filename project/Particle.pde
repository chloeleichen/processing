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
   float r;
    colR = map(wt, 0, 5, 0, 255);
    colG = map(vx, -1, 1, 0, 128);
    colB = map(vy, -1, 1, 0, 185);
    r = map(rad, minRadius,maxRadius, medRadius, medRadius*1.5 );
    strokeWeight(r);
    stroke(color(colR, colG, colB));

    point(x, y);
    
    //print("rad =" + rad + "\n");


    
  }
}
