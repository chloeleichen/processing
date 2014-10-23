//Kinect Silhouete by Chloe Chen 2014

import SimpleOpenNI.*;
import java.util.*;
SimpleOpenNI context;
 
color[] userColors = { 
  color(255, 0, 0),
  color(0, 255, 0),
  color(0, 0, 255),
  color(#FFC400),
  color(#8B00FF),
  color(#FF0D00)
};
 
 
int[] userMap;
int blob_array[];
int userCurID;
int cont_length = 640*480;

 
void setup() {
  size(640, 480);
  background(0);
 
  context = new SimpleOpenNI(this);
 
    // mirror the image to be more intuitive
    context.setMirror(true);
 
  context.enableDepth();
  context.enableUser();
 
  blob_array=new int[cont_length];
 
}
 
void draw() {
  background(0);
  context.update();
 
  int[]depthValues= context.depthMap();
  int[] userMap = null;
  int userCount = context.getNumberOfUsers();
 
  if(userCount > 0) {
    userMap = context.userMap();
}
    for (int y=0; y<context.depthHeight(); y++) {
    for (int x=0; x<context.depthWidth(); x++) {
      int index = x + y * context.depthWidth();
      if (userMap != null && userMap[index] > 0) {
        userCurID = userMap[index];
        set(x, y, 255); // put your sample random text
          }
        }
      }
   }
   void onNewUser(int userId) {
  println("detected" + userId);
}
void onLostUser(int userId) {
println("lost: " + userId);
}
