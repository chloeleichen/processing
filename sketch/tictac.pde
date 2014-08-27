class tictac{

  float w;
  float y;
  float x;
  float spdX = random(5);      // The speed at which the ball is moving
  float spdY = random(5);    // the rate of increase of speed
  float theta = 0;           // amount of lateral movement
  float rotSpd = PI/random(255);
  color tictacColor;
  float cornerRadiusOffset, dynamicRadius, collisionTheta;
    
     
   tictac(float x, float y, float w, color c){
   this.x = x;
   this.y = y;
   this.w = w;
   tictacColor = c;
   }
   

   
   void move(){
     pushMatrix();
     translate(x, y);
      rotate(theta);
      fill(tictacColor);
      rect(-w/2, -w/2, w, w);
      popMatrix();
  
      x +=spdX;
      y +=spdY;
      theta +=rotSpd;
  
      collide();
   }
   
   void collide(){  
     cornerRadiusOffset = w/2 /cos(PI/4) -w/2 ;
     dynamicRadius = abs(sin(collisionTheta) * cornerRadiusOffset);
     
      if( ((width -x) < w/2+dynamicRadius) || (x< w/2 + dynamicRadius))  {
        spdX *= -1;
        rotSpd *=-1;

        }
         if( ((height -y) < (w/2 +dynamicRadius)) || (y< w/2 +dynamicRadius))  {
        spdY *= -1;
        rotSpd *=-1;

        }
         collisionTheta += rotSpd*2;
  }  
}
