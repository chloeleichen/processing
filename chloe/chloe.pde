pathfinder[] paths;

int num;
static int count;



void setup() {
  size(800, 600);
  background(250);
  ellipseMode(CENTER);
  stroke(0);
  smooth();
  num = 1;
  count = 5;
  paths = new pathfinder[num];
  for(int i = 0; i < num; i++) paths[i] = new pathfinder();
}
 
void draw() {
  println(count);
//  println(paths.length);
  for (int i = 0; i < paths.length; i++) {
    PVector loc = paths[i].location;
    PVector lastLoc = paths[i].lastLocation;
    strokeWeight(paths[i].diameter);
    line(lastLoc.x, lastLoc.y, loc.x, loc.y);
    paths[i].update();
  }
}


