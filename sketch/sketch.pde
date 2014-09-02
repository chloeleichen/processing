Widget [] pieces;
int N = 10;

PVector cm, pm;
Widget target;


void setup(){
  background(255);
  size(500, 500);
  pieces = new Widget[N];
  
  for (int i = 0; i < N; i ++){
    color c = color(random(255), random(255), random(255));
    switch (int(random(2))){
      case 0:
      pieces[i] = new Disc(new PVector(random(width), random(height)), 30, c);
      break;
      default:
      pieces[i] = new Hexagon(new PVector(random(width), random(height)), 30, c);
    }
  }
}


void draw(){
  background(255);
    for (int i = 0; i < N; i ++){
  pieces[i].display();
  pieces[i].move();
    }
}
    
void mousePressed(){
  for(int i = 0; i < N; i ++){
    if (pieces[i].clicked()){
      target = pieces[i];
    }
  }
  pm = new PVector(mouseX, mouseY);
}

void mouseDragged(){
  cm = new PVector(mouseX, mouseY);
  PVector d = PVector.sub(pm, cm);
  
  d.normalize();
  
  target.setSpeed(d);
  target.col= color(0);
}


  
  



