Items items;

void setup() {
  size(600, 400);
  items = new Items();
}

void draw() {
  background(255);
  items.update();
  
  if(frameCount % 60 == 0) items.create();
  
  items.display();
}
