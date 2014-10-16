Mover[] movers = new Mover[20];
PVector turn;

Attractor a;

void setup() {
  size(400, 400);
  smooth();

  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover(1);
    
  }
  a = new Attractor();
  
  
  }

void draw() {
  background(255);
  

  a.display();
  a.update();
  
  

  
  for (int i = 0; i < movers.length; i++) {
    PVector force = a.attract(movers[i]);
    Boolean bounce = a.checkBounce(movers[i]);
    
    movers[i].applyForce(force);
    
    movers[i].doBounce(bounce);
    

    movers[i].update();
    
    movers[i].display(new PVector(a.location.x, a.location.y));
  }
  
}
  

