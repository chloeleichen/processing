class disc extends widget{
  float r;
  PVector speed;
  
  disc(){
    this(new PVector(random(width), height(height)), 30, color(0));   
  }
  
  disc(PVector loc, float s, color c){
    super(loc, s, c);
    r = sz/2;
    speed = new PVector(random(1,3), random(1,3));
  }
  
  void display(){
    noStroke();
    fill(col);
    ellipse(location.x, location.y, sz, sz);
  }
  
  void setSpeed(PVector v){
    speed = v;
  }
  
  void move(){
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
}
