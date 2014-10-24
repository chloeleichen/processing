class Cat{
  float h;
  float w;
  float eyeH;
  float eyeW;
  color col;
  color tur;
  color eyeBallCol;
  float eyeBallWidth;
  float eyeHeightInt;
  float topPoint;
  

  
  Cat(){
    w = 65;
    h = 55;
     eyeHeightInt = h/1.4;
    col = color(211, 84, 0);
    tur = color(44, 62, 80);
    eyeBallCol = col;
    
    eyeH = eyeHeightInt;
    eyeW = w/1.3;    
    eyeBallWidth = 10;
    topPoint = -h;
    
    
  }
  
  void display(){    
    noStroke();
    fill(col);
    //ellipse(0, 0, w, h);
    
    
    //head 
    
    beginShape();
    vertex(w, 0);
    
    bezierVertex(w*1.1, h*0.8, w*0.5, h, 0, h);
    bezierVertex(-w*0.5, h, -w*1.1, h*0.8, -w, 0);
    bezierVertex(-w*0.95, -h*0.5, -w*0.7, -h, 0, topPoint);
    bezierVertex(w*0.7, -h, w*0.95, -h*0.5, w, 0);
    

    
    
    //bezierVertex(0, h*2, 0, h*2, w, 0);
    
    
    endShape(CLOSE);
    
    //draw eyelids 
    
    fill(tur);
    ellipse(-w/2, h/10, eyeW, eyeHeightInt/4);
    
    ellipse(w/2, h/10, eyeW, eyeHeightInt/4);
    
    
    //Draw eyes 
    
    fill(255);
    ellipse(-w/2, h/10, eyeW, eyeH);
    
    ellipse(w/2, h/10, eyeW, eyeH);
    
    //eyeball
    
    if(abs(eyeH) > eyeBallWidth/2){
      eyeBallCol = col;
    } else {
      eyeBallCol = color(255, 0);
    }
    
    fill(eyeBallCol);
    
    pushMatrix();
    translate(-w/2, h/10);  
    ellipse(x, y, eyeBallWidth, eyeBallWidth);
    
    popMatrix();
    
    pushMatrix();
    translate(w/2, h/10);
    ellipse(x,y, eyeBallWidth, eyeBallWidth);

    popMatrix();
    
    
    
    //now draw ears 
    fill(col);
    
    
    //left 
    beginShape();
//    
//    
    vertex(-w/5, -h*0.95);
    bezierVertex(-w/10, -h*0.95, -w/2, -h*1.3, -w/1.5, -h*1.2 );
    bezierVertex(-w/1.25, -h*1.1, -w*0.8, -h*0.5, -w*0.8, -h*0.5 );
    endShape();
    
    
    //right
    
    beginShape();
//    
//    
    vertex(w/5, -h*0.95);
    bezierVertex(w/10, -h*0.95, w/2, -h*1.3, w/1.5, -h*1.2 );
    bezierVertex(w/1.25, -h*1.1, w*0.8, -h*0.5, w*0.8, -h*0.5 );
    endShape();
    

    moveEyeBall();
    
    
    
  }
  
  
  void moveEyeBall(){  
  
    x = x+spdX;
    y = y+ spdY;
    
    float k;
    
    k = sq((abs(x)+eyeBallWidth/2) / (eyeW/2) ) + sq((abs(y) +eyeBallWidth/2)/(eyeH/2));
    
    if(k > 1){
      spdX = spdX*(-1);
      spdY = spdY*(-1);    
    }    
  }
  
  
  void blink(){
        //blink 
   while (eyeH > -100){
      if ((eyeH >= eyeHeightInt)){
        eyeH -= noise(eyeH* random(1000));
      } if (eyeH <= -eyeHeightInt) {
        eyeH = eyeHeightInt;
      } 
      
      
      else{
        eyeH --;
      }
      
   }
    
  }
  
  
  
}
