public class Bg {
 
  public float slideAmount;  // 0 ~ 1
  
  private PImage[] imgs;
  
  public Bg(int imgLen) {
    imgs = new PImage[imgLen];
    for(int i = 0; i < imgs.length; i++) {
      imgs[i] = loadImage("bg-" + i + ".png"); 
    }
    slideAmount = 0.5;
  }
  
  public void update() {
    slideAmount = (sin((float)millis() / 1000) + 1) * .5;    
  }
  
  public void display() {
    float scale = 1.2;
    float w = (float)width * scale;
    float h = (float)height * scale;
    for(int i = 0; i < imgs.length; i++) {
      float x = -(w - (float)width) / 2 + slideAmount * (w - (float)width) / 2 * ((float)i / (float)imgs.length) ;
      float y = -(h - (float)height);  // 床はfix
      image(imgs[i], x, y, w, h);
    }
  }
  
}
