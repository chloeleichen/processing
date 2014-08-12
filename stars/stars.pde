void star(int pointCount, float outerRadius, float innerRadius){
  translate(width/2, height/2);
  float theta = 0;
  int vertCount = pointCount *2;
  float tempRadius = 0;
  float x = 0, y = 0;
  float thetaRot = TWO_PI / vertCount;
  
  beginShape();
    for (int i = 0; i < pointCount; i ++) {
      for( int j = 0; j< 2; j ++){
        if (j %2 == 0){
          tempRadius = innerRadius;
          
        } else {
          tempRadius = outerRadius;
        }
        x = cos(theta) * tempRadius;
        y = sin(theta) * tempRadius;
        vertex(x, y);
        
        theta += thetaRot;
      }
    }
      
      endShape(CLOSE);
  }
  
  void setup(){
    size(600, 600);
    star(10, 300, 100);
  
}
    
  
  
