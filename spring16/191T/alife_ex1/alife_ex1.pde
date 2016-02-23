/* Author: Brandon Lundberg

The modifications made to the program are as follows:
1. A police type was added to arrest predators
2. The police and predators grow as they arrest/kill
3. Police can only arrest predators that have killed less than or equal to the number of predators the police has arrested
4. After a certain number of arrests, the police become corrupt and turn into predators
5. Only prey are spawned automatically in the main program
6. Predators do not die and spawn new prey. Instead, predators spawn more predators if they kill enough prey

Somehow, all of my police get deleted at a certain time. I cannot quite figure out why, but enjoy the game!


/* 
 * alife_ex1
 * A simple artificial life simulation, where predators are "attracted" (experience an attractive force) to their
 * prey. Your task is to create some interesting artificial life simulation. 
 */

import java.util.Iterator;
import java.util.LinkedList;

// The time at which the current frame started.
long start_time = -1;
long elapsed_time = 16666667;

/* -----------------------------------------------------------------------------------------------------------------

 * Walls
 * Where are creatures not allowed to go?
 */
class Wall {
  int x1,y1,x2,y2;
  boolean empty = false; // Does the wall occupy no space?
  
  
  Wall(int cx1, int cy1, int cx2, int cy2) {
    x1 = cx1; y1 = cy1; x2 = cx2; y2 = cy2;
    fixup();
  }
  
  // Swap coordinates so that the x1/y1 is always <= x2/y2.
  void fixup() {
    if(x1 > x2) {
      int t = x1;
      x1 = x2; 
      x2 = t;
    }
    if(y1 > y2) {
      int t = y2;
      y1 = y2;
      y2 = t;
    }
    if(x1 == x2 || y1 == y2)
      empty = true;
  }
  
  // Draw the current wall
  void draw() {
    if(!empty) {
      noStroke();
      noFill();
      rect(x1,y1,x2,y2);
    }
  }   
}

 class Jail {
  int x1,y1,x2,y2;
  boolean empty = false; // Does the wall occupy no space?
  
  Jail(int cx1, int cy1, int cx2, int cy2) {
    x1 = cx1; y1 = cy1; x2 = cx2; y2 = cy2;
  }
  
    void draw() {
        fill(0,0,255);
        rect(x1,y1,x2,y2);
    } 
  
}

/* -----------------------------------------------------------------------------------------------------------------
 * Entity management
 * Keeping track of all the creatures in the world
 */
LinkedList<Creature> creatures;
LinkedList<Creature> new_creatures;

// Spawn a new creature (i.e., add it to the list of new objects)
void spawn(Creature o) {
  if(creatures.size() < MAX_CREATURES)
    new_creatures.add(o);
}

/* -----------------------------------------------------------------------------------------------------------------
 * Event handlers
 * setup(), draw(), and so forth.
 */

void setup() {
  size(768,512);
  background(BACKGROUND);
  noStroke();
  ellipseMode(RADIUS);
  
  creatures = new LinkedList<Creature>();
  new_creatures = new LinkedList<Creature>();
  
  Police p = new Police();
  creatures.add(p);
  
  // Add some random creatures
  for(int i = 0; i < 100; i++) 
    creatures.add(randomCreature());
   
  // Add the implicit window border walls
  Wall[] newWalls = new Wall[walls.length + 5];
  for(int i = 0; i < walls.length; i++)
    newWalls[i] = walls[i];
  
  newWalls[walls.length+0] = new Wall(-50,-50,-1,height+50);         // Left
  newWalls[walls.length+1] = new Wall(width,-50,width+50,height+50); // Right
  newWalls[walls.length+2] = new Wall(-50,-50,width+50,-1);          // Top
  newWalls[walls.length+3] = new Wall(-50,height,width+50,height+50);// Bottom
  newWalls[walls.length+4] = new Wall(0,0,110,110); // Jail
  
  walls = newWalls; // Replace original walls.
  jail = new Jail(10, 10, 90, 90);
  nextSpawn = SPAWN_FREQUENCY;
  
  mySeed = 12;
}

float timeSinceSpawn = 0;
float nextSpawn;

void draw() {
  background(BACKGROUND);
  
  // Update all the objects, physically, based on the timestep from the previous frame.
  timeSinceSpawn += elapsed_time / 1000000.0;
  int ccount = 0;
  for(Creature o : creatures) {
    o.simulate(elapsed_time / 1000000.0);
    ccount++;
  }
  
  // Check for creature-creatue collisions
  for(Creature a : creatures) {
    for(Creature b : creatures) {
      if(a != b && dist2(a.x,a.y,b.x,b.y) < sq(a.radius + b.radius))
        collide(a,b);
    }
  }
  
  // If there is room for additional creatures, maybe spawn one. This will be a new_creature,
  // so it won't be simulated or drawn yet.
  if(ccount + new_creatures.size() < MAX_CREATURES && timeSinceSpawn >= nextSpawn) {
    timeSinceSpawn -= nextSpawn;
    nextSpawn = random(0,2 * SPAWN_FREQUENCY);
    spawn(newPrey());
  }
  
  //rectMode(CENTER);
  

  // Add Jail cell
  jail.draw();
  
  // Draw all walls
  for(Wall w : walls)
    w.draw();
  
  // Draw all the objects in their new positions (all one of them)
  for(Creature o : creatures) {
    o.draw();
  }
  
  // Purge any dead objects.
  for(Iterator<Creature> i = creatures.iterator(); i.hasNext(); ) {
    if(!i.next().alive)
      //i.remove();
  }
  
  // Add new objects, and clear the new_entities list for the next frame
  creatures.addAll(new_creatures);
  new_creatures.clear();
  
  // Compute the duration of this frame, for use in the next.
  if(start_time >= 0) 
    elapsed_time = System.nanoTime() - start_time;
    
  start_time = System.nanoTime();
}

// Use the relative spawn probabilities of the creatures to choose one to spawn
int chooseCreatureType() {
  float probTotal = 0;
  for(int i = 0; i < spawnFreq.length; i++)
    probTotal += spawnFreq[i];
    
  float c = random(0,probTotal);
  
  float cp = 0;
  int i = -1;
  while(cp < c && i < spawnFreq.length) 
    cp += spawnFreq[++i];

  return i;
}

Creature newPrey() {
  Creature c = creatureByType(0);
  
  c.x = 0; 
  c.y = 0; 
  float v = c.maxVelocity / 3;
  c.vx = random(-v,+v) + random(-v,+v) + random(-v,+v); // Approximate Gaussian
  c.vy = random(-v,+v) + random(-v,+v) + random(-v,+v);  
  
  // Find a random location not overlapping any walls
  boolean overlaps;
  do {
    c.x = random(16,width-16); c.y = random(16,height-16);
    
    overlaps = false; 
    for(Wall w : walls) 
      if(intersects(w.x1,w.y1,w.x2,w.y2,(int)(c.x-c.radius),(int)(c.y-c.radius),(int)(c.x+c.radius),(int)(c.y+c.radius))) {
        overlaps = true;
        break;
      }
  } while(overlaps);
  
  return c;
}

// Create a new random creature, using the probabilities, and giving it a random
// position and velocity.
Creature randomCreature() {
  Creature c = randomCreature(0, 0);
  
  // Find a random location not overlapping any walls
  boolean overlaps;
  do {
    c.x = random(16,width-16); c.y = random(16,height-16);
    
    overlaps = false; 
    for(Wall w : walls) 
      if(intersects(w.x1,w.y1,w.x2,w.y2,(int)(c.x-c.radius),(int)(c.y-c.radius),(int)(c.x+c.radius),(int)(c.y+c.radius))) {
        overlaps = true;
        break;
      }
  } while(overlaps);
  
  return c;
}

Creature randomCreature(float x, float y) {
  Creature c = creatureByType(chooseCreatureType());
  c.x = x; 
  c.y = y; 
  float v = c.maxVelocity / 3;
  c.vx = random(-v,+v) + random(-v,+v) + random(-v,+v); // Approximate Gaussian
  c.vy = random(-v,+v) + random(-v,+v) + random(-v,+v);  
    
  return c;
}

// Adjust velocity when colliding with the walls
void collide(Creature c, float dt) {
  if(c.x + c.vx*dt - c.radius < 100 && c.y + c.vy*dt - c.radius < 100)
  {
    if(c.x < c.y)
      c.vy = abs(c.vy);
    else
      c.vx = abs(c.vx);
  }
  if(c.x + c.vx*dt - c.radius < 0)
    c.vx = abs(c.vx);
  if(c.y + c.vy*dt - c.radius < 0)
    c.vy = abs(c.vy);
  if(c.x + c.vx*dt + c.radius > width)
    c.vx = -abs(c.vx);
  if(c.y + c.vy*dt + c.radius > height)
    c.vy = -abs(c.vy);
}

// Distance squared. Use when possible.
float dist2(float x1, float y1, float x2, float y2) {
  return sq(x1-x2) + sq(y1-y2);
}

// Do two bounding boxes intersect? Note that this assumes both boxes coordinates are sorted.
boolean intersects(int ax1, int ay1, int ax2, int ay2, int bx1, int by1, int bx2, int by2) {
  return ax2 >= bx1 && bx2 >= ax1 &&
         ay2 >= by1 && by2 >= ay1;
}

// Is box A inside box B?
boolean inside(int ax1, int ay1, int ax2, int ay2, int bx1, int by1, int bx2, int by2) {
  return ax1 >= bx1 && ax2 <= bx2 && ay1 >= by1 && ay2 <= by2;
}

/* ----------------------------------------------------------------------------------------------------
/* Faster random numbers
 * random() can be very slow, so here's a faster (albeit integer-only) random number generator. Note
 * that using %, as we do here, to limit the range introduces bias.
 * This RNG is based on
 *   Klimov, Alexander, and Adi Shamir. "A new class of invertible mappings." 
 *   Cryptographic Hardware and Embedded Systems-CHES 2002. Springer Berlin 
 *   Heidelberg, 2003. 470-483.
 */

long mySeed;

int irandom(int low, int high) {
  return (irandom() % (high - low)) + low;
}
 
int irandom() {
  mySeed += (mySeed * mySeed) | 5;
  return (int)(mySeed >>> 32 < 0 ? -(mySeed >>> 32) : mySeed >>> 32);
}