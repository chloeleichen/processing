/**************************************/
// Star
// Created by Lionel Mischler 9/9/2014
/**************************************/

public class Star{
  private float x;
  private float y;
  private float earth_distance;
  private float size;
  private String starColor;
  private String note;
  private String reverb;
  private String starname;
  private String starsign;
  private boolean foundstarsignstar;
  
  
//Chloe: some color setup

  float r = random(150);
  float g = random(150);
  float b = random(150);
  


  public Star(float pX, float pY, float pEarth_distance, float pSize, String pStarColor, String pNote, String pReverb, String pStarname, String pStarsign) {
    x = pX; 
    y = pY;
    earth_distance = pEarth_distance;
    size = pSize;
    starColor = pStarColor; 
    note = pNote;
    reverb = pReverb;
    starname = pStarname;
    starsign = pStarsign;
  }
  
  public Star(String pStarname) {
    starname = pStarname;
  }
  
  public float getX() {
    return x;
  }
  
  public float getY() {
    return y;
  }
  
  public float getSize() {
    return size;
  }
  
  public String getStarSign() {
    return starsign;
  }
  
  public String getStarName() {
    return starname;
  }
  
  void display(){
        noStroke();
    
    for(int i = 0; i < 50; i ++ ){
    
    float alpha = map(i, 0, 49, 10, 100);
    float angle = map(i, 0, 49, 0, 2*PI);
   
    
    
     fill(r+random(100), g+random(100), b+random(100), alpha);
      ellipse(x, y, size*12/(i+1), size*12/(i+1));
      
    }
  }
  
  
}
