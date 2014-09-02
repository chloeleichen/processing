void setup(){
  size(800, 800);
  background(255);
  smooth();
  noFill();
  translate(width/2, height/2);
  drawCircle(0, 0, 300);
  
}

void 

void drawCircle(int x, int y, int s){
  if(s>2){
    ellipse(x, y, s, s);
    stroke(color(random(250), random(250), random(250)));
    drawCircle(x- s/2, y, s/2);
    drawCircle(x+ s/2, y, s/2);
    drawCircle(x, y +s/2, s/2);
    drawCircle(x, y-s/2, s/2);
  }
  
}
