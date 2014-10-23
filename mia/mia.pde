/* --------------------------------------------------------------------------
 * SimpleOpenNI Draw Simple Figure
 
 lei chen 2014
 */

import SimpleOpenNI.*;

SimpleOpenNI  context;


float len;
color torsoColor;

void setup()
{
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
  
  torsoColor = color(149, 165, 166);
  
}

void draw()
{
  background(0);
  stroke(255);
  len = (PVector.dist(getJointPosition(SimpleOpenNI.SKEL_NECK),getJointPosition(SimpleOpenNI.SKEL_TORSO)))/3;
  // update the cam
  context.update();
  
  // draw depthImageMap
  //image(context.depthImage(),0,0);
  
  // draw the skeleton if it's available
  if(context.isTrackingSkeleton(1)) {
    drawSimpleFigure();
  }
}




void drawSimpleFigure() {


//LEFT TORSO

drawLine(getJointPosition(SimpleOpenNI.SKEL_NECK),getJointPosition(SimpleOpenNI.SKEL_LEFT_SHOULDER) );
drawLine(getJointPosition(SimpleOpenNI.SKEL_LEFT_SHOULDER),getJointPosition(SimpleOpenNI.SKEL_LEFT_ELBOW));
drawLine(getJointPosition(SimpleOpenNI.SKEL_LEFT_ELBOW),getJointPosition(SimpleOpenNI.SKEL_LEFT_HAND));


//RIGHT ROESO

drawLine(getJointPosition(SimpleOpenNI.SKEL_NECK),getJointPosition(SimpleOpenNI.SKEL_RIGHT_SHOULDER) );
drawLine(getJointPosition(SimpleOpenNI.SKEL_RIGHT_SHOULDER),getJointPosition(SimpleOpenNI.SKEL_RIGHT_ELBOW));
drawLine(getJointPosition(SimpleOpenNI.SKEL_RIGHT_ELBOW),getJointPosition(SimpleOpenNI.SKEL_RIGHT_HAND));


//LEFT LOWER BODY


//drawLine(getJointPosition(SimpleOpenNI.SKEL_TORSO),getJointPosition(SimpleOpenNI.SKEL_LEFT_HIP) );
//drawLine(getJointPosition(SimpleOpenNI.SKEL_LEFT_HIP),getJointPosition(SimpleOpenNI.SKEL_LEFT_KNEE));
//drawLine(getJointPosition(SimpleOpenNI.SKEL_LEFT_KNEE),getJointPosition(SimpleOpenNI.SKEL_LEFT_FOOT));
//
//
////RIGHT LOWER BODY
//
//
//drawLine(getJointPosition(SimpleOpenNI.SKEL_TORSO),getJointPosition(SimpleOpenNI.SKEL_RIGHT_HIP) );
//drawLine(getJointPosition(SimpleOpenNI.SKEL_RIGHT_HIP),getJointPosition(SimpleOpenNI.SKEL_RIGHT_KNEE));
//drawLine(getJointPosition(SimpleOpenNI.SKEL_RIGHT_KNEE),getJointPosition(SimpleOpenNI.SKEL_RIGHT_FOOT));

//BODY IN THE MIDDLE

drawLine(getJointPosition(SimpleOpenNI.SKEL_LEFT_SHOULDER),getJointPosition(SimpleOpenNI.SKEL_TORSO) );
drawLine(getJointPosition(SimpleOpenNI.SKEL_RIGHT_SHOULDER),getJointPosition(SimpleOpenNI.SKEL_TORSO));


//HEAD AND NECK
//
//drawLine(getJointPosition(SimpleOpenNI.SKEL_HEAD),getJointPosition(SimpleOpenNI.SKEL_NECK) );
//


//drawbody

drawBody(getJointPosition(SimpleOpenNI.SKEL_HEAD), getJointPosition(SimpleOpenNI.SKEL_NECK), getJointPosition(SimpleOpenNI.SKEL_LEFT_SHOULDER), getJointPosition(SimpleOpenNI.SKEL_TORSO), getJointPosition(SimpleOpenNI.SKEL_RIGHT_SHOULDER));
drawHip(getJointPosition(SimpleOpenNI.SKEL_TORSO), getJointPosition(SimpleOpenNI.SKEL_LEFT_HIP),getJointPosition(SimpleOpenNI.SKEL_RIGHT_HIP));


//DRAW LEFT LEG
drawLeg(getJointPosition(SimpleOpenNI.SKEL_TORSO), getJointPosition(SimpleOpenNI.SKEL_LEFT_HIP),getJointPosition(SimpleOpenNI.SKEL_LEFT_KNEE), getJointPosition(SimpleOpenNI.SKEL_LEFT_FOOT), true);


//DRAW RIGHT LEG
drawLeg(getJointPosition(SimpleOpenNI.SKEL_TORSO), getJointPosition(SimpleOpenNI.SKEL_RIGHT_HIP),getJointPosition(SimpleOpenNI.SKEL_RIGHT_KNEE), getJointPosition(SimpleOpenNI.SKEL_RIGHT_FOOT), false);


//DRAW LEFT ARM
drawArm(getJointPosition(SimpleOpenNI.SKEL_NECK), getJointPosition(SimpleOpenNI.SKEL_LEFT_SHOULDER),getJointPosition(SimpleOpenNI.SKEL_LEFT_ELBOW), getJointPosition(SimpleOpenNI.SKEL_LEFT_HAND), true);

//DRAW RIGHT ARM
drawArm(getJointPosition(SimpleOpenNI.SKEL_NECK), getJointPosition(SimpleOpenNI.SKEL_RIGHT_SHOULDER),getJointPosition(SimpleOpenNI.SKEL_RIGHT_ELBOW), getJointPosition(SimpleOpenNI.SKEL_RIGHT_HAND), false);



}



PVector getJointPosition(int joint) {
  PVector jointPositionRealWorld = new PVector();
  PVector jointPositionProjective = new PVector();
  context.getJointPositionSkeleton(1, joint, jointPositionRealWorld);
  context.convertRealWorldToProjective(jointPositionRealWorld, jointPositionProjective);
  
  return jointPositionProjective;
}



void drawBody(PVector head, PVector neck, PVector lShoulder, PVector torso, PVector rShoulder ){
  
  fill(torsoColor);
  noStroke();  
  PVector center = PVector.add(head, neck);
  center.div(2);
  beginShape();
  vertex(center.x, center.y);
  vertex(lShoulder.x, lShoulder.y);
  vertex(torso.x - len, torso.y);
  vertex(torso.x + len, torso.y);
  vertex(rShoulder.x, rShoulder.y);
  endShape(CLOSE);  
}



void drawHip(PVector torso, PVector lHip, PVector rHip){
  fill(torsoColor);
  noStroke();  
  
  beginShape();
  vertex(torso.x - len, torso.y);
  vertex(lHip.x, lHip.y);
  vertex(rHip.x, rHip.y);
  vertex(torso.x + len, torso.y);
  
  endShape(CLOSE);  
 

}


void drawLeg(PVector torso, PVector hip, PVector knee, PVector foot, Boolean left){
  fill(torsoColor);
  noStroke();  
  
  beginShape();
  vertex(torso.x, torso.y);
  vertex(hip.x, hip.y);
  vertex(knee.x, knee.y);
  vertex(foot.x, foot.y);
  if(left == true){  
  vertex(knee.x+len/2, knee.y);
  }
  else {
    vertex(knee.x-len/2, knee.y);
  }
  
  vertex(torso.x, torso.y);
  
  endShape(CLOSE);  
 

}

void drawArm(PVector neck, PVector shoulder, PVector elbow, PVector hand, Boolean left){
  fill(torsoColor);
  
  noStroke();  
  
  beginShape();
  PVector center = PVector.add(neck, shoulder);
  center.div(2);


   vertex(center.x, center.y);
  vertex(shoulder.x, shoulder.y);
  vertex(elbow.x, elbow.y);
  vertex(hand.x, hand.y);
  if(left == true){  
  vertex(elbow.x+len/3, elbow.y);
  }
  else {
    vertex(elbow.x-len/3, elbow.y);
  }

  
  endShape();  
 

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

void keyPressed()
{
  switch(key)
  {
  case ' ':
    context.setMirror(!context.mirror());
    break;
  }
}  

