disc d1, d2;

void setup(){
  size(500, 500);
  background(255);
  d1 = new disc();
  d2 = new disc();
}


void draw(){
  d1.move();
  d1.display();
  
  d2.move();
  d2.display();
  
}
