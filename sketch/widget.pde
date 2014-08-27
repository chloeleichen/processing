abstract class Widget{
  PVector location;
  float sz;
  color col;
  
  Widget(){
    this(new PVector(random(width), random(height)), random(30), color(random(255), random(255), random(255)));
  }
  
  Widget(PVector loc, float s, color c){
   location = loc;
   sz = s;
   col = c;
  }
  
  abstract void display();
  
  abstract void move();
  
  abstract void setSpeed(PVector v);
  
}


