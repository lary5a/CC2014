// import the fingertracker library
// and the SimpleOpenNI library for Kinect access
import fingertracker.*; 
import SimpleOpenNI.*;
// this is the junk the program needs to do the physics
import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;
import fingertracker.*;
import SimpleOpenNI.*;

Box2DProcessing e; // this is our world

float FRICTION = 0;

ArrayList<lukeBox> theboxes;
ArrayList<lukeWall> thewalls;



float posX, posY, wid, hei;
float vr, vg, vb, va;
lukeSideWall leftWall, rightWall, topWall, bottomWall;

lukeBox thebox;
lukeBall b;

lukeSpring spring; // physics spring

int i;

// set a default threshold distance:
// 625 corresponds to about 2-3 feet from the Kinect
int threshold = 625;
int positionXTotal = 0;
int positionYTotal = 0;
int positionXAvg = 0;
int positionYAvg = 0;
int posXfuck = 0;
int posYfuck = 0;

// declare FignerTracker and SimpleOpenNI objects
FingerTracker fingers;
SimpleOpenNI kinect;

void setup()
{
  size(800, 600, OPENGL);

  // initialize your SimpleOpenNI object
  // and set it up to access the depth image
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  // mirror the depth image so that it is more natural
  kinect.setMirror(true);



  // this sets up the box2d physics engine to deal with us
  e = new Box2DProcessing(this); // this creates the engine
  e.createWorld(); // this starts the engine
  e.setGravity(0, 0); // this is gravity (x, y)

  theboxes = new ArrayList<lukeBox>();
  thewalls = new ArrayList<lukeWall>();

  // TURN ON COLLISION DETECTION!
  e.listenForCollisions();

  createGame();

  leftWall = new lukeSideWall(-10, 0, 0, height);
  rightWall = new lukeSideWall(width+10, 0, 1, height);
  topWall = new lukeSideWall(0, 0, width, 1);
  bottomWall = new lukeSideWall(0, height+5, width, 1);

  b = new lukeBall(width/2, height-50, 20, 20);
  thebox = new lukeBox(width/2, height/2, 50, 30);

  // Make the spring (it doesn't really get initialized until the mouse is clicked)
  spring = new lukeSpring();
  spring.bind(width/2, height/2, thebox);
}

void draw()
{
  action();
  background(0);
  e.step(); // advances the physics engine one frame

  leftWall.display();
  rightWall.display();
  topWall.display();
  bottomWall.display();
  thebox.display();

  for (int i = 0; i < theboxes.size (); i++)
  {
    theboxes.get(i).display();
  }

  for (int j = 0; j < thewalls.size (); j++)
  {
    if (thewalls.get(j).hittimes == 2)
    {
      thewalls.get(j).killBody();
      thewalls.remove(j);
    } else
    {
      thewalls.get(j).display();
    }
  }

  b.display();
  //spring.update(positionXTotal%width, positionXTotal%height);
  spring.update(positionXAvg%width, positionXAvg%height);
}

void keyPressed()
{
  createGame();
}

void keyReleased()
{
}

void mouseDragged()
{
}
// THIS HAPPENS WHEN THIS HIT EACH OTHER
void beginContact(Contact cp) {
  // Get both fixtures
  Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();
  // Get both bodies
  Body b1 = f1.getBody();
  Body b2 = f2.getBody();

  // Get our objects that reference these bodies
  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();
  int wallhitsword = 0;
  if (o1.getClass() == lukeWall.class && o2.getClass() == lukeBall.class) wallhitsword = 1;
  if (o2.getClass() == lukeWall.class && o1.getClass() == lukeBall.class) wallhitsword = 2;

  if (wallhitsword==1)
  {
    lukeBall b = (lukeBall) o2;
    b.boink();
    lukeWall w = (lukeWall) o1;
    w.boink();
  } else if (wallhitsword==2)
  {
    lukeBall b = (lukeBall) o1;
    b.boink();
    lukeWall w = (lukeWall) o2;
    w.boink();
  }
}

// THIS HAPPENS WHEN THINGS STOP HITTING EACH OTHER
void endContact(Contact cp) {
}

void createGame()
{
  wid = 50;
  hei = 30;
  vr = 255;
  vg = 0;
  vb = 255;
  va = 255;

  for (int a = 0; a < height/2; a+=hei)
  {
    for (int b = 0; b < width; b+=wid)
    {
      lukeWall w = new lukeWall(b, a, wid, hei, vr, vg, vb, va);
      thewalls.add(w);
    }
    vg += 30;
  }
}

void RandCreation()
{
}

void action() 
{
  // initialize the FingerTracker object
  // with the height and width of the Kinect
  // depth image
  fingers = new FingerTracker(this, 640, 480);
  // the "melt factor" smooths out the contour
  // making the finger tracking more robust
  // especially at short distances
  // farther away you may want a lower number
  fingers.setMeltFactor(100);

  // get new depth data from the kinect
  kinect.update();
  // get a depth image and display it
  PImage depthImage = kinect.depthImage();
  //image(depthImage, 0, 0);

  // update the depth threshold beyond which
  // we'll look for fingers
  fingers.setThreshold(threshold);

  // access the "depth map" from the Kinect
  // this is an array of ints with the full-resolution
  // depth data (i.e. 500-2047 instead of 0-255)
  // pass that data to our FingerTracker
  int[] depthMap = kinect.depthMap();
  fingers.update(depthMap);

  // iterate over all the contours found
  // and display each of them with a green line
  /*stroke(0,255,0);
   for (int k = 0; k < fingers.getNumContours(); k++) {
   fingers.drawContour(k);
   }*/

  // iterate over all the fingers found
  // and draw them as a red circle
  positionXTotal = 0;
  positionYTotal = 0;
  positionXAvg = 0;
  positionYAvg = 0;

  noStroke();
  fill(255, 0, 0);
  for (int i = 0; i < fingers.getNumFingers (); i++) 
  {
    PVector position = fingers.getFinger(i);
    //ellipse(position.x - 5, position.y -5, 10, 10);
    positionXTotal += position.x;
    positionYTotal += position.y;
  }

  if (fingers.getNumFingers() > 0) 
  {
    positionXAvg = positionXTotal / fingers.getNumFingers();
    positionYAvg = positionYTotal / fingers.getNumFingers();
  }

  //print(positionXTotal + ", " + positionYTotal);
  //print(posXfuck + ", " + posYfuck);
  println(positionXAvg + ", " + positionYAvg);
  rect(positionXAvg, positionYAvg, 10, 10);

  // show the threshold on the screen
  fill(255, 0, 0);
  text(threshold, 10, 20);

  posX = positionXAvg;
  posY = positionYAvg;
}

