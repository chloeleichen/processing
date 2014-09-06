class Mia{
  float x1, y1, x2, y2, x3, y3, x4, y4;
  boolean nose;
  float w, h;
  int steps = 20;
  
  
  
  Mia(float _w, float _h, float _x1, float _y1, float _x2, float _y2, float _x3, float _y3 ){
    
    w = _w;
    h = _h;
    x1= _x1;
    y1=_y1;
    x2= _x2;
    y2=_y2;
    x3= _x3;
    y3=_y3;
    
  }
  
  void drawHead(){
    noFill();

    stroke(0);

    beginShape();
    bezier(x1, y1, x1, y1, x3, y3/1.5, x2, y2 );
    bezier(x1, y1, x1*0.5, y3, x2, y3, x2,y2 );

    endShape(CLOSE);
  }
  
  
  void drawFace(){
    //draw face

    fill(#F03200);
    getRight(10, 10);
    
    fill(#FFFFFF);
    //noStroke();
    getLeft(15, 10, true);

  }
  
  void drawEar(){
    
    fill(0);
    getLeft(12, 3, false);
    getRight(17, 17);
  }
  
  void drawEye(){
  fill(#FD9F00);
  e.setRoughness(1);
  e.setFillGap(0.5);
  e.setFillWeight(0.1);
  e.setBackgroundColour(color(#FD9F00));
  e.ellipse(0, 0, w, h);
  fill(#000000);
  rectMode(CENTER);
  e.rect(0, 0, 10, h);
  }
  
  
  void drawMouth(){
    noFill();
    stroke(0);
    strokeWeight(4);
    e.setRoughness(3);
    e.arc(0, 0, w, h,HALF_PI, PI);
    
  }
  
  
  
  
  //function to get points on curve
  
  PVector[] findPoint(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4, int steps){
  
  PVector [] m ={};
  
for (int i = 0; i < steps; i++) {
  float t = i / float(steps);
  float x = bezierPoint(x1, x2, x3, x4, t);
  float y = bezierPoint(y1, y2, y3, y4, t);
  m =(PVector[])append(m, new PVector(x, y));
  
//  ellipse(m[i].x, m[i].y, 5, 5);
  
  }
  return m;
}

//function to fill partial face with color 



void getLeft(int count1, int count2, boolean nose){
  


PVector temp1= findPoint(x1, y1, x1, y1, x3, y3/1.5, x2, y2, steps )[count1];
PVector temp2 = findPoint(x1, y1, x1*0.5, y3, x2, y3, x2,y2, steps )[count2];

beginShape();

curveVertex(temp2.x, temp2.y);
for(int i = count2;i > 0; i -- ){
  PVector result = findPoint(x1, y1, x1*0.5, y3, x2, y3, x2,y2, steps )[i];
  curveVertex(result.x, result.y);
}
curveVertex(x1, y1);
for(int i = 0;i < count1; i ++ ){
  PVector result = findPoint(x1, y1, x1, y1, x3, y3/1.5, x2, y2, steps )[i];
  curveVertex(result.x, result.y);
}

if(nose == true){
vertex(findPoint(x1, y1, x1, y1, x3, y3/1.5, x2, y2, steps )[count1-2].x, findPoint(x1, y1, x1, y1, x3, y3/1.5, x2, y2, steps )[count1-2].y);
quadraticVertex(temp2.x +30, temp1.y +100, temp2.x +50, temp1.y +115);
vertex(temp2.x, temp1.y +120);
//curveVertex(temp1.x, temp1.y);

curveVertex(temp2.x, temp2.y);

}

if(nose == false){
curveVertex(temp1.x, temp1.y);

}

endShape(CLOSE);

}


void getRight(int count1, int count2){


PVector temp1= findPoint(x1, y1, x1, y1, x3, y3/1.5, x2, y2, steps )[count1];
PVector temp2 = findPoint(x1, y1, x1*0.5, y3, x2, y3, x2,y2, steps )[count2];


beginShape();


curveVertex(temp1.x, temp1.y);


for(int i = count1;i < steps; i ++ ){
  PVector result = findPoint(x1, y1, x1, y1, x3, y3/1.5, x2, y2, steps )[i];
  curveVertex(result.x, result.y);
}
curveVertex(x2, y2);

for(int i = steps-1;i>= count2; i -- ){
  PVector result = findPoint(x1, y1, x1*0.5, y3, x2, y3, x2,y2, steps )[i];
  curveVertex(result.x, result.y);
}

curveVertex(temp2.x, temp2.y);

endShape(CLOSE);

}


  
    
}
  
