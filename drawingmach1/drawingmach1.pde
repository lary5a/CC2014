float n;

void setup()
{
  size(800, 600);
  background(0, 0, 0);
  frameRate(5);
  stroke(255, 255, 255);
  n=0;
}
void draw()
{
  strokeWeight(random(1, 8));
  if(n==0)line(0, mouseY, mouseX, mouseY);
  else line(799, mouseY, mouseX, mouseY);
}
void keyReleased()
{
  if (key==' ') 
  {
    background(0, 0, 0);
    stroke(255, 255, 255);
  } 
  if (key=='g') stroke(100, 100, 100);
  if (key=='d') stroke(50, 50, 50);
  if (key=='w') stroke(255, 255, 255);
  if (key=='r')
  {
    if (n==1) n=0;
    else n=1;
  }
} 

