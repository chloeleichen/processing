ball b1;
ball b2;
stick s;

int stickLen = 80;


PVector intLoc1;
PVector intLoc2;




void setup(){
  size(500, 500);
  background(255);
  intLoc1 = new PVector(width/2, height/2);
  intLoc2 = new PVector(width/2, height- stickLen);
  
  float r = 10;
  
  b1 = new ball(intLoc1, r, color(0));
  b2 = new ball(intLoc2, r, color(0));
  
  s = new stick(b1, b2);
}

void draw(){
  background(255);
  s.update();
  s.display();
 
}
