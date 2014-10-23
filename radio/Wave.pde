class Wave{
  
  float angle = 0;
  float amplitude;
  PVector startPoint;
  float endX;
  float angleVel;
  Boolean duo;

  
  
  Wave(PVector _startPoint, float _endX, float _angleVel, float _amplitude, boolean _duo  ){
    this.amplitude = _amplitude; 
    this.angleVel = _angleVel;
    this.startPoint = _startPoint;
    this.endX = _endX;
    this.duo = _duo;
    
  }
  
  
  
  
  void display(){
    
    float theta=0;
    
    beginShape();
    for (float x = int(startPoint.x); x <= int(endX); x +=1){
      
      amplitude = abs(50 * sin(theta));
      
      if (x > width/2){
      //theta -= 0.03;
      theta  = map(x, 0, (int(endX) - int(startPoint.x))/2, 0, TWO_PI);
      } else {
        theta = 1;
        
      }
      float y = amplitude * cos(angle);
      
      //noStroke();
      //fill(0);
      stroke(255);
      strokeWeight(2);
      noFill();
      //ellipse(x, startPoint.y +y, 2, 2 );
      vertex(x, y +startPoint.y);
      
      
      angle += angleVel;
      
  
    }
    endShape();
   
    addCircle();
    
     
    
  }
  
  void addCircle(){
   
   float y = yOffset*cos(angle);
   noStroke();
   fill(orange);
   
   if (duo == true){
    
  ellipse(int(endX/2), startPoint.y -y, 8, 8 );
  ellipse(int(endX/2), y + startPoint.y, 8, 8 );
    }  else{
      ellipse(int(endX), startPoint.y+y, 9, 9 );
      
    }
  
  }
  
  
  
}
