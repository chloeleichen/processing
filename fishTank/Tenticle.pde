class Tenticle {
  PVector loc;
  int len;
 
  Tenticle(PVector loc, int len) {
    this.loc = loc;
    this.len = len;
  }
 
  void drawTenticle() {
    
    for (int q = 0; q < len; q+=2) {
      /* The angle is to make the movement */
      float angle = cos(radians(len-q+frameCount)) * q/2;
      /* Multiply by the to create length */
      float x2 = sin(radians(angle))*(q*4);
      float y2 = cos(radians(angle))*(q*4);
      //stroke(q*2, 50+q*2, q*2);
      noStroke();
      fill(q*2, 50+q*2, q*2, 100-q);
      ellipse(loc.x+x2, loc.y-y2, len-q, len-q);
    }
  }
}

