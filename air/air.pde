  
  float frequency = .001;
  float noiseInterval = PI; // Using an irrational number like PI (as opposed to an integer) prevents obvious pulsing
                            // Due to noise's grid-like structure. To see what I mean, try using a value of 2,
                            // instead of PI.
  
  void setup()
  {
    size(500,500);
    smooth();
    background( 0 );
    noStroke();
    fill(#ffffff);
    colorMode(HSB, 1);
  }
  
  void draw()
  {
    colorMode(RGB, 256);
    fill( 0,0,0, 10 );
    rect(0,0,width,height);
    noStroke();
    background(0);
  
    colorMode(HSB, 1);
    for (int i = 0; i < 300; ++i) {
      float x = map(noise(i*noiseInterval + frameCount * frequency),0,1,0,width);
      float y = map(noise(i*noiseInterval+1 + frameCount * frequency),0,1,0,height);
      fill(i/1000.0,.5,1);
      ellipse(x,y,5,5);    
    }
  }
  
