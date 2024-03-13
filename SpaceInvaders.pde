PImage myImage;
PImage explodingGIF;
PImage alternateAlien;
PImage resizedAltAlien;
PImage playerAppearance;
PImage resizedPlayer;
PImage bulletAppearance;
PImage resizedBullet;
PImage powerup1;
PImage resizedPowerUp1;
PImage powerup2;
PImage resizedPowerUp2;
PImage resizedBullet2;
PImage powerup3;
PImage resizedPowerUp3;
PImage bomb;
PImage resizedBomb;
Alien[] alien;
Player player;
ArrayList<Bullet> bullets;
ArrayList<PowerUp> powerUps;
ArrayList<Bomb> bombs; // bombs initialised as an arraylist
int remainingAliens = 10;
Shield shield;
Shield shield2;
Shield shield3;

void setup() {
  frameRate(60);
  size(400, 400);
  
  myImage = loadImage("invader(1).GIF");
  explodingGIF = loadImage("exploding.GIF");
  
  alternateAlien = loadImage("space invaders.png");
  resizedAltAlien = alternateAlien.copy();
  resizedAltAlien.resize(20, 20);
  
  playerAppearance = loadImage("Player.png");
  resizedPlayer = playerAppearance.copy();
  resizedPlayer.resize(50, 50);
  
  bulletAppearance = loadImage("Bullet.png");
  resizedBullet = bulletAppearance.copy();
  resizedBullet.resize(10, 10);
  resizedBullet2 = bulletAppearance.copy();
  resizedBullet2.resize(25, 25);
  
  powerup1 = loadImage("powerup1.png");
  resizedPowerUp1 = powerup1.copy();
  resizedPowerUp1.resize(30, 30);
  
  powerup2 = loadImage("powerup2.png");
  resizedPowerUp2 = powerup2.copy();
  resizedPowerUp2.resize(30, 30);
  
  powerup3 = loadImage("powerup3.png");
  resizedPowerUp3 = powerup3.copy();
  resizedPowerUp3.resize(30, 30);
  
  bomb = loadImage("bomb.png");
  resizedBomb = bomb.copy();
  resizedBomb.resize(30, 30);
  
  alien = new Alien[10];
  for (int i = 0; i < alien.length; i++) {
    if (i % 3 == 0) {
      alien[i] = new Alien(i * 39 + 20, 50, 1, 50, resizedAltAlien);
    } else {
      alien[i] = new Alien(i * 39 + 20, 50, 1, 50, myImage);
    }
  }
  
  player = new Player();
  bullets = new ArrayList<Bullet>();
  powerUps = new ArrayList<PowerUp>();
  bombs = new ArrayList<Bomb>();
  shield = new Shield(width/2, 310);
  shield2 = new Shield(width - 50, 310);
  shield3 = new Shield(50, 310);
}

void draw() {
  int powerUpType = 0;
  background(0);
  for (int i = 0; i < alien.length; i++) {
    alien[i].drawAlien(i);
    alien[i].moveAlien();
    alien[i].explode();
    
    if (alien[i].isPowerUpDropped()) {
    PowerUp droppedPowerUp = alien[i].getDroppedPowerUp();
    powerUps.add(droppedPowerUp);
    System.out.println("PowerUp Dropped!");
   }
  }
  
  player.drawPlayer();
  shield.drawShield(); // calls methods to draw shields
  shield2.drawShield();
  shield3.drawShield();
  
  ArrayList<Shield> shields = new ArrayList<>();
   shields.add(shield);
   shields.add(shield2);
   shields.add(shield3);

for (int i = shields.size() - 1; i >= 0; i--) {
  Shield currentShield = shields.get(i);
  currentShield.drawShield();

  if (currentShield.shieldDestroyed) {
    shields.remove(i);
  }
}

if (shields.size() >= 1) {
  shield = shields.get(0);
}
if (shields.size() >= 2) {
  shield2 = shields.get(1);
}
if (shields.size() >= 3) {
  shield3 = shields.get(2);
}
  
if (mousePressed == true) {
  Bullet newBullet = new Bullet(mouseX, powerUpType);
  bullets.add(newBullet);
  mousePressed = false;
}
  
  for(int i = bullets.size() -1; i>=0; i--){ // calculates the size of the array list and for each index summons a bullet
    Bullet currentBullet = bullets.get(i); // each bullet separately
    currentBullet.drawBullet();
    currentBullet.moveBullet();
    currentBullet.collideShield(shield);
    currentBullet.collideShield(shield2);
    currentBullet.collideShield(shield3);

   for (int j = 0; j < alien.length; j++)
   {
     currentBullet.collide(alien[j]);
   }
   
   if (currentBullet.ypos < 0){
     bullets.remove(i);  //removes offscreen bullets
   }
  }
  
  
  for (int i = powerUps.size() - 1; i >= 0; i--) {
  PowerUp currentPowerUp = powerUps.get(i);
  currentPowerUp.drawPowerUp();

  if (dist(mouseX, 350, currentPowerUp.x, currentPowerUp.y) < 25) {
    powerUpType = currentPowerUp.getType();
    for (Bullet bullet : bullets) {
      bullet.setPowerUpType(powerUpType);
    }
    powerUps.remove(i);
  }
}

// for loop to draw and move each summoned bomb + check for collisions with each shield
 for (int a = bombs.size() -1; a >=0; a--){
   Bomb currentBomb = bombs.get(a);
   boolean offScreen = currentBomb.offScreen();
   currentBomb.drawBomb();
   currentBomb.moveBomb();
   currentBomb.bombCollide();
   currentBomb.bombCollideShield(shield);
   currentBomb.bombCollideShield(shield2);
   currentBomb.bombCollideShield(shield3);
   
   // if offscreen variable in Bomb class instance is true remove from arraylist
   if (offScreen == true){
    bombs.remove(a);
   }
   
   if(currentBomb.gameOver == true){
    textSize(32);
    textAlign(CENTER, CENTER);
    fill(255, 255, 255);
    text("Game Over :(", width / 2, height / 2); // when bomb touches player,
                                                 //checked in loop for each bomb
    noLoop(); // taken from documentation to stop game when won
   }
  }
  
     if (remainingAliens == 0) { // when count of aliens reduced to 0 win screen displayed
    textSize(32);
    textAlign(CENTER, CENTER);
    fill(255, 255, 255);
    text("You Won :D", width / 2, height / 2);
    noLoop();
    }
}
