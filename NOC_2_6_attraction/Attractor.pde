// Attraction
// Daniel Shiffman <http://www.shiffman.net>

// A class for a draggable attractive body in our world

class Attractor {
  float mass;    // Mass, tied to size
  float G;       // Gravitational Constant
  PVector location;   // Location
  float dx;
  float dy;

  Attractor() {
    location = new PVector(width/2,height/2);
    mass = 40;
    G = 0.1;


    
    
   
  }

  PVector attract(Mover m) {
    
    PVector force = new PVector(-m.location.x, -m.location.y);   // Calculate direction of force
    float d = force.mag();                              // Distance between objects
    d = constrain(d,5.0,25.0);                        // Limiting the distance to eliminate "extreme" results for very close or very far objects
    force.normalize();                                  // Normalize vector (distance doesn't matter here, we just want this vector for direction)
    float strength = (G * mass * m.mass) / (d * d);      // Calculate gravitional force magnitude
    force.mult(strength);                                  // Get force vector --> magnitude * direction
    return force;
  }
  
  
 
  
  
  Boolean  checkBounce(Mover m) {
    Boolean bounce = false;
    PVector force = new PVector(-m.location.x, -m.location.y);   // Calculate direction of force
    float d = force.mag(); 
    //println(d);
    if (d <= mass+5){
      bounce = true;
    
    }
    
    return bounce;
      
  }





  // Method to display
  void display() {
    dx = random(-3, 3);
    dy = random(-3, 3);
    ellipseMode(CENTER);
    noStroke();
    fill(#e74c3c);
    pushMatrix();
    translate(location.x, location.y);
    ellipse(0,0,mass*2,mass*2);
    popMatrix();
    
    giggle();
  }
  
  
  void giggle(){
    if((location.x > width/2 +80)||(location.x < width/2 -80)){
      dx = -dx;
    
  }
  
    if((location.y > height/2 +80)||(location.y < height/2 -80)){
      dy = -dy;
    
  }
  
  
  }
  
  void update(){
    location.x += dx;
    location.y += dy;
  }

}
