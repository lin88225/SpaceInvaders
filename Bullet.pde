public class Bullet {
  float ypos;
  float xpos;
  float xLocationOnClick;
  float speed = 2;
  int powerUpType;

  Bullet(float xPosition, int powerUpType) { 
    this.xpos = xPosition;  
    this.xLocationOnClick = xPosition;
    this.ypos = 375.0;
    this.powerUpType = powerUpType;
  }

  void moveBullet() {
    if(powerUpType == 2){
      ypos -= 2;
    } else{
      ypos -= 1;
    }
   }

  void drawBullet() {
    if(powerUpType == 2){
      image(resizedBullet2, xLocationOnClick + 25, ypos);
    } else {
      if(powerUpType == 3){
            image(resizedBullet, xLocationOnClick + 25, ypos + 20);
      } else{
    image(resizedBullet, xLocationOnClick + 25, ypos);
      }
    }
    if (mousePressed == true) {
      xLocationOnClick = mouseX;
  }
 }

  void collide(Alien alien) { // takes alien object as parameter
    float alienLeft = alien.x; // initialises to x position of alien
    float alienRight = alien.x + alien.appearance.width;
    float alienTop = alien.y;
    float alienBottom = alien.y + alien.appearance.height;

    if (xpos + resizedBullet.width / 2 > alienLeft && xpos - resizedBullet.width / 2 < alienRight &&
        ypos + resizedBullet.height / 2 > alienTop && ypos - resizedBullet.height / 2 < alienBottom) { // checks for collision
      alien.bulletExplode(); // calls bullet explosion in alien class
      println("Collision detected at x: " + xpos + ", y: " + ypos);
    }
    
     if (alien.explode && alien.powerUpDropped) { // if an alien has exploded and dropped a power up summon powerup (chance bool changes to true on explosion)
        PowerUp droppedPowerUp = alien.getDroppedPowerUp();
        powerUps.add(droppedPowerUp);
        println("PowerUp Collected!");
        
        if (droppedPowerUp.getType() == 1) { // checks for type that was decided on explosion and assigns relevent powerup effect with bool in bullet class
         powerUpType = 1;
        } else if (droppedPowerUp.getType() == 2) {
        powerUpType = 2;
    }
      }
  }
  
  void setPowerUpType(int type) {
  powerUpType = type;
}
  
void collideShield(Shield shield) {
  float bulletLeft = xpos;
  float bulletRight = xpos + resizedBullet.width;
  float bulletTop = ypos;
  float bulletBottom = ypos + resizedBullet.height;

  if (shield.x + shield.widthShield / 2 > bulletLeft && shield.x - shield.widthShield / 2 < bulletRight &&
      shield.y + shield.heightShield / 2 > bulletTop && shield.y - shield.heightShield / 2 < bulletBottom) {
    println("Your shield was hit by a bullet!");
    shield.takeDamage(2);
    bullets.remove(this);  // Remove the bullet when it hits the shield
  }
}

}
 
