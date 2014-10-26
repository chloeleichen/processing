/* --------------------------------------------------------------------------
 * SimpleOpenNI Draw Simple Figure
 
 lei chen 2014
 */

import SimpleOpenNI.*;

SimpleOpenNI  context;

PVector hand;

float len;
color torsoColor;
color fumeColor;
color lightColor;

//draw cigi

Smoke[] fumes = new Smoke[500];
int fumesCount =500;
float noiseScale = 200, noiseStrength = 10, noiseZRange = 0.4;
float overlayAlpha = 80, fumesAlpha = 90, strokeWidth = 0.3;

float age = 100;
float r = 20;
float xOffset = 0.0;
float yOffset = 0.0;
boolean cigi = false;
boolean shade = false;
boolean randomLight = false;
boolean catHead = false;


//Draw lights 

//Draw Cat 

  Cat cat;

  //for mia's eyeball movement 
  float x;
  float y;
  float spdX;
  float spdY;

//DRAW MUSIC 

import ddf.minim.*;

Minim minim;
AudioPlayer again;
AudioPlayer meow;
AudioPlayer background;
AudioPlayer groove;





void setup()
{
  //SET UP COLOR 
  torsoColor = color(149, 165, 166);
  fumeColor= color(231, 76, 60);
  lightColor = color(52, 152, 219,90);
  
  cat = new Cat();
      
  x = 0;
  y = 10;
    
  spdX = random(-2, 2);
  spdY = random(-2,2);   

  


  context = new SimpleOpenNI(this);
   
  if(context.isInit() == false)
  {
     println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
     exit();
     return;  
  }
  
  // enable depthMap generation 
  context.enableDepth();
   
  // enable skeleton generation for all joints
  context.enableUser();

  stroke(0,0,255);
  strokeWeight(3);
  smooth();
  
  size(context.depthWidth(), context.depthHeight()*2); 
  
  
  //DRAW CIGI
  for(int i=0; i<fumes.length; i++) fumes[i] = new Smoke();


//SET UP MUSIC 

minim = new Minim(this);
  again = minim.loadFile("again.mp3");
  meow = minim.loadFile("meow.mp3");
  groove = minim.loadFile("groove.mp3");
  background = minim.loadFile("background.wav", 512);
  
  background.play();
   
}

void draw()
{
  
  watchFrameCount();
  
  if(shade == false){
    background(0);
  } else{
  
  fill(0, 12);
  rect(0, 0, width, height);
  drawLight();
  }
  
  
  
  stroke(255);
  len = (PVector.dist(getJointPosition(SimpleOpenNI.SKEL_NECK),getJointPosition(SimpleOpenNI.SKEL_TORSO)))/3;
  // update the cam
  context.update();
  hand = getJointPosition(SimpleOpenNI.SKEL_LEFT_HAND);
  
  // draw depthImageMap
  //image(context.depthImage(),0,0);
  
  // draw the skeleton if it's available
  if(context.isTrackingSkeleton(1)) {
    drawSimpleFigure();
    //again.play();
    //again.loop();
    
    if(catHead == true){
    drawCat();
    }
    
    
    if(cigi == true){
    drawCigi(getJointPosition(SimpleOpenNI.SKEL_LEFT_HAND));
    }

  }
  
}




void drawSimpleFigure() {





//HEAD AND NECK
//
//drawLine(getJointPosition(SimpleOpenNI.SKEL_HEAD),getJointPosition(SimpleOpenNI.SKEL_NECK) );
//


//drawbody

drawBody(getJointPosition(SimpleOpenNI.SKEL_NECK), getJointPosition(SimpleOpenNI.SKEL_LEFT_SHOULDER), getJointPosition(SimpleOpenNI.SKEL_TORSO), getJointPosition(SimpleOpenNI.SKEL_RIGHT_SHOULDER));
drawHip(getJointPosition(SimpleOpenNI.SKEL_TORSO), getJointPosition(SimpleOpenNI.SKEL_LEFT_HIP),getJointPosition(SimpleOpenNI.SKEL_RIGHT_HIP));


//DRAW LEFT LEG
drawLeg(getJointPosition(SimpleOpenNI.SKEL_TORSO), getJointPosition(SimpleOpenNI.SKEL_LEFT_HIP),getJointPosition(SimpleOpenNI.SKEL_LEFT_KNEE), getJointPosition(SimpleOpenNI.SKEL_LEFT_FOOT), true);


//DRAW RIGHT LEG
drawLeg(getJointPosition(SimpleOpenNI.SKEL_TORSO), getJointPosition(SimpleOpenNI.SKEL_RIGHT_HIP),getJointPosition(SimpleOpenNI.SKEL_RIGHT_KNEE), getJointPosition(SimpleOpenNI.SKEL_RIGHT_FOOT), false);


//DRAW LEFT ARM
drawArm(getJointPosition(SimpleOpenNI.SKEL_NECK), getJointPosition(SimpleOpenNI.SKEL_LEFT_SHOULDER),getJointPosition(SimpleOpenNI.SKEL_LEFT_ELBOW), getJointPosition(SimpleOpenNI.SKEL_LEFT_HAND), true);

//DRAW RIGHT ARM
drawArm(getJointPosition(SimpleOpenNI.SKEL_NECK), getJointPosition(SimpleOpenNI.SKEL_RIGHT_SHOULDER),getJointPosition(SimpleOpenNI.SKEL_RIGHT_ELBOW), getJointPosition(SimpleOpenNI.SKEL_RIGHT_HAND), false);


//DRAW HEAD
drawHead(getJointPosition(SimpleOpenNI.SKEL_NECK));





}



PVector getJointPosition(int joint) {
  PVector jointPositionRealWorld = new PVector();
  PVector jointPositionProjective = new PVector();
  context.getJointPositionSkeleton(1, joint, jointPositionRealWorld);
  context.convertRealWorldToProjective(jointPositionRealWorld, jointPositionProjective);
  
  return jointPositionProjective;
}



void drawBody( PVector neck, PVector lShoulder, PVector torso, PVector rShoulder ){
  
  fill(torsoColor);
  stroke(torsoColor); 
  strokeWeight(2); 
  
  
  beginShape();
  vertex(neck.x, neck.y-len);
  vertex(lShoulder.x, lShoulder.y);
  vertex(torso.x - len, torso.y);
  vertex(torso.x + len, torso.y);
  vertex(rShoulder.x, rShoulder.y);
  endShape(CLOSE);  
}



void drawHip(PVector torso, PVector lHip, PVector rHip){
  fill(torsoColor);
  stroke(torsoColor); 
  strokeWeight(2); 
  
  beginShape();
  vertex(torso.x - len, torso.y);
  vertex(lHip.x, lHip.y);
  vertex(rHip.x, rHip.y);
  vertex(torso.x + len, torso.y);
  
  endShape(CLOSE);  
 

}


void drawLeg(PVector torso, PVector hip, PVector knee, PVector foot, Boolean left){
  fill(torsoColor);
  stroke(torsoColor); 
  strokeWeight(2);
  
  beginShape();
  vertex(torso.x, torso.y);
  vertex(hip.x, hip.y);
  vertex(knee.x, knee.y);
  vertex(foot.x, foot.y);
  if(left == true){ 
   vertex(foot.x+len/6, foot.y); 
  vertex(knee.x+len/2, knee.y);
  }
  else {
    vertex(foot.x-len/6, foot.y); 
    vertex(knee.x-len/2, knee.y);
  }
  
  vertex(torso.x, torso.y);
  
  endShape(CLOSE);  
 

}

void drawArm(PVector neck, PVector shoulder, PVector elbow, PVector hand, Boolean left){
  fill(torsoColor);
  stroke(torsoColor); 
  strokeWeight(2);
  
  PVector center = PVector.add(neck, shoulder);
  center.div(2);

   
  
  beginShape();



  vertex(center.x, center.y);
  vertex(shoulder.x, shoulder.y);
  vertex(elbow.x, elbow.y);
  vertex(hand.x, hand.y);
  if(left == true){  
  vertex(hand.x+len/6, hand.y);  
  vertex(elbow.x+len/3, elbow.y);
  }
  else {
    vertex(hand.x-len/8, hand.y);
    vertex(elbow.x-len/3, elbow.y);
  }

  
  endShape();  
 

}


void drawHead( PVector neck){
  fill(torsoColor);
  stroke(torsoColor); 
  strokeWeight(2);
  ellipse(neck.x, neck.y-20, len*1.5, len*1.5);
}

PVector getP(PVector p1, PVector p2, float num){
  PVector p = PVector.add(p1, p1);
  p.div(num);
  
  return p;
  
}


void drawLine(PVector position1, PVector position2){
  line(position1.x, position1.y, position2.x, position2.y);
}

// -----------------------------------------------------------------
// SimpleOpenNI events

void onNewUser(SimpleOpenNI curContext, int userId)
{
  println("onNewUser - userId: " + userId);
  println("\tstart tracking skeleton");
  
  curContext.startTrackingSkeleton(userId);
}

void onLostUser(SimpleOpenNI curContext, int userId)
{
  println("onLostUser - userId: " + userId);
}

void onVisibleUser(SimpleOpenNI curContext, int userId)
{
  //println("onVisibleUser - userId: " + userId);
}

//void keyPressed()
//{
//  switch(key)
//  {
//  case 'c':
//    cigi = true;
//    break;
//    
//    case 'v':
//    cigi = false;
//    break;
//    
//     case 's':
//    shade = true;
//    break;
//    
//    case 'd':
//    shade = false;
//    break;
//    
//     case 'f':
//    randomLight = true;
//    break;
//    
//     case 'g':
//    randomLight = false;
//    break;
//    
//     case 'h':
//    catHead = true;
//    break;
//    
//     case 'j':
//    catHead = false;
//    break;
//    
//    
//  }
// 
//  
//  }

void watchFrameCount()
{
  switch(frameCount)
  {
  case 1550:
    cigi = true;
    break;
    
    case 5500:
    cigi = false;
    break;
    
     case 300:
    shade = true;
    break;
    
    case 1200:
    shade = false;
    
    break;
    
     case 600:
    randomLight = true;
    break;
    
     case 900:
    randomLight = false;
   
   lightColor = color(231, 76, 60);
   torsoColor = color(44, 62, 80);
    break;
    
    case 1250:
    groove.pause();    
    torsoColor = color(230, 126, 34);
    catHead = true;
    break;
    
     case 1500:
    catHead = false;
    break;
    
    
  }
 
  
  } 

  


void drawCigi(PVector hand){
  loopMusic(background);
  torsoColor= color(127, 140, 141);
  for(int i=0; i<fumesCount; i++) {

    stroke(fumeColor);
    fumes[i].update(hand);
}
    strokeWeight(5);
    stroke(255);
    line(hand.x-r, hand.y-r, hand.x, hand.y);



}

void drawLight(){
  background.pause();
  loopMusic(groove);
  if(randomLight == true){  
    
   lightColor = color(int(random(255)), int(random(255)), int(random(255)));
   torsoColor = color(int(random(255)), int(random(255)), int(random(255)));
   drawMusic(groove);
   //controlMusic(again);
   
  }
  
 fill(lightColor);
  noStroke();
  ellipse(getJointPosition(SimpleOpenNI.SKEL_LEFT_HAND).x, getJointPosition(SimpleOpenNI.SKEL_LEFT_HAND).y, len, len);
  ellipse(getJointPosition(SimpleOpenNI.SKEL_RIGHT_HAND).x, getJointPosition(SimpleOpenNI.SKEL_RIGHT_HAND).y, len, len);
  ellipse(getJointPosition(SimpleOpenNI.SKEL_RIGHT_FOOT).x, getJointPosition(SimpleOpenNI.SKEL_RIGHT_FOOT).y, len, len);
  ellipse(getJointPosition(SimpleOpenNI.SKEL_LEFT_FOOT).x, getJointPosition(SimpleOpenNI.SKEL_LEFT_FOOT).y, len, len);
}


void drawCat(){
  torsoColor = color(192, 57, 43);
  pushMatrix();
  translate(getJointPosition(SimpleOpenNI.SKEL_NECK).x, getJointPosition(SimpleOpenNI.SKEL_NECK).y-70);
//  meow.play();
  cat.display();
  loopMusic(meow);
  popMatrix();

}
  
  //DRAW MUSIC 
  
  void drawMusic(AudioPlayer player){
 
  stroke( 255);
  
  for(int i = 0; i < player.bufferSize() - 1; i++)
  {
    line(i, 50  + player.left.get(i)*50,  i+1, 50  +player.left.get(i+1)*50);
    line(i, 150 + player.right.get(i)*50, i+1, 150 + player.right.get(i+1)*50);
  }
  
  stroke( 255, 0, 0, 10 );
  float position = map( player.position(), 0, player.length(), 0, width );
  line( position, 0, position, height );
}
    



void controlMusic(AudioPlayer player){
  int position = int( map( getJointPosition(SimpleOpenNI.SKEL_TORSO).x, 0, width, 0, player.length() ) );
  player.cue( position );

}

void loopMusic(AudioPlayer player){
  
   if (!player.isPlaying()) {
    player.rewind();
    player.play();
  }

}

