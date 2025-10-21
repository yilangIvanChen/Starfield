/* Goal: ultrakill haha funny
 default is holding handcannon
 hand coin toss animation (maybe)
 
 **the anim stuff may or may not do, low priority
 
 -trigger on [spacebar]
 -bring handcannon down first
 
 throw coin
 -coin flips and shit as it flies in the air (circular coin btw)
 -coin gets smaller as it gets further
 
 shoot coin
 -trigger on m1
 -charging shot based on time held
 
 particles when coin is shot
 -trails
 -outlier: yellow line from coin to ground
 */


/////////////////////////////VARIABLES GO HERE (probably)/////////////////////////////////////



///////////////////////////////DRAWING STUFF//////////////////////////////////////////////////


void setup() {
}


void draw() {
}


/////////////////////////////////////CLASSES ARE HERE///////////////////////////////////////////////


class Particle {
  double myX, myY, speed, direction, fadeFactor, fade;
  float size;
  int shade;
  Particle(int x, int y) {
    myX = x;
    myY = y;
    size = (int)(Math.random()*11)+10;
    speed = size*(int)(Math.random()+3);
    direction = (Math.random()*2)*PI;
    shade = (int)(Math.random()*80)+175;
    fade = 255;
    fadeFactor = size*.5;
  }

  void move() {
    myX += Math.cos(direction)*speed;
    myY += Math.sin(direction)*speed;
    fade -= fadeFactor;
  }

  void show() {
    noStroke();
    fill(shade,150,150,(int)fade);
    ellipse(10,10,size,size);
  }
}

/*
class Oddball extends Particle{
 Oddball(){
 
 }
 }
 class Coin
 */
