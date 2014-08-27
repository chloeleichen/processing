float x, y, w;
float spdX, spdY, theta, rotSpd;
float cornerRadiusOffset, dynamicRadius, collisionTheta;



void setup(){
  background(0);
  noFill();
  size(600, 600);
  fill(0, 175, 175);           
  noStroke();
  x= width/2;
  y= height/2;
  w=50;
  spdX= 2.1;
  spdY= 1.5;
  rotSpd = PI/180;


  
}


void draw(){
  background(255);
  
  pushMatrix();
  translate(x, y);
  rotate(theta);
  rect(-w/2, -w/2, w, w);
  popMatrix();
  
  x +=spdX;
  y +=spdY;
  theta +=rotSpd;
  
  collide();
  
}

void collide(){
  
 cornerRadiusOffset = w/2 /cos(PI/4) -w/2 ;
 dynamicRadius = abs(sin(collisionTheta) * cornerRadiusOffset);
 
  if( ((width -x) < w/2+dynamicRadius) || (x< w/2 + dynamicRadius))  {
    spdX *= -1;
    rotSpd *=-1;

  }
  
  if( ((height -y) < (w/2 +dynamicRadius)) || (y< w/2 +dynamicRadius))  {
    spdY *= -1;
    rotSpd *=-1;

  }
  
  collisionTheta += rotSpd*2;
}
  
  

  
