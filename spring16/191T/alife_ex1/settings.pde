/*
 * settings
 * Various global constants that you may need to modify.
 */
 
// Background color
final color BACKGROUND = #777777;

// Average ms between new creature spawns
final int SPAWN_FREQUENCY = 500; 

// How many creatures in total can exists (approx)? Feel free to set this as high as you computer can 
// handle, but note that, unfortunately, this value does have an effect on the simulation (as calls
// to spawn() will be ignored if there are already MAX_CREATURES in existence), so it's not just a 
// performance-modifying value.
final int MAX_CREATURES = 300; 


// Array of walls. Note that the system will add the four walls surrounding the window to this.
// You can construct walls with
//   new Wall(x1,y1.x2,y2);
// "Empty" walls (with x1==x2 or y1==y2) will not be drawn or interacted with.
Jail jail;
Wall[] walls = {
  
};