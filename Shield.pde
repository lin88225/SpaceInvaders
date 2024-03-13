public class Shield{
 public int damage;
 public float x;
 public float y;
 public int widthShield;
 public int heightShield;
 public boolean shieldDestroyed = false;
  
  Shield(float x, float y) {
    this.x = x;
    this.y = y;
    this.widthShield = 90;
    this.heightShield = 15;
    this.damage = 15;
  }
  
public void drawShield() {
  noStroke();
  if (!shieldDestroyed) {
    if (damage > 10) {
      fill(137, 255, 133);
    } else if (damage > 5) {
      fill(247, 240, 178);
    } else {
      fill(232, 88, 86);
    }
    rect(x - widthShield / 2, y, widthShield, heightShield);
  }
}

 public void takeDamage(int amount) {
    damage -= amount;
    if (damage < 0) {
      shieldDestroyed = true;
    } 
  }
}
