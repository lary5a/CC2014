
// myfirstsketch : draw a white square where my mouse is
// groovy

// at the top of the sketch
float r1, g1, b1, r2, g2, b2, r3, g3, b3, r4, g4, b4, r5, g5, b5;
float w, h, n,k, b, wh; // GLOBAL variables

// this runs when i hit play
void setup()
{
  size(800, 600); // sets up the size of the canvas
  
  background(0, 0, 0);
  frameRate(10);
  n=1;
  k=0;
  noFill();
  strokeWeight(4);
  stroke(255,255,255);
  ellipse(400,350,55,55);
  line(400,380,400,450);
  line(400,450,350,500);
  b=0;
  wh=255;
  
  // draw rectangles where coordinates are the center, not the edge:
  rectMode(CENTER); 
  
}

// this runs every frame
void draw()
{
    
    
  // these are variables:
  strokeWeight(2);
  r1 = 255;
  g1 = 0;
  b1 = 0;
  r2 = 255;
  g2 = 0;
  b2 = 255;
  r3 = 0;
  g3 = 255;
  b3 = 255;
  r4 = 0;
  g4 = 255;
  b4 = 0;
  r5 = 188;
  g5 = 19;
  b5 = 254;
  
  w = 100;
  h = 100;
  
  // set a more interesting color
  if(n==1)
  fill(r1, g1, b1);
  if(n==2)
  fill(r2, g2, b2);
  if(n==3)
  fill(r3, g3, b3); 
  if(n==4)
  fill(r4, g4, b4);
  if(n==5)
  fill(r5, g5, b5);
  stroke(0, 0, 0);
  
 /* rect(49,449 , w, h); // x, y, w, h
  rect(149, 449, w,h);
  rect(249,449,w,h);
  rect(349,449,w,h);
  rect(449,449,w,h);
  rect(549,449,w,h);
  rect(649,449,w,h);
  rect(749,449,w,h);*/
  rect(49,549 , w, h); // x, y, w, h
  rect(149, 549, w,h);
  rect(249,549,w,h);
  rect(349,549,w,h);
  rect(449,549,w,h);
  rect(549,549,w,h);
  rect(649,549,w,h);
  rect(749,549,w,h);
  if(n==1)
  stroke(r1, g1, b1);
  if(n==2)
  stroke(r2, g2, b2);
  if(n==3)
  stroke(r3, g3, b3); 
  if(n==4)
  stroke(r4, g4, b4);
  if(n==5)
  stroke(r5, g5, b5);
  line (0,0,mouseX,549);
  line (799,0,mouseX,549);
  line (400,0,mouseX,549);
  if (n==5) n=0;
  n++;
}

// this runs when i pick up a key on the keyboard
void keyReleased()
{

  if(key==' ')
 {
  if(k==0)
 { 
   background(wh, wh, wh);
   k++;
 }
 else
 {
   background(b,b,b);
   k--;
 }
 }
}

