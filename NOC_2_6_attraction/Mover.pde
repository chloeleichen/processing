class Mover {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  boolean bounce;
  
  float angle = 0;
  float aVelocity = 0;
  float aAcceleration = 0;

  Mover(PVector _loc,float _m) {
    location = _loc;
    mass = _m;
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);

  }
  
  void applyForce(PVector force) {
    PVector f = PVector.div(force,mass);
    acceleration.add(f);
  }
  
  void update() {
    velocity.add(acceleration);
    location.add(velocity);    
    angle += random(-0.1, 0.5);
    
   
    
//    velocity.x += aVelocity;
    
    
    
    
    acceleration.mult(0);
    
    
  }

  void display(PVector loc) {
    noStroke();
    fill(#f1c40f);
   // rectMode(CENTER);
    pushMatrix();
    translate(loc.x,loc.y);
    rotate(angle);
   ellipse(location.x,location.y,10,10);
    popMatrix();
    
    
    
  }
  
  void doBounce(boolean bounce){
    if(bounce == true){
      velocity.mult(-0.7);
      acceleration.mult(0);
    }
    
}

}


