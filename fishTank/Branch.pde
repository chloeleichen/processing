class Branch {
  float segments, startAngle, angle, theta, num;
  Branch(float _segments){
    segments = random( _segments);
    startAngle = random(-90, 90);
    angle = map(startAngle, -90, 90, -10, 10);
  }
   
  void branch(float len){
    len *= 0.75;
    float t = map(len, 1, 70, 1, 10);
    theta = angle + sin(len+num) * 10;
    strokeWeight(t);
    line(0, 0, 0, -len);
    //fill(fillColor);
    ellipse(0, 0, t/2, t/2);
    translate(0, -len);
    if(len > 5){
      pushMatrix();
      rotate(radians(-theta));
      branch(len);
      popMatrix();
    }else{
      for(int i = 0; i < 360; i+=30){
        float x = sin(radians(i)) * 10;
        float y = cos(radians(i)) * 10;
        line(0, 0, x, y);
      }
    }
    num += 0.003;
  }
}
 
