class Particle
{
  float  x,y,vx,vy,rad;
  float  fx,fy,wt;
  float colR, colG, colB;
  float dice = random(3);
  



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

    
//    if (dice <1){
//      
//    noStroke();
//    fill(color(colR, colG, colB));
//    rect(x, y,r,r);
//    }
//    
//    if ((1 < dice) &&(dice <2)){
//       noStroke();
//      fill(color(colR, colG, colB));
//      
//      ellipse(x, y,r,r);
//    }
//    
//     if ((2 < dice) &&(dice<3)){
//      line(x, y,x+r,y+r);
//    }
//    else{
    strokeWeight(r);
    stroke(color(colR, colG, colB));
    point(x, y);
  //}
    
    //print("rad =" + rad + "\n");


    
  }
}
