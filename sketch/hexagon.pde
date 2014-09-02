class Hexagon extends Widget{
  
  int nSides = 6;
  float r;
  float rot;
  PVector speed;
  
  Hexagon(){
    this(new PVector(random(width), random(height)), 30, color(0));
  }
 
 Hexagon(PVector loc, int s, color c){
   super(loc,s,c);
   r = sz/2;
   rot = 0;
   speed = new PVector(random(-2, 2), random(-2,2));
 } 
 
 
 void setSpeed(PVector v){
   v.mult(2);
   speed = v;
 }
 
 
 void display(){
   float x1, y1;
   float theta = rot;
   noStroke();
   fill(col);
   beginShape();
   for(int i = 0; i < nSides; i ++){
     
     x1 = location.x +r*cos(theta);
     y1 = location.y + r*sin(theta);
     vertex(x1, y1);
     theta += PI/3;
   }
   endShape(CLOSE);
 }
 
 void move(){
   rot += 0.01;
   location.add(speed);
   bounce();
 }
 
 
 void bounce(){
   if((location.x < r) || (location.x > width -r)){
      speed.x = -speed.x;
    }
    
        else if((location.y < r) || (location.y > width -r)){
      speed.y = -speed.y;
    }
 }
 
 
   
  boolean clicked(){
    PVector m = new PVector(mouseX, mouseY);
    return (PVector.dist(location, m)< r);
  }
}
 
   
   
   
     
   
   
  
  
  
