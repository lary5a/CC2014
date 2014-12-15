/*
// import the fingertracker library
// and the SimpleOpenNI library for Kinect access
import fingertracker.*; 
import SimpleOpenNI.*;


class fingerT
{

  // import the fingertracker library
  // and the SimpleOpenNI library for Kinect access
  import fingertracker.*; 
  import SimpleOpenNI.*;
  // declare FignerTracker and SimpleOpenNI objects
  FingerTracker fingers;
  SimpleOpenNI kinect;
  // set a default threshold distance:
  // 625 corresponds to about 2-3 feet from the Kinect
  int threshold = 625;
  int positionXTotal = 0;
  int positionYTotal = 0;
  int positionXAvg = 0;
  int positionYAvg = 0;
  int posX = 0;
  int posY = 0;

  fingerT()
  {
    
  }

  // initialize your SimpleOpenNI object
  // and set it up to access the depth image
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  // mirror the depth image so that it is more natural
  kinect.setMirror(true);

  // initialize the FingerTracker object
  // with the height and width of the Kinect
  // depth image
  fingers = new FingerTracker(this, 640, 480);
  // the "melt factor" smooths out the contour
  // making the finger tracking more robust
  // especially at short distances
  // farther away you may want a lower number
  fingers.setMeltFactor(100);

  
  void action() 
  {
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
     }

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

    print(positionXTotal + ", " + positionYTotal);
    rect(positionXAvg, positionYAvg, 10, 10);

    // show the threshold on the screen
    fill(255, 0, 0);
    text(threshold, 10, 20);

    posX = positionXAvg;
    posY = positionYAvg;
  }
}
   // keyPressed event:
   // pressing the '-' key lowers the threshold by 10
   // pressing the '+/=' key increases it by 10 
   void keyPressed() {
   if (key == '-') {
   threshold -= 10;
   }
   
   if (key == '=') {
   threshold += 10;
   }
   }
  

*/
