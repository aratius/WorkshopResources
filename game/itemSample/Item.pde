public class Item {
  
  PImage img;
  float x;
  float y;
  float size;
  
  public Item(String path, float _x, float _y, float _size) {
    img = loadImage(path);
    x = _x;
    y = _y;
    size = _size;
  }
 
  public void update() { 
    y+=1;  
  }
  
  public void display() {
    translate(x, y);
    rotate(y*.01);
    image(img, -size/2, -size/2, size, size);
    rotate(-y*.01);
    translate(-x, -y);
  }
  
}
