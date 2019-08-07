int scale = 14;
int row = 700*2/scale;
int col = 700*2/scale;
int i = 0;
int j = 0;
float[][] terrain;
float flyingY = 0;
float flyingX = 0;

void setup(){
  size(700, 700, P3D);
  smooth();
  background(255);
  frameRate(7);
}

void draw(){
  background(#FFF3C6);
  stroke(#FFF3C6, 100);
  fill(#FFF3C6);
  
  
  ////////////////////////////////
  //Noise for the structures that will pop up
   flyingY -= 0.2;
 //  flyingX -= 0.2;
   terrain = new float[row][col];
   
   float v = flyingY;
   for (int j = 0; j < row; j++){
     float m = flyingX;
    for (int i = 0; i < col; i+=2){
      
      float p = map(noise(m, v), 0, 1, 0, 300); 
      if ( p > 150){
        terrain[i][j] = p;
        terrain[i+1][j] = p;
      }
      else if ( p > 20 && p < 80){
        terrain[i][j] = p;
        terrain[i+1][j] = p;
      }
      else
      {
         terrain[i][j] = 0;
         terrain[i+1][j] = 0;
      }

       m += 0.1;
    }
     
       v += 0.1;
       
   }
  
  
  
  //////////////////////////////
  //Drawing the actual mesh
   translate(width/2, height/2);
   rotateZ(radians(90));
   translate(-width/2, -height, -900);
    rotateY(-PI/(2.6));
  
//  rotateZ(radians(90));
 // translate(-width/2, -height/2, -300);


  
  for (i = 0; i < row - 1; i++){
    beginShape(QUAD_STRIP);
    for (j = 0; j < col-2; j+=2){
      if (terrain[j][i] > 10 && terrain[j+1][i] > 10 && terrain[j][i+1] > 10){
       //fill(115, random(255), 193);
       if(terrain[j][i] > 150){
       fill(#05AAA9);
       }
       else{
         fill(0);
       }
      vertex(j * scale, i * scale, 0);
      vertex(j * scale, (i+1) * scale, 0);
      
      vertex(j * scale, i * scale, terrain[j][i]);
      vertex(j * scale, (i+1) * scale, terrain[j][i + 1]);
      
      vertex((j+1) * scale, i * scale, terrain[j+1][i]);
      vertex((j+1) * scale, (i+1) * scale, terrain[j+1][i + 1]);
      
      vertex((j+2) * scale, i * scale, terrain[j+1][i]);
      vertex((j+2) * scale, (i+1) * scale, terrain[j+1][i + 1]);
      
      vertex((j+2) * scale, i * scale, 0);
      vertex((j+2) * scale, (i+1) * scale, 0);
      
      }
      
      else if(terrain[j][i] > 10 && terrain[j+1][i] > 10 && terrain[j][i+1] < 10) {
        fill(#FFF3C6);
        vertex(j * scale, i * scale, 0);
      vertex(j * scale, (i+1) * scale, 0);
      vertex((j+1) * scale, i * scale, 0);
      vertex((j+1) * scale, (i+1) * scale, 0);
       vertex((j+2) * scale, i * scale, 0);
      vertex((j+2) * scale, (i+1) * scale, 0);
        
      }
      else{
        fill(#FFF3C6);
      vertex(j * scale, i * scale, 0);
      vertex(j * scale, (i+1) * scale, 0);
      vertex((j+1) * scale, i * scale, 0);
      vertex((j+1) * scale, (i+1) * scale, 0);
       vertex((j+2) * scale, i * scale, 0);
      vertex((j+2) * scale, (i+1) * scale, 0);

      }
        
    }
    endShape();
    
  }
 
 saveFrame("output/jungle_####.png");
 
}
