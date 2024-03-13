public class Alien {
  public float x;
  public float y;
  public float speed;
  public float verticalDistance;
  public boolean moveOnXAxis;
  public boolean explode;
  public PImage appearance;
  public int frameCountY;
  public int frameCountX;
  public boolean powerUpDropped;
  public int powerUpType;
  public boolean bombDropped = false;

  Alien(float x, float y, float speed, float verticalDistance, PImage appearance) {
    this.x = x;
    this.y = y;
    this.speed = speed;
    this.verticalDistance = verticalDistance;
    this.moveOnXAxis = true;
    this.explode = false;
    this.appearance = appearance;
    this.powerUpDropped = false;
    this.powerUpType = 0;
  }

  public void drawAlien(int i) {
    float random = random(0, 1000);
    if (explode) {
      image(explodingGIF, x, y);
    } else {
      image(appearance, x, y);
      if (random < 1) {
        dropBomb(i); // passes index to bomb class instance
      }
    }
  }
  
  private void dropBomb(int i) {
    if(bombDropped == false){
    Bomb newBomb = new Bomb(x + appearance.width / 2, y + appearance.height, i);
    bombs.add(newBomb);
    bombDropped = true;
    }
  }

  public void moveAlien() {
    frameCountY ++;
    frameCountX ++;
    if (frameCountX % 300 == 0){
      speed += 0.05;
    }
    if (moveOnXAxis) {
      x += speed;
      if (appearance == resizedAltAlien) {
        y += sin(x * 0.1) * 1;
      }
      if (x > width - appearance.width || x < 0 ) {
        moveOnXAxis = false;
      }
    }
    else {
      y += 1;
      if (frameCountY % 50 ==0){
        speed *= -1; 
        moveOnXAxis = true;
      }
    }
  }
  
    public void explode() {
      float random = random(0, 10000);
      if (random <= 1 && !explode){
    explode = true;
    remainingAliens--;
  } 
 }
 
  public void bulletExplode(){
  if (!explode){
   explode = true;
   remainingAliens--;
   float random2 = random(0, 4);
   if (random2 > 2) {
      int powerUpType = int(random(1, 4));
      this.powerUpDropped = true;

      PowerUp newPowerUp;
      if (powerUpType == 1) {
        newPowerUp = new PowerUp(x, y, resizedPowerUp1); // faster bullets, gives appearances
        powerUpType =1;
      } else if (powerUpType == 2) {
        newPowerUp = new PowerUp(x, y, resizedPowerUp2); // larger bullets
        powerUpType = 2;
      } else { 
        newPowerUp = new PowerUp(x, y, resizedPowerUp3); // 2x bullets per click
        powerUpType = 3;
      }

      powerUps.add(newPowerUp);
      println("PowerUp Dropped!");
   }
    }
  }
  
  public boolean isPowerUpDropped() {
    return powerUpDropped;
  }

  public void resetPowerUpDropped() {
    powerUpDropped = false;
  }
  
  public PowerUp getDroppedPowerUp() {
    this.powerUpDropped = false;
    
    int powerUpType = int(random(1, 4));
    if (powerUpType == 1) {
      return new PowerUp(x, y, resizedPowerUp1);
    } else if (powerUpType == 2) {
      return new PowerUp(x, y, resizedPowerUp2);
    } else {
      return new PowerUp(x, y, resizedPowerUp3);
    }
  }
}
