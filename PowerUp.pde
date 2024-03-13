public class PowerUp {
  float x;
  float y;
  PImage appearance;
  float speed;
  int type;

  PowerUp(float x, float y, PImage appearance) { // parameterised constructor to initialise variables on powerup summon
    this.x = x;
    this.y = y;
    this.appearance = appearance;
    this.speed = 2;
    this.type = type;
    
        if (type == 1) {
    this.appearance = resizedPowerUp1;
  } else if (type == 2) {
    this.appearance = resizedPowerUp2;
  } else if (type == 3) {
    this.appearance = resizedPowerUp3;
  }
  }
  
  void drawPowerUp() {
    y += speed;
    image(appearance, x, y);
  }
  
public int getType() {
  int type = 0;
  if (appearance == resizedPowerUp1) {
    type = 1;
  } else if (appearance == resizedPowerUp2) {
    type = 2;
  } else if (appearance == resizedPowerUp3) {
    type = 3;
  }
  return type;
}
}
