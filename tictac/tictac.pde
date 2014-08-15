class TicTac{

  float w;
  float h;
  float x;
  float y;
  
  
  void setup(){
    size(600, 600);
    background(255);
    drawTictac(10, 10, 10, 20);
}

  void drawTictac(float x, float y, float w, float h ){
    translate(x,y);
    rect(x, y,w, h);
    arc(x,y,w,h/2,0, PI); 
  }
  
}
