class Flock{
  float frequency = .001;
  float noiseInterval = PI;
  int numberOfFish;
  
  
  Flock(int num){
    numberOfFish = num;   
  }
  
  void drawFlock(){
    noStroke();
    
    for (int i = 0; i < numberOfFish; ++i) {
    float x = map(noise(i*noiseInterval + frameCount * frequency),0,1,0,width);
      float y = map(noise(i*noiseInterval+1 + frameCount * frequency),0,1,0,height);
     pushStyle();
     
     fill(32, 79, 250);
     
  
     ellipse(x,y,10,10); 
     popStyle();

    }
    
    
  }
}
  
  
