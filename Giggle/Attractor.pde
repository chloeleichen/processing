// Attraction

class Attractor {
  float mass;    // Mass, tied to size
  float G;       // Gravitational Constant
  PVector location;   // Location
  float frequency = .001;
  float noiseInterval = PI; // Using an irrational number like PI (as opposed to an integer) prevents obvious pulsing


  Attractor() {
    location = new PVector(width/2,height/2);
    mass = 50;
    G = 1;


  }

  PVector attract(Mover m) {
    PVector force = PVector.sub(location,m.loc);   // Calculate direction of force
    float d = force.mag();                              // Distance between objects
    d = constrain(d,5.0,25.0);                        // Limiting the distance to eliminate "extreme" results for very close or very far objects
    force.normalize();                                  // Normalize vector (distance doesn't matter here, we just want this vector for direction)
    float strength = (G * mass * m.mass) / (d * d);      // Calculate gravitional force magnitude
    force.mult(strength);    // Get force vector --> magnitude * direction
    return force;
  }

  // Method to display
  void display() {
    ellipseMode(CENTER);
    noStroke();
    fill(200);
    pushMatrix();
    translate(location.x, location.y);
    ellipse(0,0,mass*2,mass*2);
    popMatrix();
    
  }
  
  
  boolean checkBounce(Mover m){
    boolean bounce = false;
    PVector dist = PVector.sub(location, m.loc);
    float d = dist.mag();
    if(d <= mass +5){
      bounce = true;
       
    }
    return bounce;
    
  }
  
  
  void update(){
     location.x = map(noise(noiseInterval + frameCount * frequency),0,1,0,width);
     location.y = map(noise(noiseInterval+1 + frameCount * frequency),0,1,0,height); 
  }
}
