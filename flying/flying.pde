Wing wing;



void setup(){
  size(600, 600);
  stroke(200);
  wing = new Wing(90);
}

void draw(){
  background(0);
  translate(width/2, height/2);
  wing.display();
}
