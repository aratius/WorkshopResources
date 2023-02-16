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
    // Parallax（視差）つけて動かす
    float scale = 1.2;
    float w = (float)width * scale;
    float h = (float)height * scale;
    float baseX = -(w - (float)width) / 2;  // 中心に配置するための基準となるx座標 
    float maxParallaxSize = (w - (float)width) / 2;  // 最前面の画像が動く距離
    for(int i = 0; i < imgs.length; i++) {
      float parallaxAmount = ((float)i / (float)imgs.length);  // parallaxの量(0-1)
      float x = baseX + maxParallaxSize * parallaxAmount * slideAmount;
      float y = -(h - (float)height);  // 床はfix
      image(imgs[i], x, y, w, h);
    }
  }
  
}
