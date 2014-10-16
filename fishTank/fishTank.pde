ArrayList <Seaweed> seaweeds;
ArrayList<Bubble> bubbles;

int num =3;
Tenticle tenticle;
PVector loc;
int len = int(random(60, 80));
int number =3;
PVector origin;
PVector newLoc;





 
void setup(){
  size(600, 400);
  loc = new PVector(width-100, height);
  origin = new PVector(random(10, width-10), height);
  tenticle = new Tenticle(loc,len );
  bubbles = new ArrayList<Bubble>();
  
  
  
  seaweeds = new ArrayList<Seaweed>();
  for (int i =0; i < num; i ++){
    seaweeds.add(new Seaweed());
    for(int j =0; j < number; j ++){
      bubbles.add(new Bubble(origin));
        }
    
  }
}
  
void draw(){
  origin = new PVector(random(width), height);
   background(0);
   tenticle.drawTenticle();

   for(int i =0; i < seaweeds.size()-1; i ++){ 
       pushMatrix();
       translate(i *120 +130, height);
       Seaweed s = seaweeds.get(i);
       s.drawSeaweed();
       popMatrix();
          for (int j =0; j < bubbles.size()-1; j ++){
           Bubble b = bubbles.get(j);
           b.run();
           if(b.isDead()){
                 bubbles.remove(j);
                 newLoc = new PVector(random(width), height);
                           bubbles.add(new Bubble(newLoc));
             
           }

  
 }
}
}


  
  

  

