/**************************************/
// Debugger
// Created by Salga Andor (http://asalga.wordpress.com/2011/06/04/real-time-debugging-in-processing/)
/**************************************/

public class cDebugger{
  private ArrayList strings;
  private PFont font;
  private int fontSize;
  private color textColor;
  private boolean isOn;
 
  public cDebugger(){
    strings = new ArrayList();
    setFont("verdana", 16);
    setColor(color(255));
    isOn = true;
  }
 
  public void add(String s){
    if(isOn){
      strings.add(s);
    }
  }
 
  /*
    If off, the debugger will ignore calls to add() and draw().
  */
  public void setOn(boolean on){
    isOn = on;
  }
 
  public void setFont(String name, int size){
    fontSize = size <= 0 ? 1 : size;
    font = createFont(name, fontSize);
  }
 
  public void setColor(color c){
    textColor = c;
  }
 
  public void clear(){
    while(strings.size() > 0){
      strings.remove(0);
    }
  }
 
  public void draw(){
    if(isOn){
      pushStyle();
      fill(textColor);
      textFont(font);
      int y = fontSize;
 
      for(int i = 0; i < strings.size(); i++, y += fontSize){
        text((String)strings.get(i), 5, y);
      }
      popStyle();
 
      // Remove the strings since they have been rendered.
      clear();
    }
  }
}
