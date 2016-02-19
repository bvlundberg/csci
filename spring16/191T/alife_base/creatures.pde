/*
 * creatures
 * Base Creature class and any subclasses you care to add. In this file, the functions/methods you will need 
 * to modify are:
     Creature.accelerate -- determines how creatures react to each other, in terms of attraction/repulsion.
     Creature.pursue, Creature.flee -- determines the force(s) applied when a creature pursues or flees from
                                       another creature. 
     Note that you may change these in Creature, or subclass Creature and change them in your subclasses. E.g.,
     you can use the same attractive/repulsive forces for all creatures, or change them per subclass (or even
     based on the target creature)
     
     CREATURE_TYPES -- Change this to the number of creature types that exist in your system. The simulation
                       will sometimes randomly spawn a creature of random type, and needs to know how many 
                       such types there are.
                       
     collide(a,b) -- Handles creature-creature collision. You will need to edit this to specify what happens
                     when each pair of creature types collides with each other (e.g., a predator might kill
                     a prey creature on collision).
                     
     creatureByType(t) -- factory function that creates and returns a Creature by its type-index. You will 
                          need to update this as you add additional types of creatures.
 */

// Change this to reflect how many types of creatures you've created (that you want the system to automatically spawn).
final int CREATURE_TYPES = 0;

// --------------------------------------------------------
// Creature spawning probabilities
float[] spawnFreq = {

};

// --------------------------------------------------------
// Creature-creature collision.
// This function is called whenever two creatures collide.
// You will need to fill it in to determine what happens when two creatures collide, for each
// possible pair of creature-types that you care about.
void collide(Creature a, Creature b) {
  // The collide loop tests every pair of creatures against each other, so the effects of a 
  // predator A and prey B will be handled automatically, you don't need to test for it. 
}

// ---------------------------------------------------------
// Create a new creature by type. 
// You will have to modify this as you add creature subclasses. If you want to create a creature-type
// that is never spawned by the system, just don't add it to this function. (You'll probably still want
// to give it a unique type value, however.)
Creature creatureByType(int t) {
  switch(t) {

    default: return null;
  }
}


/* --------------------------------------------------------------------------------------------------------------------
 * Creature
 * Base class for moving, living things
 */
class Creature {
  int type = -1; // Should be set in the constructor to a distinct value for each subclass.
  
  boolean alive = true;
  
  // Display attributes
  int radius = 4; 
  color c = #dddddd; // Light gray. Each type should have a different color
  
  float maxVelocity = 0.1; // px/ms 
  
  float x,y;   // Position
  float vx,vy; // Velocity
  float ax,ay; // Acceleration
  
  void simulate(float dt) {
    x += vx * dt;
    y += vy * dt;
    
    vx += ax * dt;
    vy += ay * dt;
    
    // Limit max velocity
    float l2 = sq(vx) + sq(vy);
    if(l2 > maxVelocity*maxVelocity) {
      l2 = sqrt(l2);
      vx *= maxVelocity / l2;
      vy *= maxVelocity / l2;
    }
    
    // Collide with the edges of the screen
    collide(this, dt);
    
    // Compute acceleration from scratch.
    ax = ay = 0;
    
    accelerate(dt);
  }
  
  // Draw the object
  void draw() {
    fill(c);
    noStroke();
    ellipse(x,y,radius,radius);
  }
    
  boolean kill() {
    alive = false;
    return !alive;
  }
  
  
  void accelerate(float dt) {
    /*
    for(Creature o : creatures) {
      if(o != this) {
        // react to o
      }
    } 
    */
  }
  
  // Add a force to ax,ay to pursue (be attracted to) the target creature
  void pursue(Creature target, float strength) {
    flee(target,-strength);   
  }
  
  // Add a force to ax,ay to flee (be repelled by) the target creature
  void flee(Creature target, float strength) {
    
    // Find the vector pointing away from the target, and normalize it.
    float dx = x - target.x;
    float dy = y - target.y;
    float l = dist2(0,0,dx,dy);
    if(l != 0) {
      l = sqrt(l);
      dx /= l;
      dy /= l;
    }
    
    ax += dx * strength / l;
    ay += dy * strength / l;
  }
}