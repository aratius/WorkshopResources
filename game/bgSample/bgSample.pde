Bg bg;

void setup() {
  size(600, 500);
  bg = new Bg(10);
}

void draw() {
  background(255);
  bg.slideAmount = (sin((float)millis() / 1000) + 1) * .5;
  bg.update();
  bg.display();
}
