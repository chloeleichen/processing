float x, y, w;
float spdX, spdY, theta, rotSpd;
float cornerRadiusOffset, dynamicRadius, collisionTheta;



void setup(){
  background(0);
  noFill();
  size(600, 600);
  noSmooth();
  fill(0, 175, 175);           
  noStroke();
  x= width/2;
  y= height/2;
  theta = 0;
  w=150;
  spdX= 1.5;
  spdY= 2.1;
  rotSpd = PI/180;


  
}


void draw(){
  background(255, 127, 0);

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
  float alpha;  
  float edge = sin(theta) * (w/ 2* sin(PI/4));
  println(edge);
  if( ((width -x) < w/2) || x< w/2 )  {
    spdX *= -1;

  }
  
  if( ((height -y) < w/2) || y< w/2 )  {
    spdY *= -1;

  }
}
  
  

  
