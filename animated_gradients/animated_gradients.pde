int rows = 100;
int cols = 100;

float [] [] grays = new float [rows][cols];
float [] [] incs = new float [rows][cols];
int cellSize = 5;

void setup(){
  size(cellSize *cols, cellSize * rows);
  noStroke();
  
  for(int i =0; i < rows; i ++){
    for (int j =0; j < cols; j++){
      float x = map(i , 0, rows -1, 0, 2*PI);
      float y = map(j , 0, cols -1, 0, 2*PI);
      
      float z = cos(y)*sin(x);
      grays[i][j] = map(z, -1.0, 1.0, 0 ,255.0);
      incs[i][j] = 1;
    }
  }
}

void draw(){
  background(255);
  
  for(int i =0; i < rows; i ++){
    for (int j =0; j < cols; j++){
      fill(grays[i][j]);
      pushMatrix();
      translate(i *cellSize, j * cellSize);
      rect(0, 0, cellSize, cellSize);
      popMatrix();
      
      if (grays[i][j] > 255 || grays[i][j] < 0){
        incs[i][j] = - incs[i][j];
    }
    grays[i][j] += incs[i][j];
  
    }
  }
      
}    
      
  
  
  
  
  
      
