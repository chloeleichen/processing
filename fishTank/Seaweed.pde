class Seaweed{
  
  ArrayList <Branch> branches;
  int maxSize = int(random(40, 65));
  float len = random(50, 120);
  float r = random(250);
  float g = random(250);
  float b = random(250);
  

Seaweed(){
  
  branches = new ArrayList<Branch>();
  for(int i = 0; i < maxSize; i++)
  {
    branches.add(new Branch(len));
  
  }

}
  
void drawSeaweed(){
  
  for(int i = 0; i < branches.size(); i++){
    stroke(r, g, b, 65);
    Branch b = (Branch) branches.get(i);
    pushMatrix();
    rotate(radians(b.startAngle));
    b.branch(b.segments);
    popMatrix();
  }
}


}




