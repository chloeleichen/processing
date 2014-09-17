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
}
