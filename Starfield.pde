/* Goal: ultrakill haha funny

impact frames are killing me if i'll figure it out tmrw if i feel like it
 
 */


/////////////////////////////VARIABLES///////////////////////////////////////////////////

Particle[][] bang = new Particle[10][12];
int[][] help = new int[10][3];
Coin[] coins = new Coin[10];
boolean shoot = false;
boolean huh = false;
int timer = 0;

///////////////////////////////DRAWING STUFF//////////////////////////////////////////////////


void setup() {
  background(167);
  size(1000, 600);
  for (int i = 0; i < coins.length; i++) {
    coins[i] = new Coin(2000, 1200);
    coins[i].rollType();
  }
  for (int i = 0; i < coins.length; i++) {
    for (int j = 0; j < bang[i].length; j++)
      bang[i][j] = new Particle(coins[i].myX, coins[i].myY);
  }
  frameRate(120);
}


void draw() {
  background(167);
  /*
  if (shoot) {///////////////this cutscene bs is gonna be hell to code
   ////////////////////////impact frames
   for (int i = 0; i < coins.length; i++) {
   if (!coins[i].dead) {
   help[i][0] = coins[i].myX;
   help[i][1] = coins[i].myY;
   help[i][2] = coins[i].tadth;
   } else {
   help[i][0] = -1;
   }
   }
   huh = true;
   }
   if (huh) {
   shoot = false;
   while (timer <= 1920) {
   fill(0);
   rect(0, 0, 1000, 600);
   for (int i = 0; i < help.length; i++) {
   if (!(help[i][0] == -1)) {
   fill(255);
   ellipse(help[i][0], help[i][1], 40, help[i][2]);
   }
   }
   timer++;
   }
   timer = 0;
   huh = false;
   }
   */
  for (int i = 0; i < coins.length; i++) {////////coin stuff
    coins[i].fly();
    coins[i].flip();
    coins[i].show();
  }

  if (!huh) {
    for (int i = 0; i < bang.length; i++) {//////particle stuff
      for (int j = 0; j < bang[i].length; j++) {
        bang[i][j].move();
        bang[i][j].show();
      }
    }
  }
}


////////////////////////////////////CLICKING STUFF////////////////////////////////////////////////


void mouseClicked() {
  for (int i = 0; i < coins.length; i++) {
    if (coins[i].dead) {
      coins[i] = new Coin(mouseX, mouseY);
      coins[i].rollType();
      break;
    }
  }
}

void keyReleased() {
  if (key == ' ') {
    for (int i = 0; i < coins.length; i++) {
      if (!coins[i].dead) {
        for (int j = 0; j < 3; j++)
          bang[i][j] = new Split(coins[i].myX, coins[i].myY, coins[i].type);
        for (int j = 6; j < bang[i].length; j++)
          bang[i][j] = new Particle(coins[i].myX, coins[i].myY);
      } else {
        for (int j = 0; j < bang[i].length; j++)
          bang[i][j] = new Split(2000, 1200, 0);
      }
    }
    shoot = true;
    for (int i = 0; i < coins.length; i++)
      coins[i] = new Coin(2000, 1200);
  }
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

  Particle() {
  }

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
      coin = #F0F0F0;
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
        coin = #F0F0F0;
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
    myY = (int)(.04*(time-120)*(time-120)+maxHeight);
    if (myY > 576+maxHeight)
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
