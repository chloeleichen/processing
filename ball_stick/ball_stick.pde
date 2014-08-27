ball[] balls;
stick[] sticks;


int stickLen = 80;
int nBalls = 10;
int nSticks = nBalls -1;







void setup(){
  size(500, 500);
  background(255);
  
  
  
  float r = 20;
  balls = new ball[nBalls];
  sticks = new stick[nSticks];
  for( int i = 0; i < nBalls; i ++){

    balls[i] = new ball( new PVector(width/2 + stickLen *i, height/2), r, color(0));
    if (i > 0){
    sticks[i-1]= new stick(balls[i-1], balls[i]);
    }
  }
  
}

void draw(){
  background(255);
  for(int i = 0; i < nSticks; i ++){
  sticks[i].update();
  sticks[i].display();
  }
}
