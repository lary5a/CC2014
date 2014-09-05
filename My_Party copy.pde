
// myfirstsketch : draw a white square where my mouse is
// groovy

// at the top of the sketch
float r1, g1, b1, r2, g2, b2, r3, g3, b3, r4, g4, b4, r5, g5, b5;
float w, h, n, k, b, wh, x;
int f;// GLOBAL variables
int RAYS = 300;
// this runs when i hit play
void setup()
{
  size(800, 600); // sets up the size of the canvas
  background(0, 0, 0);
  frameRate(10);
  f=0;
  n=1;
  x=0;
  k=0;
  makeGuy(f, 1, x);
  b=0;
  wh=255;
  // draw rectangles where coordinates are the center, not the edge:
  rectMode(CENTER);
}

// this runs every frame
void draw()
{
  if (f==0)stroke(255, 255, 255);
  if (f==1)stroke(0, 0, 0);

  strokeWeight(4);
  if (x>=0)
  {
    if (f==0)background(0, 0, 0);
    if (f==1)background(255, 255, 255);
    line(400, 400, 440, 350);
  }
  if (x<0)
  {
    if (f==0)background(0, 0, 0);
    if (f==1)background(255, 255, 255);
    line(400, 400, 375, 450);
  }
  //makeGuy(f, 0);
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
  if (n==1)
    fill(r1, g1, b1);
  if (n==2)
    fill(r2, g2, b2);
  if (n==3)
    fill(r3, g3, b3); 
  if (n==4)
    fill(r4, g4, b4);
  if (n==5)
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
  rect(49, 549, w, h); // x, y, w, h
  rect(149, 549, w, h);
  rect(249, 549, w, h);
  rect(349, 549, w, h);
  rect(449, 549, w, h);
  rect(549, 549, w, h);
  rect(649, 549, w, h);
  rect(749, 549, w, h);
  if (n==1)
    stroke(r1, g1, b1);
  if (n==2)
    stroke(r2, g2, b2);
  if (n==3)
    stroke(r3, g3, b3); 
  if (n==4)
    stroke(r4, g4, b4);
  if (n==5)
    stroke(r5, g5, b5);
  for (int i=0; i<RAYS; i=i+13)
  {
    line (0, 0, mouseX-i, 500);//L
    line(0, 0, mouseX+i, 500);
    line (799, 0, mouseX-i, 500);//R
    line(799, 0, mouseX+i, 500);
    line (400, 0, mouseX-i, 500);//C
    line(400, 0, mouseX+i, 500);
  }  
  /*line (0, 0, mouseX, 549);//L
   line (799, 0, mouseX, 549);//R
   line (400, 0, mouseX, 549);//C*/
  makeGuy(f, 0, x);
  if (n==5) n=0;
  n++;
  x++;
  if (x==5)x=-5;
}

// this runs when i pick up a key on the keyboard
void keyReleased()
{

  if (key==' ')
  {
    if (k==0)
    { 
      background(wh, wh, wh);
      k++;
      f++;
      makeGuy(f, 1, x);
    } else
    {
      background(b, b, b);
      k--;
      f--;
      makeGuy(f, 1, x);
    }
  }
}

void makeGuy(int i, int q, float x)
{
  if (i==0)
  {
    noFill();
    strokeWeight(4);
    stroke(255, 255, 255);
    ellipse(400, 350, 55, 55);
    line(400, 380, 400, 450);//body
    line(400, 450, 375, 500);//left leg
    line(400, 450, 430, 500);//right leg
    line(400, 400, 360, 425);//left first bend
    line(360, 425, 400, 445);//left second bend
    if (x>=0)
    {
      line(400, 400, 440, 350);
    }
    if (x<0)
    {
      line(400, 400, 375, 450);
    }
  } else
  {
    noFill();
    strokeWeight(4);
    stroke(0, 0, 0);
    ellipse(400, 350, 55, 55);
    line(400, 380, 400, 450);//body
    line(400, 450, 375, 500);//left leg
    line(400, 450, 430, 500);//right leg
    line(400, 400, 360, 425);//left first bend
    line(360, 425, 400, 445);//left second bend
    if (x>=0)
    {
      line(400, 400, 440, 350);
    }
    if (x<0)
    {
      line(400, 400, 375, 450);
    }
  }
}

