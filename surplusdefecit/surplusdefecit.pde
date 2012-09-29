float rotate_val = 0;

void setup() {
  size(800,600,P3D);
  frameRate(30);

}

void draw(){
  rotate_val = rotate_val + 0.1;
    translate(width/2, height/2, 0);
  background(0);
   rotateY(rotate_val);
   stroke(255);
   
    scale(100);
  beginShape();
  vertex(-1, -1, -1);
  vertex( 1, -1, -1);
  vertex( 0,  0,  1);

  vertex( 1, -1, -1);
  vertex( 1,  1, -1);
  vertex( 0,  0,  1);

  vertex( 1, 1, -1);
  vertex(-1, 1, -1);
  vertex( 0, 0,  1);

  vertex(-1,  1, -1);
  vertex(-1, -1, -1);
  vertex( 0,  0,  1);
  endShape();
   //box(40);
  
}
