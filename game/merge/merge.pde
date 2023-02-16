Player player;
Items items;
import de.looksgood.ani.*;

void setup() {
  size(600, 500);
  Ani.init(this);
  player = new Player(new CharacterInfo("hoodman", 2, 8, 8, .5, .8, .8));
  items = new Items();
}

void draw() { 
  background(255);
  
  items.update();
  if(frameCount % 60 == 0) items.create();
  player.update();
  
  for(int i = 0; i < items.getItems().length; i++) {
    Item item = items.getItems()[i];
    float dist = sqrt(pow(item.x - player.x, 2) + pow(item.y - player.y, 2));
    if(dist < (player.size + item.size) / 2) {
      player.receiveDamage();
      items.destroyByIndex(i);
    }
  }
  
  items.display();
  player.display();
}

void keyPressed() {
  if(keyCode == UP) {    
    player.jump();
  } else if(keyCode == LEFT) {
    player.run(Direction.left);
  } else if(keyCode == RIGHT) {
    player.run(Direction.right);
  }
}

void keyReleased() {
  if(keyCode == LEFT || keyCode == RIGHT) {
    player.idle();
  }
}
