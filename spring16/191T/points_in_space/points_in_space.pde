// Brandon Lundberg
// CSCI 191T
// 28 February 2016

/*
 * points_in_space
 * In this assignment, you job is to create a function that, given integer grid coordinates (gx,gy),
 * will construct a set of points within that grid cell. The number and placement
 * of the points should be purely a function of (gx,gy) (i.e., plug in a given (gx,gy) and you will always
 * get out the same set of points). 
 * The only requirements are:
 * -- The number and positions of the points must be *persistent* (always the same for a given cell).
 * -- Cells should have differing numbers of points (you can't just give every cell 5 points).
 * -- There should not be any obvious patterns to the number or positions of the points in the cells.
 * Other than that, everything is fair game. 
 */

import java.util.Random;

class Point {
  float x, y; // Should be in [0..1]
  
  // Feel free to add other per-point attributes... You'll need to initialize them in the 
  // getCell function so that they are defined by the grid cell in which this point exists.
  
  Point(float xx, float yy) {
    x = xx; y = yy;
  }
  
  void draw(int gx, int gy, float x, float y) {
    // You can augment the drawing code (to render any other attributes you defined 
    // above, for example) if you want.
    fill(255);
    noStroke();
    ellipse(x,y,4,4);
  }
}

final int GRID_SIZE = 96; // Size of grid cells in pixels
int ox = 0, oy = 0;       // Scrolling origin
int[] permute;            // Permutation array, for your convenience.
int[] poisson;            // Poisson distribution, for your use

void setup() {
  size(512,512);
  background(0);
  rectMode(CORNERS);
  ellipseMode(RADIUS);
  
  // Construct permutation array
  permute = new int[256];
  // Fisher-Yates shuffle, with in-place generation
  for(int i = 0; i < permute.length; i++) {
    int j = (int)random(0,i+1);
    
    if(j != i) 
      permute[i] = permute[j];
  }
  
  
  
  // Initialize Poisson probabilities array
  // This is the total probability that 9 or fewer events will occur. The commented-out code
  // below computes this value.
  poisson = new int[32];
  final int RATE = 5; // Avg 5 per cell
  final float totalProb = 0.9681719; 
  /*
  for(int i = 0; i <= 9; i++) {
    float p = pow(RATE,i) * exp(-RATE) / fact(i);
    totalProb += p;
  }
  println(totalProb);
  */
  int m = 0;
  for(int i = 0; i <= 9; i++) {
    float p = pow(RATE,i) * exp(-RATE) / fact(i);
    // Using round() here ensures that we fill the 32 elements of the array *exactly*.
    // Unfortunately, the probability of getting 0 events is small enough that it doesn't
    // show up in the array at all.
    int count = (int)round(poisson.length * p / totalProb);
    
    // Fill in the next count positions in the array with i
    for(int j = 0; j < count; j++)
      poisson[m + j] = i;
    
    m += count;
  }
}

long fact(int n) {
  long prod = 1;
  for(int i = 1; i <= n; i++) 
    prod *= i;
  return prod;
}

void draw() {
  background(0);
  
  // Bounding box, in grid coordinates, of the window, within the world
  int gx1 = ox / GRID_SIZE - 2;
  int gy1 = oy / GRID_SIZE - 2;
  int gx2 = (ox + width-1) / GRID_SIZE + 2;
  int gy2 = (oy + height-1) / GRID_SIZE + 2;
  
  for(int gy = gy1; gy <= gy2; gy++) 
    for(int gx = gx1; gx <= gx2; gx++) {

      drawCell(gx,gy,gx*GRID_SIZE - ox, gy*GRID_SIZE - oy);
    }
}

// Draw the cell at (gx,gy), at pixel coordinates (px,py)
void drawCell(int gx, int gy, float px, float py) {
  Point[] points = getPoints(gx,gy);
  
  // Feel free to comment out the grid lines and text if you find it distracting.
  // Doing so can help you spot unwanted patterns in the distribution.
  
  // Draw the surrounding box, and label it with the coordinates.
  stroke(64);
  noFill();
  rect(px,py,px + GRID_SIZE-1, py + GRID_SIZE-1);
  
  // Label each cell with its coordinates. 
  fill(64);
  textAlign(CENTER,CENTER);
  text(gx + "," + gy, px + GRID_SIZE/2, py + GRID_SIZE/2); 
  
  
  // Draw the points in the cell
  for(Point p : points) 
    p.draw(gx, gy, px + GRID_SIZE*p.x, py + GRID_SIZE*p.y);
}

// Scroll on mouse drag
void mouseDragged() {
  ox -= mouseX - pmouseX;
  oy -= mouseY - pmouseY;
}

// -----------------------------------------------------------------------------------
// YOUR WORK BEGINS HERE
// Your main task is to implement this function, so as to construct and return an array
// of Points[]. The size and contents of that array must be uniquely determined by (gx,gy).

Point[] getPoints(int gx, int gy) {
  
  // This is just placeholder code to make it compile. You should replace it with your own code,
  // to determine the number of points in the cell (gx,gy), construct points[] of that size,
  // and then fill it with that many Point()s, with random-but-persistent positions.

  int l = permute.length - 1;
  int index = permute[Math.floorMod((permute[Math.floorMod(gx, l)] + gy), l)];
  Random rand = new Random(index);
  
  int n = rand.nextInt();
  int count = poisson[Math.floorMod(n, 32)];
  Point[] points = new Point[count];
  
  for(int i = 0; i < count; i++){
    int x = rand.nextInt();
    int y = rand.nextInt();
    points[i] = new Point(float(Math.floorMod(x,l)) / l, float(Math.floorMod(y,l)) / l);
  }
  return points;
}