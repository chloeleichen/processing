/**************************************/
// Starphonie
// Created by Lionel Mischler 9/9/2014
/**************************************/
Table starTable;
StarSigns[] zodiacStarSigns;
Star[] importedStars;
Star[][] storedLines;
Star destStar;
Star startStar;

//Joe intro
IntroStar[] introStars = new IntroStar[400];
PImage bgImg;
PImage logoImg;
//PImage returnImg;
Boolean introScreen;

//image
PImage background;

// counter & constants
int maxStarConnections = 100;
int addStarCursor = 0;
int countStarSigns = 12;
int starSignCursor = 0;

// debugger variables
cDebugger gDebugger;
boolean gIsDebugOn = true;
int gFontSize = 16;

void setup() {
  //Joe setup
    introScreen = true;
    logoImg = loadImage("logo_lo.png");
    //returnImg = loadImage("return.png");
    for (int i = 0; i<introStars.length; i++) {
      introStars[i] = new IntroStar(int(random(0, width)), (random(0, height)), (random(0.5, 3)), int(random(1, 6)));
    }
  
  background = loadImage("background.jpg");
  //orientation(LANDSCAPE); <activity android:name=""> 
  //size(2560, 1600);
  size(background.width, background.height);
  image(background, 0, 0);
  //fill(255);
  starTable = loadTable("stars.csv", "header");
  zodiacStarSigns = new StarSigns[countStarSigns]; 
  importedStars = new Star[starTable.getRowCount()];
  
  //create a StarSign cancer
  Star[][] tempStarSignLines = new Star[2][4];
  tempStarSignLines[0][0] = new Star("Sirius");
  tempStarSignLines[1][0] = new Star("Canopus");
  tempStarSignLines[0][1] = new Star("Canopus");
  tempStarSignLines[1][1] = new Star("KartiKarti");
  tempStarSignLines[0][2] = new Star("KartiKarti");
  tempStarSignLines[1][2] = new Star("BungaBunga");
  tempStarSignLines[0][3] = new Star("KartiKarti");
  tempStarSignLines[1][3] = new Star("Abraham");
  //String starSignImg = ;
  zodiacStarSigns[0] = new StarSigns("Cancer", "cancer.png", tempStarSignLines);
  starSignCursor++;
  
  //create a StarSign gemini
  tempStarSignLines = new Star[2][2];
  tempStarSignLines[0][0] = new Star("Gem1");
  tempStarSignLines[1][0] = new Star("Gem2");
  tempStarSignLines[0][1] = new Star("Gem2");
  tempStarSignLines[1][1] = new Star("Gem3");
  //String starSignImg = ;
  zodiacStarSigns[1] = new StarSigns("Gemini", "gemini.png", tempStarSignLines);
  starSignCursor++;
  
  // store all stars from CSV (StarTable) to importedStars Array
  for (int i=0 ; i < starTable.getRowCount() ; i++)
  { 
    TableRow eRow = starTable.getRow(i);
    importedStars[i] = new Star(eRow.getFloat("x"), eRow.getFloat("y"), eRow.getFloat("earth_distance"), eRow.getFloat("size"), eRow.getString("color"), eRow.getString("note"), eRow.getString("reverb"), eRow.getString("starname"), eRow.getString("starsign"));
  }
  
  storedLines = new Star[maxStarConnections][maxStarConnections];
  
  // Debugger can be turned off if commented out
  gDebugger = new cDebugger();
  gDebugger.setColor(color(100, 255, 100));
  }

void draw() {
  image(background, 0, 0);
  
  if (mousePressed&&introScreen){
    introScreen=false;
  }
  
  if (introScreen==true){
    //image(bgImg, 0, 0);
    image(logoImg, 850, 300);
    for (int i=0; i<introStars.length; i++) {
      introStars[i].scroll();
      introStars[i].mass();
      introStars[i].display();
    }
  }
  else {
  
  for (int j = 0 ; j < starSignCursor ; j++) {
    String path = zodiacStarSigns[j].getStarSignImage();
    PImage img = loadImage(path);
    image(img, ((j+1)*100)+200, 650);
  }
    
  for (int i = 0 ; i < importedStars.length ; i++) {
    ellipse(importedStars[i].getX(), importedStars[i].getY(),importedStars[i].getSize(), importedStars[i].getSize());
  }
  
  for (int i = 0 ; i < addStarCursor; i++) {
    Star start = storedLines[0][i];
    Star dest = storedLines[1][i];
    connectline(start, dest);
    
  }
  
  //strokeWeight(2);
  //stroke(120);
  //print(tempStar.getString("starname"));
  
  if (mousePressed) {
    Star tempStar = starOver();

    if (tempStar!=null && startStar==null) {
      // first time hit Star + mousepressed
      startStar = tempStar;
      drawline(startStar);
    }
    else if (startStar!=null) {
      // drawline after hit Star + mousepressed
      drawline(startStar);
    }
  }
  gDebugger.add("FPS: " + frameRate);
  gDebugger.add("mouse: [" + mouseX + "," + mouseY + "]");
  gDebugger.add("last key: " + key);

  gDebugger.draw();
  }
}

String findStarSign(Star pStar) {
  int foundStarsFromStarSign;
    for (int i = 0 ; i < starSignCursor ; i++) {
      println(pStar.getStarSign() +","+ zodiacStarSigns[i].getStarSignName());
      if (zodiacStarSigns[i].getStarSignName().equals(pStar.getStarSign())) {
        println("found a Star Sign!!");
        
        foundStarsFromStarSign = zodiacStarSigns[i].getStarSignLines()[0].length;
        println("Found stars from Star signs:" + foundStarsFromStarSign);
        println("Found Star connections: " + addStarCursor);
        for (int j = 0 ; j < zodiacStarSigns[i].getStarSignLines()[0].length ; j++) {
          for (int k = 0 ; k < addStarCursor ; k++) {
            
            if (zodiacStarSigns[i].getStarSignLines()[0][j].getStarName().equals(storedLines[0][k].getStarName()) && zodiacStarSigns[i].getStarSignLines()[1][j].getStarName().equals(storedLines[1][k].getStarName())) {
              println("Starsign starname (first col): " + zodiacStarSigns[i].getStarSignLines()[0][j].getStarName());
              println("Starsign starname (sec col): " + zodiacStarSigns[i].getStarSignLines()[1][j].getStarName());
              println("Stored lines starname (first col): " + storedLines[0][k].getStarName());
              println("Stored lines starname (sec col): " + storedLines[1][k].getStarName());
              
              foundStarsFromStarSign--;
              println ("Found star sign line int: "+foundStarsFromStarSign);
            }
            
            else if(zodiacStarSigns[i].getStarSignLines()[1][j].getStarName().equals(storedLines[0][k].getStarName()) && zodiacStarSigns[i].getStarSignLines()[0][j].getStarName().equals(storedLines[1][k].getStarName())){ //&& signStar == storedLines[1][k]) {
              
              println("Starsign starname (first col): " + zodiacStarSigns[i].getStarSignLines()[0][j].getStarName());
              println("Starsign starname (sec col): " + zodiacStarSigns[i].getStarSignLines()[1][j].getStarName());
              println("Stored lines starname (first col): " + storedLines[0][k].getStarName());
              println("Stored lines starname (sec col): " + storedLines[1][k].getStarName());
              
              foundStarsFromStarSign--;
              println ("Found star sign line int: "+foundStarsFromStarSign);
            }
            
            if (foundStarsFromStarSign == 0) {
              return zodiacStarSigns[i].getStarSignName();
            }
          }
        }
      }
    }
    return "not found";
} 

void mouseReleased() {
  if (startStar!=null) {
    //print("startStar is not null");
    //mouseReleased = true;
    destStar = starOver();
    if (destStar!=null && destStar!=startStar) { 
      storedLines[0][addStarCursor] = startStar;
      storedLines[1][addStarCursor] = destStar;
      addStarCursor++;
      println(findStarSign(destStar)); // PLAY MUSIC
    }
    startStar = null;
    destStar = null;
    //currentColor = circleColor;
  }
}

Star starOver() {
  for (int i = 0 ; i < importedStars.length ; i++) {
    float disX = importedStars[i].getX() - mouseX;
    float disY = importedStars[i].getY() - mouseY;
    if (sqrt(sq(disX) + sq(disY)) < (importedStars[i].getSize()/2)*4) {
      return importedStars[i];
    } else {

    }
  
  }
  return null;
}

void drawline(Star pFoundStar)
{
   stroke(255);
   line(pFoundStar.getX(), pFoundStar.getY(), mouseX, mouseY);
}

void connectline(Star pStartStar, Star pDestStar)
{
  stroke(255);
  line(pStartStar.getX(), pStartStar.getY(), pDestStar.getX(), pDestStar.getY());
}

void keyPressed(){
 
  // We should be able to toggle the debugger so
  // it doesn't consume resources.
  if(key == 'd'){
    gIsDebugOn = !gIsDebugOn;
    gDebugger.setOn(gIsDebugOn);
  }
 
  // The debugging lines can add up quickly.
  // One way to keep everything on screen is to allow
  // the user to adjust the font size.
  if(key == '+'){
    gFontSize++;
  }
 
  if(key == '-'){
    gFontSize--;
    if(gFontSize == 0){
      gFontSize = 1;
    }
  }
 
  gDebugger.setFont("verdana", gFontSize);
}

