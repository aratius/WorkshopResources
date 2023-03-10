import de.looksgood.ani.*;

Player player;
LifeGauge lifeGauge;
Items items;
PImage bg;

AniSequence wiggleScreenSeq = new AniSequence(this);
float wiggleX = 0;
float wiggleY = 0;

void setup() {
  size(600, 500);
  Ani.init(this);
  player = new Player(new CharacterInfo("hoodman", 2, 8, 8, .5, .8, .8));
  lifeGauge = new LifeGauge();
  items = new Items();
  bg = loadImage("bg.png");
  
  lifeGauge.setHpMax(10.0);
  lifeGauge.resetHp();
  
  wiggleScreenSeq.beginSequence();
  final int animCnt = 10;
  for(int i = 0; i < animCnt; i++) {
    wiggleScreenSeq.beginStep();
    float dur = .04;
    float power = ((float)animCnt - (float)i) / (float)animCnt * .3;
    wiggleScreenSeq.add(Ani.to(this, dur, "wiggleX", random(-10.0, 10.0) * power, Ani.LINEAR));
    wiggleScreenSeq.add(Ani.to(this, dur, "wiggleY", random(-10.0, 10.0) * power, Ani.LINEAR));
    wiggleScreenSeq.endStep();
  }
  wiggleScreenSeq.endSequence();
}

void draw() { 
  background(255);
  
  items.update();
  if(frameCount % 60 == 0) items.create();
  player.update();
  
  
  for(int i = 0; i < items.getItems().length; i++) {
    Item item = items.getItems()[i];
    
    // 落ち切ったら消す
    if(item.y > height + item.size/2) items.destroyByIndex(i);
    
    // ItemとPlayerの衝突判定
    // 衝突したらPlayerにダメージ与え、Itemは消す
    float dist = sqrt(pow(item.x - player.x, 2) + pow(item.y - player.y, 2));
    if(dist < (player.size + item.size) / 2 * .7) {  // 割と適当な値
      player.onIntersect(item.damage);
      items.destroyByIndex(i);
      lifeGauge.addDamage(item.damage);
      if(item.damage > 0) wiggleScreenSeq.start();
    }
  }
  
  translate(wiggleX, wiggleY);
  image(bg, -10, -10, width + 20, height + 20);
  items.display();
  player.display();
  translate(-wiggleX, -wiggleY);
  lifeGauge.display();
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
