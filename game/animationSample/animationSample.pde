Player player;

void setup() {
  size(600, 400);
   player = new Player(new CharacterInfo("hoodman", 2, 8, 8, .5, .8, .8));
  //player = new Player(new CharacterInfo("simple", 10, 8, 3, 1, .8, .8));
}

void draw() { 
  background(255);
  player.update();
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
