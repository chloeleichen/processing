class stick{
  ball b1, b2;
  
  float r;
  stick(ball b1, ball b2){
    this.b1 = b1;
    this.b2 = b2;
    r = b1.location.dist(b2.location);
    
  }
  
  
  
  void constrainLength(){
   float k = 0.1;
   PVector delta = PVector.sub(b2.location, b1.location);
   float deltaLength = delta.mag();
   float d =((deltaLength - r) /deltaLength);
   
   b1.location.x += delta.x * k * d/2;
   b1.location.y += delta.y * k * d/2;
   
   
   b2.location.x -= delta.x * k * d/2;
   b2.location.y -= delta.y * k * d/2;
   
  
  
  }
  
  void display(){
    b1.display();
    b2.display();
    stroke(0);
    strokeWeight(3);
    line(b1.location.x, b1.location.y, b2.location.x, b2.location.y);
  }
  
  void update(){
    b1.move();
    b2.move();
    constrainLength();
  }
  
}
  
