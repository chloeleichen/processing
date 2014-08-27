tictac t1, t2, t3;



void setup(){
  size(600, 600);
  background(255);
  translate(width/2, height/2);
  t1 = new tictac(50, 50, 10, color(0));
  t2 = new tictac(100, 100, 20,color(0));
  t3 = new tictac(150, 150, 30, color(0));

  
}


void draw(){
  background(255);
  //t1.display();
  t1.move();
  t2.move();
  t3.move();

}  
