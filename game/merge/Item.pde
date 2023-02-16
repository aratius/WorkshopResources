public class Item {
  
  public float x;
  public float y;
  public float size;
  public float damage;  // 0以下なら回復
  private PImage _img;
  private float _speed;
  
  public Item(String path, float _x, float _y, float _size, float _damage) {
    x = _x;
    y = _y;
    size = _size;
    damage = _damage;
    _img = loadImage(path);
    _speed = random(.8, 1.5);
  }
 
  public void update() { 
    y+=_speed;  
  }
  
  public void display() {
    translate(x, y);
    rotate(y*.01);
    image(_img, -size/2, -size/2, size, size);
    rotate(-y*.01);
    translate(-x, -y);
  }
  
}
