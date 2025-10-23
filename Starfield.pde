/* Goal: ultrakill haha funny
 -trigger on [spacebar]
 
 throw coin
 -coin flips and shit as it flies in the air (circular coin btw)
 -coin gets smaller as it gets further
 
 shoot coin
 -trigger on m1
 -charging shot based on time held
 
 particles when coin is shot
 -trails
 -outlier: yellow line from coin to ground
 
 ricochet coins
 */


/////////////////////////////VARIABLES GO HERE (probably)/////////////////////////////////////

Particle poopyfart = new Particle(250, 250);

///////////////////////////////DRAWING STUFF//////////////////////////////////////////////////


void setup() {
  background(167);
  size(500, 500);
  frameRate(120);
}


void draw() {
  background(167);
  poopyfart.move();
  poopyfart.show();
}


/////////////////////////////////////CLASSES ARE HERE///////////////////////////////////////////////


class Particle {
  double myX, myY, speed, direction, fadeFactor, fade;
  float size, iniSize;
  int shade;
  Particle(int x, int y) {
    myX = x;
    myY = y;
    size = (int)(Math.random()*20)+12;
    iniSize = size;
    speed = pow((int)(Math.random()+3),(size));
    direction = (Math.random()*2)*PI;
    shade = (int)(Math.random()*80)+175;
    fade = 255;
    fadeFactor = size;
  }

  void move() {
    if (iniSize/3*2 <= size){
    myX += Math.cos(direction)*speed;
    myY += Math.sin(direction)*speed;
    }
    if (iniSize/3*2 > size)
      fade -= fadeFactor;
    size -= .2;
    if (size < 0)
      size = 0 ;
  }

  void show() {
    noStroke();
    fill(shade, 60, 60, (int)fade);
    ellipse((float)myX, (float)myY, size, size);
  }
}

/*
class Oddball extends Particle{
 Oddball(){
 
 }
 }
 class Coin
 */
