// CONWAY'S GAME OF LIFE
// http://en.wikipedia.org/wiki/Conway's_Game_of_Life
//
// this processing sketch implements John Conway's Game of Life simulation
// as an image-processing system... it looks at pixels in a processing PImage
// and treats them as cells in a version of Conway's simulation.
//
// your tasks:
// (1) make this thing look more interesting... 
// hint: you don't have to display the image directly to the screen.
// another hint: the double for() loop can be used to draw other things (shapes, text, etc.)
// as a proxy for the pixels in the simulation.
// (2) the RULES in the draw() loop determine how the simulation decides to keep a pixel
// alive or generate a new one from a dead pixel.  this rule set is sometimes referred to as
// B3/S23 (a pixel is "Born" with 3 neighbors and "Stays Alive" with 2 or 3 neighbors.
// tweak these rules and see if you can find other interesting (or self-sustaining) systems.
//


PImage c[] = new PImage[2]; // input image

int w, h; // width and height

int i, j; // counter variables

int center; // is the pixel alive or dead?
int sum; // how many neighbors are alive?

int which = 0; // which image are we working on

// 9 pixels for the neighborhood (p4 is center):
//  p0  p1  p2
//  p3 *p4* p5
//  p6  p7  p8
color p0, p1, p2, p3, p4, p5, p6, p7, p8; 

void setup()
{
  size(800, 600); // make the screen square
  noSmooth(); // turn off image and shape interpolation

  // create two blank images to work with for the game
  c[0] = createImage(150, 150, RGB);
  c[1] = createImage(150, 150, RGB);
  w = c[0].width; // width
  h = c[0].height; // height

  /*c[0] = createImage(150, 150, RGB);
   c[1] = createImage(150, 150, RGB);
   w = c[0].width; // width
   h = c[0].height; // height*/

  // fill our first image with random stuff:
  fillRandom();
}

void draw()
{

  c[which].loadPixels(); // load up the pixels array for input

  // step 1 - add pixels where mouse is
  if (mousePressed)
  {
    int mx = constrain(int(mouseX/8.0), 0, width-1);
    int my = constrain(int(mouseY/8.0), 0, height-1);
    c[which].pixels[my*w + mx] = color(75, 0, 130);
  }

  // step 2 - get the values for the "neighborhood" around each pixel
  for (i=0; i<h; i++) // these pixels are the rows
  {
    for (j=0; j<w; j++) // thise pixels are the columns
    {

      // top row
      p0 = c[which].pixels[((i-1+h)%h)*w + (j-1+w)%w]; // left pixel
      p1 = c[which].pixels[((i-1+h)%h)*w + j]; // center pixel
      p2 = c[which].pixels[((i-1+h)%h)*w + (j+1+w)%w]; // left pixel

      // center row
      p3 = c[which].pixels[i*w + (j-1+w)%w]; // left pixel
      p4 = c[which].pixels[i*w + j]; // center pixel
      p5 = c[which].pixels[i*w + (j+1+w)%w]; // left pixel

      // bottom row
      p6 = c[which].pixels[((i+1+h)%h)*w + (j-1+w)%w]; // left pixel
      p7 = c[which].pixels[((i+1+h)%h)*w + j]; // center pixel
      p8 = c[which].pixels[((i+1+h)%h)*w + (j+1+w)%w]; // left pixel

      // compute the sum: use the green channel for simplicity
      sum = 0; // start blank
      sum+= int(green(p0)>128.) + int(green(p1)>128.) + int(green(p2)>128.); // top neighbors
      sum+= int(green(p3)>128.) + int(green(p5)>128.); // left and right neighbors
      sum+= int(green(p6)>128.) + int(green(p7)>128.) + int(green(p8)>128.); // bottom neighbors

      center = int(green(p4)>128.); // is the center pixel alive?

      //
      // RULES: PLAY WITH THESE
      //
      if (center==1 && (sum==2 || sum==3)) // alive... stay alive
      {
        //if (c[1-which].pixels[i*w + j]<(c[which].pixels.length)/2)
        if (j>w/2)
          c[1-which].pixels[i*w + j] = color(102, 205, 170);//aquamarine
        else
          c[1-which].pixels[i*w + j] = color(189, 252, 201);
        //if (c[1-which].pixels[i*w + j]>(c[which].pixels.length)/2)
        //c[1-which].pixels[i*w + j] = color(75,0,130);
      } else if (center==0 && sum==3) // dead... become alive
      {
        //if (c[1-which].pixels[i*w + j]<(c[which].pixels.length)/2)

        if (j>w/2)
          c[1-which].pixels[i*w + j] = color(51, 161, 201);//peacock
        else
          c[1-which].pixels[i*w + j] = color(174, 238, 238);

        //if (c[1-which].pixels[i*w + j]>(c[which].pixels.length)/2)
        //c[1-which].pixels[i*w + j] = color(132,112,225);
      } else // die (or stay dead)
      {   
        c[1-which].pixels[i*w + j] = color(0, 0, 0);
      }

      if (sum>4)
      {
        if (i*w + j<h+1 && i*w + j<w+1)
        {
          if (j>w/2)
            c[1-which].pixels[i*w + (j+1)] = color(250, 128, 114);
          else
            c[1-which].pixels[i*w + (j+1)] = color(238, 238, 0);
        }
      }
      
      if (int(green(p1)>128.)>0 && int(green(p3)>128.)>0 && int(green(p5)>128.)>0 &&int(green(p7)>128.)>0)
      {  
        c[1-which].pixels[i*w + j] = color(255, 62, 150);
        //if (i*w + j<h+1 && i*w + j<w+1)
        //{if (j>w/2)
        //c[1-which].pixels[i*w + (j+1)] = color(250, 128, 114);
        //else
        //c[1-which].pixels[i*w + (j+1)] = color(255, 62, 150);
        //}
      } 

      if (j==w/2)
      {
        if (int(green(p3)>128.)==1)
        {
          for ( int r =2; r<9; r++)
          {
            c[which].pixels[i*w + (j-r+w)%w]=color(51, 161, 201);
            c[which].pixels[((i-1+h)%h)*w + (j-r+w)%w]=color(51, 161, 201);
            c[which].pixels[((i-r+h)%h)*w + (j-r+w)%w]=color(51, 161, 201);
            c[which].pixels[((i+1+h)%h)*w + (j-r+w)%w]=color(51, 161, 201);
            c[which].pixels[((i+r+h)%h)*w + (j-r+w)%w]=color(51, 161, 201);
          }
          c[which].pixels[i*w + (j-1+w)%w] = color(0, 0, 0);
          c[which].pixels[((i-1+h)%h)*w + (j-1+w)%w] = color(0, 0, 0);
          c[which].pixels[((i+1+h)%h)*w + (j-1+w)%w] = color(0, 0, 0);
        }
        if (int(green(p5)>128.)==1)
        {
          for ( int p =2; p<9; p++)
          {
            c[which].pixels[i*w + (j+p+w)%w]=color(51, 161, 201);
            c[which].pixels[((i+1+h)%h)*w + (j+p+w)%w]=color(51, 161, 201);
            c[which].pixels[((i+p+h)%h)*w + (j+p+w)%w]=color(51, 161, 201);
            c[which].pixels[((i-1+h)%h)*w + (j+p+w)%w]=color(51, 161, 201);
            c[which].pixels[((i-p+h)%h)*w + (j+p+w)%w]=color(51, 161, 201);
          }
          c[which].pixels[i*w + (j+1+w)%w] = color(0, 0, 0);
          c[which].pixels[((i-1+h)%h)*w + (j+1+w)%w] = color(0, 0, 0);
          c[which].pixels[((i+1+h)%h)*w + (j+1+w)%w] = color(0, 0, 0);
        }
        c[1-which].pixels[i*w + j] = color(100, 0, 0);
      }
    }
  }

  c[1-which].updatePixels(); // restore the pixels array

  image(c[1-which], 0, 0, width, height); // draw to screen

  which = 1-which; // swap image buffer
}

void keyPressed()
{
  fillRandom(); // add random noise to image when you press any key
}


void fillRandom()
{
  // fill our current image with random stuff
  c[which].loadPixels();
  for (i=0; i< (c[which].pixels.length); i++)
  {
    float rand = random(1000);
    if (rand>900) // 10% alive
    {
      c[which].pixels[i] = color(102, 205, 170);
    }
  }
  /*for (i=((c[which].pixels.length)/2); i<c[which].pixels.length; i++)
   {
   float rand = random(1000);
   if (rand>900) // 10% alive
   {
   c[which].pixels[i] = color(238,64,0);
   }
   }*/
  c[which].updatePixels();
}

/*colourScheme
 {
 int col = random(0, 13);
 if (col==0)
 return color(220,20,60);//red
 if (col==1)
 return color(255,62,150); //pink
 if (col==2)
 return color(75,0,130);//indigo
 if (col==3)
 return color(132,112,225);//periwinkle
 if (col==4)
 return color(51,161,201);//peacock
 if (col==5)
 return color(174,238,238);//light tourquoise
 if (col==6)
 return color(102,205,170);//aquamarine
 if (col==7)
 return color(189,252,201);//mint
 if (col==8)
 return color(154,205,50);//olive
 if (col==9)
 return color(255,255,224);//beige
 if (col==10)
 return color(238,238,0);//yellow
 if (col==11)
 return color(237,145,33);//carrot
 if (col==12)
 return color(250,128,114);//salmon
 if (col==13)
 return color(238,64,0);//orange-red
 }*/
