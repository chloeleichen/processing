/* jason stephens
 Computational Cameras
 FaceOSC -> Controls Generative System
 (aka: Control Noise With Mouth)
 
 Facetracking through:
 Kyle McDonald's FaceOSC https://github.com/kylemcdonald/ofxFaceTracker
 
 Adapted from from Greg Borenstein's 2011 example
 https://gist.github.com/1603230
 
 
 Objective:
 Demonstrate FaceOSC with a series of generative sketches with face controlled parameters.
 
 Method:
 Create a baseline series of animations increasing in complexity between keyPress 1-6.
 Add perlin noise to each 
 Add faceControl to replace perlin noise
 
 TODO:
 DONE____print directions
 DONE____add 6 spiral
 ____add toggle for faceControl to function
 ____add faceControl fucntionality
 
 ____add toggle for perlin noise for each
 DONE____add toggle for lines
 DONE____push '1' creates sin movement on X axis
 DONE____push '2' creates cos movement on Y axis (osicllate up/down)
 DONE____push '3' creates circle from circulating dots
 ____add center location based on center of face
 ____blink changes rotation direction
 ____mouth width changes X amplitude
 ____mouth heigh changes Y amplitude
 ____eyes change center circle 
 
 
 NOTES:
 locationX = amplitude * cos (angle); // where cos(angle) = 0-1
 locationY = amplitude * sin (angle); // where sin(angle) = 0-1
 */

//faceControl variables
import oscP5.*;
OscP5 oscP5;

PVector posePosition = new PVector();
boolean found;
float eyeLeftHeight;
float eyeRightHeight;
float mouthHeight;
float mouthWidth;
float nostrilHeight;
float leftEyebrowHeight;
float rightEyebrowHeight;
float poseOrientationX;
float poseOrientationY;
float poseOrientationZ;
float poseScale;

float mouthArea;  // equals (mouthHeight * mouthWidth);
PImage myImg;

//drawingCircles
PVector amplitude;
PVector location;
PVector angularVelocity; 
PVector centerCircle;

float centerX;
float centerY;
float radius = 100;
float moveX;

float angle = 0;
float aVelocity = .05;
float amplitudeX = 200;
float amplitudeY = 200;
float theta = 0;
float spiralTheta = 0;
float spiralSize =1;
float spiralAcceleration = .01;
float pX=0;
float pY=0;

int lastKey = 0;
boolean showLines = false;
boolean mouseVelocity = false;
boolean mouseYspiralAcceleration = false;
boolean faceControl = false;

void setup () {
  size (750, 750);
  smooth (); 
  background(255);
  strokeWeight (5);
  centerX = width/2;
  centerY = height/2;

  oscP5 = new OscP5(this, 8338);
  oscP5.plug(this, "mouthWidthReceived", "/gesture/mouth/width");
  oscP5.plug(this, "mouthHeightReceived", "/gesture/mouth/height");
  oscP5.plug(this, "eyebrowLeftReceived", "/gesture/eyebrow/left");
  oscP5.plug(this, "eyebrowRightReceived", "/gesture/eyebrow/right");
  oscP5.plug(this, "eyeLeftReceived", "/gesture/eye/left");
  oscP5.plug(this, "eyeRightReceived", "/gesture/eye/right");
  oscP5.plug(this, "jawReceived", "/gesture/jaw");
  oscP5.plug(this, "nostrilsReceived", "/gesture/nostrils");
  oscP5.plug(this, "found", "/found");
  oscP5.plug(this, "poseOrientation", "/pose/orientation");
  oscP5.plug(this, "posePosition", "/pose/position");
  oscP5.plug(this, "poseScale", "/pose/scale");
  //myImg = loadImage("sup.png");
  imageMode(CENTER) ;

  printDirections();
}

void draw () {

  semiTransparent();

  //returns the velocity (either mouseControlled or hardCoded depending on 'v' keyPress
  float varVelocity = calcVelocity(aVelocity); //calculate the variable velocity. take angular velocity as argument

  // Create the PVectors for motion and prepare them for following calcultion function
  PVector angularVelocity = new PVector (angle, varVelocity); //stores initial angle and the deltaAngle
  PVector amplitude = new PVector (amplitudeX, amplitudeY); //stores the maxX maxY (aka radius)

  //set location and centerCircle PVectors w/o faceControl

  //this PVector holds the return value of the calculation function, which sends radius and velocity info to calc
  PVector location = calculateCircle(angularVelocity, amplitude);
  //figure out where the translation of the entire circle
  PVector centerCircle = calculateCenter(centerX, centerY);

  if (lastKey == 1) {
    drawOscillatingX(location, centerCircle);
  }
  if (lastKey == 2) {
    drawOscillatingY(location, centerCircle);
  }
  if (lastKey == 3) {
    drawCircle(location, centerCircle); //send the location PVector (containing both X and Y coordinates
  }
  if (lastKey == 4) {
    drawCircleDual(location, centerCircle); // this time add noise
  }
  if (lastKey == 5) {
    drawCircleQuad(location, centerCircle); // this time add noise
  }
  if (lastKey == 6) {
    drawSpiral(location, centerCircle); // this time add noise
  }
  if (lastKey == 7) {
    drawFaceControlSpirals(location, centerCircle);
  }
}
//Start the Machine
void printDirections() {
  println("Controls:  animation = 1-6  :  showLines = SpaceBar    :   mouseX Velocity = 'v'  :  mouseY Sprial = 's'");
  println("faceControl = 'f'");
}

void semiTransparent() {
  rectMode(CORNER);
  noStroke();
  fill(255, 10);
  rect(0, 0, width, height);
  stroke(0);
  noFill();
}

//calculate Variable velocity.  take Angular Velocity as an argument
float calcVelocity(float aVelocity) { 
  float velocity = aVelocity;
  //if boolean for mouse controlled velocity is false, then return the standard velocity
  if (mouseVelocity == false) {
  }
  //if boolean for mouse control is true, then set velocity
  if (mouseVelocity == true) {  
    velocity = map(mouseX, 0, width, -1, 1);
  }
  return velocity;
}

// This function takes 4 argumments and returns 1 PVector
PVector calculateCircle (PVector angularVelocity, PVector amplitude) {
  float x = amplitude.x * cos (theta); 
  float y = amplitude.y * sin (theta);
  location = new PVector (x, y);
  theta = theta + angularVelocity.y; // 
  return location;
}

// this function returns calculates where the circle is (translates) and returns as PVector
PVector calculateCenter(float centerX, float centerY) {
  PVector centerCircle = new PVector (centerX, centerY);
  return centerCircle;
}

// Do '1':  draw the osicallating X
void drawOscillatingX (PVector location, PVector centerCircle) { 
  if (faceControl == false) {
    translate (centerCircle.x, centerCircle.y);
    ellipse (0, 0, amplitudeX *.5, amplitudeY*.5); 
    point (0, 0);
    point (location.x, 0);
  }
  //_____________________________________________________________
  if (faceControl == true) {
    //map the small ofFaceTracker screen (640x480) to the width and size of this screen
    float mouthScalar = map(mouthWidth, 10, 18, 0, 1.5); // make a scalar for location.x as a function of mouth
    location.mult(mouthScalar);

    float newPosX = map (posePosition.x, 0, 640, 0, width);
    float newPosY = map(posePosition.y, 0, 480, 0, height);  
    translate(width - newPosX, newPosY-100);
    scale(poseScale*.3);

    //left EYE

    float leftEyeMove = map(location.x, - amplitudeX, amplitudeX, -25, 33);
    pushMatrix();
    translate (leftEyeMove, 0);
    //Left iris
    fill(0, 0, 255);
    noStroke();
    ellipse(-100, 0, 50, 50);

    //LeftPupil
    fill(0);
    stroke(1);
    ellipse(-100, 0, 20, 20);
    popMatrix();

    float rightEyeMove = map(location.x, - amplitudeX, amplitudeX, -33, 25);
    pushMatrix();   
    translate(rightEyeMove, 0);
    //right EYE
    //Right Iris
    fill(0, 0, 255);
    noStroke();
    ellipse(100, 0, 50, 50);
    //Right Pupil
    fill(0);
    stroke(1); 
    ellipse(100, 0, 20, 20);
    popMatrix();

    //turn off fill
    noFill();


    //get eye informatio and set scalar
    float blinkAmountRight = map (eyeRightHeight, 2.5, 3.8, 0, 125);
    float blinkAmountLeft = map (eyeLeftHeight, 2.5, 3.8, 0, 125);

    // right eye size, blink and movement
    ellipse (100, 0, amplitudeX *.6, blinkAmountRight); //scalar added to eyeHeight
    if (eyeRightHeight < 3.1) {
      fill(0);
      ellipse (100, 0, amplitudeX *.6, blinkAmountRight*1.6); //scalar added to eyeHeight
      noFill();
    }

    //left eye size, blink, and movement
    ellipse (-100, 0, amplitudeX *.6, blinkAmountLeft); 
    if (eyeLeftHeight < 3.1) {
      fill(0);
      ellipse (-100, 0, amplitudeX *.6, blinkAmountLeft*1.6); //scalar added to eyeHeight
      noFill();
    }

    // pesky point!
    point (location.x, 0);
  }
}

//Do '2':  draw the oscillating Y
void drawOscillatingY (PVector location, PVector centerCircle) {
  if (faceControl == false) {
    translate (centerCircle.x, centerCircle.y);  //use the PVector to determine the translate
    ellipse (0, 0, amplitudeX *.5, amplitudeY*.5); 
    //point (location.x*.1, location.y*.1); 
    point (0, 0);
    point (0, location.y);
  }

  //_____________________________________________________________
  if (faceControl == true) {
    //create mouthScalar
    float mouthScalar = map(mouthHeight, 1, 10, 0, 1.5); // make a scalar for location.x as a function of mouth
    location.mult(mouthScalar);

    //map the small ofFaceTracker screen (640x480) to the width and size of this screen
    float newPosX = map (posePosition.x, 0, 640, 0, width);
    float newPosY = map(posePosition.y, 0, 480, 0, height);  
    translate(width - newPosX, newPosY-100);
    scale(poseScale*.3);

    //left EYE

    float leftEyeMove = map(location.y, - amplitudeY, amplitudeY, -10, 10);
    pushMatrix();
    translate (30, leftEyeMove);
    //Left iris
    fill(0, 0, 255);
    noStroke();
    ellipse(-100, 0, 50, 50);

    //LeftPupil
    fill(0);
    stroke(1);
    ellipse(-100, 0, 20, 20);
    popMatrix();

    float rightEyeMove = map(location.y, - amplitudeY, amplitudeY, -10, 10);
    pushMatrix();   
    translate(-30, rightEyeMove);
    //right EYE
    //Right Iris
    fill(0, 0, 255);
    noStroke();
    ellipse(100, 0, 50, 50);
    //Right Pupil
    fill(0);
    stroke(1); 
    ellipse(100, 0, 20, 20);
    popMatrix();

    //turn off fill
    noFill();


    //get eye informatio and set scalar
    float blinkAmountRight = map (eyeRightHeight, 2.5, 3.8, 0, 125);
    float blinkAmountLeft = map (eyeLeftHeight, 2.5, 3.8, 0, 125);

    // right eye size, blink and movement
    ellipse (100, 0, amplitudeX *.6, blinkAmountRight); //scalar added to eyeHeight
    if (eyeRightHeight < 3.1) {
      fill(0);
      ellipse (100, 0, amplitudeX *.6, blinkAmountRight*1.6); //scalar added to eyeHeight
      noFill();
    }

    //left eye size, blink, and movement
    ellipse (-100, 0, amplitudeX *.6, blinkAmountLeft); 
    if (eyeLeftHeight < 3.1) {
      fill(0);
      ellipse (-100, 0, amplitudeX *.6, blinkAmountLeft*1.6); //scalar added to eyeHeight
      noFill();
    }

    // pesky point!
    point (0, location.y);
  }
}

//Do '3': draw the circle from points
void drawCircle (PVector location, PVector centerCircle) {
  if (faceControl == false) {
    translate (centerCircle.x, centerCircle.y);
    ellipse (0, 0, amplitudeX *.5, amplitudeY*.5); 
    point (0, 0);
    point (location.x, location.y);
    if (showLines) {
      line(0, 0, location.x, location.y);
    }
  }
  //_____________________________________________________________
  if (faceControl == true) {
    //create the scalar!
    float mouthScalar = map(mouthHeight, 1, 10, 0, 1.5); // make a scalar for location.x as a function of mouth
    location.mult(mouthScalar);

    //map the small ofFaceTracker screen (640x480) to the width and size of this screen
    float newPosX = map (posePosition.x, 0, 640, 0, width);
    float newPosY = map(posePosition.y, 0, 480, 0, height);  
    translate(width - newPosX, newPosY-100);
    scale(poseScale*.3);

    //left EYE

    float leftEyeMoveUD = map(location.y, - amplitudeY, amplitudeY, -10, 10);
    float leftEyeMoveLR = map(location.x, - amplitudeX, amplitudeX, -10, 10);
    pushMatrix();
    translate (leftEyeMoveLR, leftEyeMoveUD);
    //Left iris
    fill(0, 0, 255);
    noStroke();
    ellipse(-100, 0, 50, 50);

    //LeftPupil
    fill(0);
    stroke(1);
    ellipse(-100, 0, 20, 20);
    popMatrix();

    float rightEyeMoveUD = map(location.y, - amplitudeY, amplitudeY, -10, 10);
    float rightEyeMoveLR = map(location.x, - amplitudeX, amplitudeX, -10, 10);
    pushMatrix();   
    translate(rightEyeMoveLR, rightEyeMoveUD);
    //right EYE
    //Right Iris
    fill(0, 0, 255);
    noStroke();
    ellipse(100, 0, 50, 50);
    //Right Pupil
    fill(0);
    stroke(1); 
    ellipse(100, 0, 20, 20);
    popMatrix();

    //turn off fill
    noFill();


    //get eye informatio and set scalar
    float blinkAmountRight = map (eyeRightHeight, 2.5, 3.8, 0, 125);
    float blinkAmountLeft = map (eyeLeftHeight, 2.5, 3.8, 0, 125);

    // right eye size, blink and movement
    ellipse (100, 0, amplitudeX *.6, blinkAmountRight); //scalar added to eyeHeight
    if (eyeRightHeight < 3.1) {
      fill(0);
      ellipse (100, 0, amplitudeX *.6, blinkAmountRight*1.6); //scalar added to eyeHeight
      noFill();
    }

    //left eye size, blink, and movement
    ellipse (-100, 0, amplitudeX *.6, blinkAmountLeft); 
    if (eyeLeftHeight < 3.1) {
      fill(0);
      ellipse (-100, 0, amplitudeX *.6, blinkAmountLeft*1.6); //scalar added to eyeHeight
      noFill();
    }

    // pesky point!
    point (location.x, location.y);

    if (showLines) {
      point (location.x, location.y);
      line(pX, pY, location.x, location.y);
    }
    float pX = location.x;
    float pY = location.y;
  }
}


//Do '4': draw the circle from points
void drawCircleDual (PVector location, PVector centerCircle) {
  translate (centerCircle.x, centerCircle.y);
  ellipse (0, 0, amplitudeX *.5, amplitudeY*.5); 
  point (0, 0);
  //line(0, 0, width-location.x, height-location.y);
  float backWardsY = location.y*-1;
  point (location.x, backWardsY);
  point (location.x, location.y);
  if (showLines) {
    line(0, 0, location.x, location.y);
    line (0, 0, location.x, backWardsY);
  }
}

//Do '5': draw the circle from points
void drawCircleQuad (PVector location, PVector centerCircle) {
  if (faceControl == false) {
    translate (centerCircle.x, centerCircle.y);
    ellipse (0, 0, amplitudeX *.5, amplitudeY*.5); 
    point (0, 0);
    //line(0, 0, width-location.x, height-location.y);
    float backWardsY = location.y*-1;
    float backWardsX = location.x*-1;
    point (location.x, backWardsY);
    point (location.x, location.y);
    point (backWardsX, backWardsY);
    point (backWardsX, location.y);
    if (showLines) {
      line(0, 0, location.x, location.y);
      line (0, 0, location.x, backWardsY);
      line (0, 0, backWardsX, backWardsY);
      line (0, 0, backWardsX, location.y);
    }
  }
   //_____________________________________________________________
  if (faceControl == true) {
    //create the scalar!
    float mouthScalar = map(mouthHeight, 1, 10, 0, 1.5); // make a scalar for location.x as a function of mouth
    location.mult(mouthScalar);

    //map the small ofFaceTracker screen (640x480) to the width and size of this screen
    float newPosX = map (posePosition.x, 0, 640, 0, width);
    float newPosY = map(posePosition.y, 0, 480, 0, height);  
    translate(width - newPosX, newPosY-100);
    scale(poseScale*.3);

    //left EYE

    float leftEyeMoveUD = map(location.y, - amplitudeY, amplitudeY, -10, 10);
    float leftEyeMoveLR = map(location.x, - amplitudeX, amplitudeX, -10, 10);
    pushMatrix();
    translate (leftEyeMoveLR, leftEyeMoveUD);
    //Left iris
    fill(0, 0, 255);
    noStroke();
    ellipse(-100, 0, 50, 50);

    //LeftPupil
    fill(0);
    stroke(1);
    ellipse(-100, 0, 20, 20);
    popMatrix();

    float rightEyeMoveUD = map(location.y, - amplitudeY, amplitudeY, -10, 10);
    float rightEyeMoveLR = map(location.x, - amplitudeX, amplitudeX, -10, 10);
    pushMatrix();   
    translate(rightEyeMoveLR, rightEyeMoveUD);
    //right EYE
    //Right Iris
    fill(0, 0, 255);
    noStroke();
    ellipse(100, 0, 50, 50);
    //Right Pupil
    fill(0);
    stroke(1); 
    ellipse(100, 0, 20, 20);
    popMatrix();

    //turn off fill
    noFill();


    //get eye informatio and set scalar
    float blinkAmountRight = map (eyeRightHeight, 2.5, 3.8, 0, 125);
    float blinkAmountLeft = map (eyeLeftHeight, 2.5, 3.8, 0, 125);

    // right eye size, blink and movement
    ellipse (100, 0, amplitudeX *.6, blinkAmountRight); //scalar added to eyeHeight
    if (eyeRightHeight < 2.5) {
      fill(0);
      ellipse (100, 0, amplitudeX *.6, blinkAmountRight*1.6); //scalar added to eyeHeight
      noFill();
    }

    //left eye size, blink, and movement
    ellipse (-100, 0, amplitudeX *.6, blinkAmountLeft); 
    if (eyeLeftHeight < 2.5) {
      fill(0);
      ellipse (-100, 0, amplitudeX *.6, blinkAmountLeft*1.6); //scalar added to eyeHeight
      noFill();
    }

     //line(0, 0, width-location.x, height-location.y);
    float backWardsY = location.y*-1;
    float backWardsX = location.x*-1;
    point (location.x, backWardsY);
    point (location.x, location.y);
    point (backWardsX, backWardsY);
    point (backWardsX, location.y);
    if (showLines) {
      line(0, 0, location.x, location.y);
      line (0, 0, location.x, backWardsY);
      line (0, 0, backWardsX, backWardsY);
      line (0, 0, backWardsX, location.y);
  }
}
}
//Do '6': draw the circle from points
void drawSpiral (PVector location, PVector centerCircle) {
  translate (centerCircle.x, centerCircle.y);
  ellipse (0, 0, amplitudeX *.5, amplitudeY*.5); 
  point (0, 0);
  //create the spiraling for loop.  use absolute value to determine boundary conditions.
  //use spiralTheta as a SCALAR
  if (mouseYspiralAcceleration) {
    spiralAcceleration = map(mouseY, 0, height, .001, 1);
  }
  spiralTheta = spiralTheta+ spiralSize * spiralAcceleration;
  if (abs(spiralTheta) > 2) {
    spiralSize =spiralSize*-1;
  }
  location.mult(spiralTheta);
  point (location.x, location.y);
  if (showLines) {
    line(0, 0, location.x, location.y);
  }
}

////Do '7': draw the faceControlCircles
void drawFaceControlSpirals (PVector location, PVector centerCircle) {
  translate (centerCircle.x, centerCircle.y);
  ellipse (0, 0, amplitudeX *.5, amplitudeY*.5); 
  point (0, 0);
  //line(0, 0, width-location.x, height-location.y);
  float backWardsY = location.y*-1;
  float backWardsX = location.x*-1;
  point (location.x, backWardsY);
  point (location.x, location.y);
  point (backWardsX, backWardsY);
  point (backWardsX, location.y);
  if (showLines) {
    line(0, 0, location.x, location.y);
    line (0, 0, location.x, backWardsY);
    line (0, 0, backWardsX, backWardsY);
    line (0, 0, backWardsX, location.y);
  }
}

// this allows me to increase the complexity with keypad
void keyPressed() {
  if (key == '0') {
    lastKey=0;
  }
  if (key == '1') {
    lastKey=1;
  }
  if (key == '2') {
    lastKey=2;
  }
  if (key== '3') {
    lastKey=3;
  }
  if (key =='4') {
    lastKey=4;
  }
  if (key =='5') {
    lastKey=5;
  }
  if (key == '6') {
    lastKey=6;
  }
  if (key == '7') {
    lastKey = 7;
  }
  if (key == ' ') {
    showLines = !showLines;
  }
  if (key == 'v') {
    mouseVelocity = !mouseVelocity;
  }
  if (key == 's') {
    mouseYspiralAcceleration = !mouseYspiralAcceleration;
  }
  if (key == CODED) {
    if (keyCode == SHIFT) {
      faceControl = !faceControl;
    }
  }
}

public void mouthWidthReceived(float w) {
  println("mouth Width: " + w);
  mouthWidth = w;
}
public void mouthHeightReceived(float h) {
  println("mouth height: " + h);
  mouthHeight = h;
}
public void eyebrowLeftReceived(float h) {
  println("eyebrow left: " + h);
  leftEyebrowHeight = h;
}
public void eyebrowRightReceived(float h) {
  println("eyebrow right: " + h);
  rightEyebrowHeight = h;
}
public void eyeLeftReceived(float h) {
  println("eye left: " + h);
  eyeLeftHeight = h;
}
public void eyeRightReceived(float h) {
  println("eye right: " + h);
  eyeRightHeight = h;
}
public void jawReceived(float h) {
  println("jaw: " + h);
}

public void nostrilsReceived(float h) {
  println("nostrils: " + h);
  nostrilHeight = h;
}
public void found(int i) {
  println("found: " + i); // 1 == found, 0 == not found
  found = i == 1;
}
public void posePosition(float x, float y) {
  println("pose position\tX: " + x + " Y: " + y );
  posePosition = new PVector(x, y);
}
public void poseScale(float s) {
  println("scale: " + s);
  poseScale = s;
}
public void poseOrientation(float x, float y, float z) {
  println("pose orientation\tX: " + x + " Y: " + y + " Z: " + z);
  poseOrientationX = x;
  poseOrientationY = y;
  poseOrientationZ = z;
}
void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.isPlugged()==false) {
    println("UNPLUGGED: " + theOscMessage);
  }
}

