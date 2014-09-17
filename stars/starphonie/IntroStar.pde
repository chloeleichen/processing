class IntroStar {
  int x;
  float y;
  float speed;
  int size;
 
  IntroStar(int tempx, float tempy, float tempspeed, int tempsize) {
    x = tempx;
    y = tempy;
    speed = tempspeed;
    size = tempsize;
    filter( BLUR, 6 );
  }
 
  void mass() {
    if (size < 2) {
      speed = 0.1;
    } 
    if (size < 4 && size > 2) {
      speed = 1.3;
    }
    if (size < 6 && size > 4) {
      speed = 1;
    }
  }
 
  void scroll() {
    y = y- speed;
    if (y < 0) {
      y = height;
      x = int(random(0, width));
      speed = (random(0.5, 2));
      size = int(random(1, 8));
    }
  }
 
  void display() {
    //ellipseMode(CENTER);
    noStroke();
    
    for(int i = 0; i < 50; i ++ ){
      
    float alpha = map(i, 0, 49, 10, 100);
      
     fill(random(noise(i)*250, 250), random(noise(i) *250, 250), random(noise(i)*250, 250), alpha);
      ellipse(x, y, size*10/(i+1), size*10/(i+1));
      
    }

    
    
  }
}
