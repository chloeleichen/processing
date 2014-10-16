class Mover {
 float x1,y1, rad1;
 float deg = 0;
  PVector loc;
  PVector velocity;
  PVector acceleration;
  float mass;

  Mover(float m) {
    mass = m;
    velocity = new PVector(1, 0);
    acceleration = new PVector(0, 0);
  }

  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }

  void update() {
    velocity.add(acceleration);
    loc.add(velocity);
    acceleration.mult(0);
  }
  
  void doBounce(boolean bounce){
    
    if(bounce == true){
      velocity.mult(-1.3);
      acceleration.mult(0);
      
      
      
         
          
    }
  }

  void display(PVector _loc) {
    loc = _loc;
    
  
  deg = deg +3;
  rad1 = (PI/180)*deg;
  x1 = random(sin(rad1)*45, sin(rad1)*200)+ loc.x;
  y1 = random(cos(rad1)*45, cos(rad1)*200 )+ loc.y;
  
  
  
  
   
  //background(0);
  noStroke();
  fill(0,10);
  rect(0,0,width,height);
   
  fill(255);
  ellipse(x1,y1,10,10);
   
//Resets deg 
 if (deg>=360)
 {
 deg = 0;
 }
 
 
 
  }
  }

