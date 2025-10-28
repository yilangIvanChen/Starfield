/* Goal: ultrakill haha funny
 
 throw coin (in the works edit: ok so its clunky on processing but not on github what the fuck)
 
 shoot coin (working on ts rn)
 
 particles when coin is shot (done, not implemented)
 
 ricochet coins
 
 */


/////////////////////////////VARIABLES///////////////////////////////////////////////////

Particle[] test = new Particle[16];
Coin[] coins = new Coin[10];
int heldTime = 0;
int storage;
boolean shoot = false;
int timer = 0;

///////////////////////////////DRAWING STUFF//////////////////////////////////////////////////


void setup() {
  background(167);
  size(1000, 600);
  for (int i = 0; i < coins.length; i++) {
    coins[i] = new Coin(50+i*100, 300);
    coins[i].rollType();
  }
  frameRate(120);
  /* 
   for (int i = 0; i < 6; i++)
   test[i] = new Split(500, 300, 2);
   for (int i = 6; i < test.length; i++)
   test[i] = new Particle(500, 300);
   */
}


void draw() {
  background(167);
  System.out.println(heldTime);
  for (int i = 0; i < coins.length; i++) {
    coins[i].fly();
    coins[i].flip();
    coins[i].show();
  }
  //System.out.println("Coin Dead Status: " + coins[0].dead+ coins[1].dead+ coins[2].dead+ coins[3].dead+ coins[4].dead);
  /*
  for (int i = 0; i < test.length; i++) {
   test[i].move();
   test[i].show();
   }
   */
  ////////////////////////mouse holding stuff
  if (keyPressed && key == ' ') {
    heldTime++;
    shoot = false;
  }
  if (heldTime > 120)
    heldTime = 120;
  if (heldTime < 0)
    heldTime = 0;
  if (shoot) {
  }
  ///////////////////mouse holding stuff (end)
}



////////////////////////////////////CLICKING STUFF////////////////////////////////////////////////


void mouseClicked() {//currently trying to make coins flip on m1 up to mouseY
  if (checkDead()) {
    int here = searchDead();
    coins[here] = new Coin(mouseX, mouseY);
    coins[here].rollType();
  }
}

void keyReleased() {
  if (key == ' ') {
    storage = heldTime;
    shoot = true;
  }
}


/////////////////////////////////////PULL UP TO THE FUNCTION GNAG//////////////////////


int searchDead() {
  for (int i = 0; i < coins.length; i++) {
    if (coins[i].dead == true)
      return i;
  }
  return -1;
}

boolean checkDead() {
  for (int i = 0; i < coins.length; i++) {
    if (coins[i].dead == true)
      return true;
  }
  return false;
}

/////////////////////////////////////CLASSES////////////////////////////////////////////////////


class Particle {
  double myX, myY, speed, direction, fadeFactor, fade;
  float size, iniSize;
  int shade;
  Particle(int x, int y) {
    myX = x;
    myY = y;
    size = (int)(Math.random()*4)+14;
    iniSize = size;
    speed = size/3;
    direction = (Math.random()*2)*PI;
    shade = (int)(Math.random()*20)+10;
    fade = 255;
    fadeFactor = size;
  }

  Particle() {}

  void move() {
    if (iniSize/5*3 >= size)
      fade -= fadeFactor;
    myX += Math.cos(direction)*speed;
    myY += Math.sin(direction)*speed;
    size -= .2;
    if (size < 0)
      size = 0 ;
  }


  void show() {
    noStroke();
    fill(255 - shade, 225 - shade, shade, (int)fade);
    ellipse((float)myX, (float)myY, size, size);
  }
}


class Split extends Particle {
  color coin;
  Split(int x, int y, int type) {
    myX = x;
    myY = y;
    size = 60;
    iniSize = size;
    speed = size/25;
    direction = (Math.random()*2)*PI;
    fade = 255;
    fadeFactor = 10;
    if (type == 0)
      coin = #D88E48;
    if (type == 1)
      coin = #DFEFF0;
    if (type == 2)
      coin = #F0E085;
  }
  void move() {
    myX += Math.cos(direction)*speed;
    myY += Math.sin(direction)*speed;
    size -= 1;
    if (size < 0)
      size = 0 ;
  }


  void show() {
    noStroke();
    fill(coin);
    ellipse((float)myX, (float)myY, size, size);
  }
}///////end of particle class


class Coin {
  int myX, myY, type, tadth, maxHeight;
  double time;
  boolean dead;
  color coin;
  Coin(int x, int max) {
    myX = x;
    myY = 610;
    maxHeight = max;
    time = 0;
    dead = false;
  }

  void rollType() {
    double z = Math.random();
    if (z <= .1)
      type = 2;
    else if (z <= .55)
      type = 1;
    else if (z <= 1)
      type = 0;
  }

  void flip() {
    time++;
    tadth =(int)(40*Math.cos(time/5));
    if (tadth >= 0) {
      if (type == 0) {
        coin = #D88E48;
      }
      if (type == 1) {
        coin = #DFEFF0;
      }
      if (type == 2) {
        coin = #F0E085;
      }
    }

    if (tadth < 0) {
      if (type == 0) {
        coin = #A5652D;
      }
      if (type == 1) {
        coin = #D3D3D3;
      }
      if (type == 2) {
        coin = #DBC64D;
      }
    }
  }

  void fly() {
    myY = (int)(.04*(time*time-240*time)+580+maxHeight);
    if (myY > 610)
      dead = true;
    else
      dead = false;
  }
  void show() {
    stroke(2);
    fill(coin);
    ellipse(myX, myY, 40, tadth);
  }
}////end of coin class
