Mover[] movers = new Mover[30];
Attractor a;

float frequency = .001;
  float noiseInterval = PI; // Using an irrational number like PI (as opposed to an integer) prevents obvious pulsing
                            // Due to noise's grid-like structure. To see what I mean, try using a value of 2,
                            // instead of PI.
                            
void setup() {
  size(400,400);
  smooth();
    for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover(new PVector(random(50, 100),random(50, 100)), random(1,3));
  }
  
  
  a = new Attractor();
  
  
}

void draw() {
  background(#433707);
  a.display();
  a.update();
  
  
  //shakeFactor = map(noise(noiseInterval + frameCount * frequency),0,1,0,400);

for (int i = 0; i < movers.length; i++) {
  PVector force = a.attract(movers[i]);
  
  Boolean bounce = a.checkBounce(movers[i]);
  movers[i].applyForce(force);
  


  if (bounce == true){


    movers[i].doBounce(bounce);
    
  }
  
  
  movers[i].update();
 
  
  movers[i].display(a.location);
}

}

void mousePressed(){
  for (int i = 0; i < movers.length; i++) {
    movers[i].applyForce(new PVector(movers[i].location.x/30, movers[i].location.y/30));
    movers[i].update();
    
  }
  
}





