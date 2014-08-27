class ball{
  color ballColor;
  float radius;
  PVector location;
  PVector oldLocation;
  PVector nudge;
  
  ball(){
    this(new PVector(random(width), random(height)), random(20), color(random(255)));
  }
    
  ball(PVector loc, float r, color c){
    location = loc;
    radius = r;
    ballColor = c;
    ballColor = color(0);
    
    oldLocation   = location.get();
    nudge = new PVector (random(1,3), random(1,3));
    
    location. add(nudge);  
  }


void display(){
  fill(ballColor);
  ellipse(location.x, location.y, radius, radius);
}

void move(){
  PVector temp = location.get();
  location.x += (location.x - oldLocation.x);
  location.y += (location.y - oldLocation.y);
  
  oldLocation.set(temp);
  bounce();
  
}
void bounce(){
  if(location.x > width-radius){
    location.x = width -radius;
    oldLocation.x = location.x;
    location.x -= nudge.x;
  }
  
  
  if(location.x < radius){
    location.x = radius;
    oldLocation.x = location.x;
    location.x += nudge.x;
  }
  
    if(location.y > height-radius){
    location.y = height -radius;
    oldLocation.y = location.y;
    location.y -= nudge.y;
  }
  
  
    if(location.y < radius){
    location.y = radius;
    oldLocation.y = location.y;
    location.y -= nudge.y;
    }
  
  }
}
  
  
