ArrayList <Seaweed> seaweeds;
int num =3;
Tenticle tenticle;
PVector loc;
int len = int(random(60, 80));
Flock flock;



 
void setup(){
  size(600, 400);
  loc = new PVector(width-100, height);
  tenticle = new Tenticle(loc,len );
  flock = new Flock(7);
  
  seaweeds = new ArrayList<Seaweed>();
  for (int i =0; i < num; i ++){
    seaweeds.add(new Seaweed());
  }
}
  
void draw(){
   background(0);
      tenticle.drawTenticle();
      flock.drawFlock(); 
   for(int i =0; i < num; i ++){
  
   pushMatrix();
   translate(i *120 +130, height);
   Seaweed s = seaweeds.get(i);
   s.drawSeaweed();
   popMatrix();
  
   }
  
}


  
  

  

