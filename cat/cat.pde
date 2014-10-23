
  
Mia cat;

import org.gicentre.handy.*;
HandyRenderer h;
HandyRenderer e;




void setup(){
  size(600, 600);
  
  strokeWeight(3);
  float eyeWidth = 50;
  float eyeHeight = 30;
  
float x1, y1, x2, y2, x3, y3, x4, y4;
    x1 = width/3;
    y1 = 20;
    x2 = 480;
    y2 = 20;
    x3 = 300;
    y3 = 340;
    
   
  
  
  cat = new Mia(eyeWidth, eyeHeight, x1, y1, x2, y2, x3, y3);
  
  h = new HandyRenderer(this);
  e = new HandyRenderer(this);
  
  //background
  h.setRoughness(1);
  h.setFillGap(0.5);
  h.setFillWeight(0.1);
  h.setBackgroundColour(color(#EAE482));
  h.rect(0, 0, width, height); 
  
  fill(#E0442C);
  h.setRoughness(2);
  h.setFillWeight(1);
  h.setFillGap(2);
  h.setIsAlternating(true);
  h.triangle(0, height/3, width*1.7, height, 0, height);
  h.triangle(x3, height, width, height, width, height*0.8);
  
  
 //draw head
 cat.drawNeck();
 cat.drawHead();
 
 cat.drawFace();
 cat.drawEar();
 
 
//add left eye
  pushMatrix();
  translate(x3-eyeWidth*0.5,((y3-y1)*0.5 +y1-eyeHeight*0.5)) ;
  cat.drawEye();
  popMatrix();
  
//add right eye  
  pushMatrix();
  translate(x3+eyeWidth*1.5,((y3-y1)*0.5 +y1-eyeHeight*0.5)) ;
  cat.drawEye();
  popMatrix();

  //draw mouse 
  pushMatrix();
  translate(x3, (y3*0.65));
  cat.drawMouth();
  popMatrix(); 
} 


void draw(){

 
}






