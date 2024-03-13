public class Bomb{
  public float x;
  public float y;
  public boolean bombOffScreen = false;
  public boolean gameOver = false;
  public int i;
  
 Bomb(float x, float y, int i){
  this.x = x;
  this.y = y;
  this.i = i;
 }

 public void moveBomb(){
  y += 1;
 }

 public void drawBomb(){
  image(resizedBomb, x, y);
 }
 
 public boolean offScreen(){
  if(y > height){
    bombOffScreen = true;
  }
   return bombOffScreen;
  }
  
  void bombCollide(){
    float playerLeft = mouseX;
    float playerRight = mouseX + resizedPlayer.width;
    float playerTop = 350;
    float playerBottom = 350 + resizedPlayer.height;

    if (x + resizedBomb.width / 2 > playerLeft && x - resizedBomb.width / 2 < playerRight &&
        y + resizedBomb.height / 2 > playerTop && y - resizedBomb.height / 2 < playerBottom) {
      println("Player hit by bomb at x: " + x + ", y: " + y);
      gameOver();
    }
  }
  
  void gameOver(){
    gameOver = true;
  }
  
void bombCollideShield(Shield shield) {
  float bombLeft = x;
  float bombRight = x + resizedBomb.width;
  float bombTop = y;
  float bombBottom = y + resizedBomb.height;

  if (shield.x + shield.widthShield / 2 > bombLeft && shield.x - shield.widthShield / 2 < bombRight &&
      shield.y + shield.heightShield / 2 > bombTop && shield.y - shield.heightShield / 2 < bombBottom) {
    println("Your shield was hit by a bomb!");
    shield.takeDamage(2); // bombs do double damage of 
    bombOffScreen = true;  // Set bombOffScreen to true to remove the bomb
    alien[i].bombDropped = false; // sets the bombDropped bool to false for relevent index
  }
 }
}
