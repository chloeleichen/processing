/**************************************/
// StarSigns
// Created by Lionel Mischler 9/9/2014
/**************************************/

public class StarSigns{
  private String starSignName;
  private String starSignImage;
  Star[][] starSignLines;

  public StarSigns(String pStarSignName, String pStarSignImage, Star[][] pStarSignLines) {
    starSignLines = pStarSignLines;
    starSignName = pStarSignName;
    starSignImage = pStarSignImage;
    println(pStarSignImage);
    if (starSignLines==null) {
      
    }
    else {
       
    }
  }
  
  public Star[][] getStarSignLines() {
    return starSignLines;
  }
  
  public String getStarSignImage() {
    return starSignImage;
  }
  
  public String getStarSignName() {
     //println(starSignName);
     return starSignName; 
  }
}

