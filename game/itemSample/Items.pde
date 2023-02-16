public class Items {
 
  private Item[] items = {};
  
  public Items() {
    
  }
  
  public void create() {
    float size = 64;
    float x = random(width);
    float y = -size/2;
    String name = "item-" + (int)random(3) + ".png";
    Item item = new Item(name, x, y, size);
    items = (Item[])append(items, item);
  }
  
  public void update() {
    for(int i = 0; i < items.length; i++) {
      items[i].update(); 
    }
  }
  
  public void display() {
    for(int i = 0; i < items.length; i++) {
      items[i].display(); 
    }
  }
  
}
