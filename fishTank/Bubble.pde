class Bubble{
  float mass =1;
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  float r;


  
  
  Bubble(PVector l){
    acceleration = new PVector(0,-1);
    velocity = new PVector(0,random(-2,0));
    location = l.get();
    lifespan = 600.0;

    
      
  }
  
  void run(){
    update();
    display();
    
    
  }
  

  
   void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0.3);
    lifespan -= 2.0;
    
  }
  
  
  void display() {
    pushStyle();
    noStroke();
    float alpha = map(lifespan, 0,600.0, 30, 100);
    fill(32, 79, 250,alpha);
    
    r = 3+height/(location.y+30);
    ellipse(location.x, location.y, r, r);
    popStyle();
  }

  // Is the particle still useful?
  boolean isDead() {
    if ((lifespan < 0.0) || (location.y< 0)){
      return true;
    } else {
      return false;
    }
  }
  
  
   
}
  
  
