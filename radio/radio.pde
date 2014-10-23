Wave wave1;

Wave wave2;

float yOffset = 50;

PFont Font1;
String s;

color orange = color(230, 126, 34);


void setup() {
  
  size(400, 400);
  //fill(#FF8574);
  background(#7AC5AC);
  Font1 = createFont("Tahoma-Bold", 32);
  s = "HELLO";

  
  PVector startP1  = new PVector(0, height/2-100);
  float endX1 = width;
  float angleVel1 = 0.5;
  float amplitude1 = yOffset;
  
  PVector startP2  = new PVector(0, height/2+100);
  float endX2 = width/2;
  float angleVel2 = 0.1;
  float amplitude2 = yOffset;
  
  
  

  wave1 =new Wave(startP1, endX1, angleVel1, amplitude1, true);
  wave2 =new Wave(startP2, endX2, angleVel2, amplitude2, false);
  frameRate(7);
}



void draw(){
  background(#7AC5AC);
 
  fill(#2c3e50);
  noStroke();
  rect(width/2-14, 0, 23, height);
  
 strokeCap(ROUND); 
 strokeWeight(9);
 
 

 stroke(0);
 strokeWeight(10);
 line(width/2, 45, width/2, 155);
 
 strokeWeight(2);
 
 line(width/2, height-155, width/2, height-45);
 
 

 
  wave1.display();
 strokeWeight(4);
 stroke(#4B6782);
 line(width/2-11, 0, width/2-11, height);

  wave2.display();
  
  writeText();
 
}


void writeText(){
  pushStyle();
  rectMode(CENTER);
  fill(#7AC5AC, 95);
  rect(width/2, height/2, 300, 50);
  textAlign(CENTER);
  textFont(Font1);
  fill(orange);
  text(s, width/2, height/2, 300, 50);
  popStyle();


//String[] fontList = PFont.list();
//println(fontList);
}



void mousePressed() {
  if (s == "HELLO") {
    s = "How are you?";
    orange =  color(192, 57, 43);
  } else{
    s= "HELLO";
    orange = color(230, 126, 34);
  }
}

