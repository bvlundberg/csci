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
final int CREATURE_TYPES = 2;

// --------------------------------------------------------
// Creature spawning probabilities
float[] spawnFreq = {
  3,  // Prey
  1,  // Predator
};

// --------------------------------------------------------
// Creature-creature collision.
// This function is called whenever two creatures collide.
// You will need to fill it in to determine what happens when two creatures collide, for each
// possible pair of creature-types that you care about.
void collide(Creature a, Creature b) {
  if(a.type == PREY && b.type == PREDATOR) {
    Predator p = (Predator)b;
    if(a.kill())
      p.killed++;
      p.grown = true;
  }
  if(a.type == POLICE && b.type == PREDATOR) {
     Police police = (Police)a;
     Predator predator = (Predator)b;
     if(police.arresting || predator.arrested){
       return;
     }
     else
     {
       if(police.arrested >= predator.killed)
       {
         police.arresting = true;
         predator.arrested = true;
       }
     }

  }
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
    case PREY: return new Prey();
    case PREDATOR: return new Predator();
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
  float radius = 4; 
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

final int PREY = 0;
class Prey extends Creature {
  // Prey can be invlunerable for a short time at the beginning of their lives.
  float invul = 0;
  
  Prey() {
    type = PREY;
    c = #dddddd;
    maxVelocity = 0.1; // Slightly slower than normal
  }
  
  void simulate(float dt) {
    super.simulate(dt);
    
    invul = max(invul - dt, 0);
  }
  
  boolean kill() {
    if(invul > 0)
      return false;
    else {
      alive = false;
      return !alive;
    }
  }   
  
  void accelerate(float dt) {
    
    for(Creature o : creatures) {
      if(o != this) {
        if(o.type == PREY) 
          continue; // ignore
        else if(dist2(x,y,o.x,o.y) < 64*64)
          flee(o,0.1); // Strong repulsion
      }
    } 
    
  }
}

final int PREDATOR = 1;
class Predator extends Creature {
  
  float health = 5000;
  boolean arrested = false;
  int killed = 0;
  boolean grown = false;
  Predator() {
    type = PREDATOR;
    c = #bb2222;
    maxVelocity = 0.4; // Faster
    health = 7000; // Add some variation to lifespan
  }  
  
  void simulate(float dt) {
    super.simulate(dt);
    if(arrested){
        bearrested(0, 0, .001);
        return;
    }
    if(grown && killed < 10)
    {
       radius = 4 * pow(1.1, killed);
       grown = false;
    }
    health -= dt;      
    if(killed > 10)
    {
      for(int i = 0; i < 2; i++)
      {
        Predator c = new Predator(); 
        c.x = x;
        c.y = y;
        c.vx = -vx;
        c.vy = -vy;
        spawn(c);
      }
      kill();
    }
    // Give birth to a child?
    else if(health > 7000) {        
      Predator c = new Predator(); 
      c.x = x;
      c.y = y;
      c.vx = -vx;
      c.vy = -vy;
      spawn(c);
    }
  }
  
  void accelerate(float dt) {    
    for(Creature o : creatures) {
      if(o != this) {
        if(o.type == PREY)          
          pursue(o,0.1); // Strong attraction
        else
          if(dist2(x,y,o.x,o.y) < 16*16) 
            flee(o,0.01); // Slight repulsion, if too close
      }
    }    
  }
  void bearrested(int xTarget, int yTarget, float strength) {
    
    // Find the vector pointing away from the target, and normalize it.
    float dx = x - xTarget;
    float dy = y - yTarget;
    if(x < 110 && y < 110) {
      arrested = false;
      kill();
      return;
    }
    vx = dx * -.001;
    vy = dy * -.001;
  }
}

final int POLICE = 2;
class Police extends Creature {
 
  boolean arresting = false;
  boolean spawned = false;
  int arrested = 0;
  Police() {
    type = POLICE;
    c = #0000FF;
    maxVelocity = 0.4; // Faster
  }  
  
  void simulate(float dt) 
  {
    super.simulate(dt);
    if(arrested % 5 == 0 && arrested > 0 && spawned == false)
    {
      Police p = new Police();
      p.x = x;
      p.y = y;
      p.vx = vx + random(-0.1,0.1);
      p.vy = vy + random(-0.1,0.1);
      spawn(p);
      spawned = true;
    }
    else if(arrested % 5 != 0)
    {
      spawned = false;
    }
    if(arrested > 10) {    
      Predator c = new Predator(); 
      c.x = x;
      c.y = y;
      c.vx = vx;
      c.vy = vy;
      c.radius = 4;
      c.killed = 0;
      c.health = 7000;
      spawn(c);
      kill();
    }
  }
  
  void accelerate(float dt) {
    if(arresting){
        makearrest(0, 0, .001);
        return;
    }
    for(Creature o : creatures) {
      if(o != this) {
        if(o.type == PREDATOR && !((Predator)o).arrested && arrested >= ((Predator)o).killed) 
          pursue(o,0.2); // Strong attraction
        else
          if(dist2(x,y,o.x,o.y) < 16*16) 
            flee(o,0.01); // Slight repulsion, if too close
      }
    }    
  }
  
    // Add a force to ax,ay to flee (be repelled by) the target creature
  void makearrest(int xTarget, int yTarget, float strength) {
    
    // Find the vector pointing away from the target, and normalize it.
    float dx = x - xTarget;
    float dy = y - yTarget;
    if(x < 110 && y < 110) {
      arresting = false;
      arrested++;
      print(arrested, " ");
      if (arrested < 10)
        radius *= 1.1;
      return;
    }
    vx = dx * -.001;
    vy = dy * -.001;
  }
}
  