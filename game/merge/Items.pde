public class Items {
 
  private Item[] _items = {};
  
  public Items() {
    
  }
  
  public Item[] getItems() {
    return _items; 
  }
  
  public void create() {
    float size = 64;
    float x = random(width);
    float y = -size/2;
    String name = "item-" + (int)random(3) + ".png";
    Item item = new Item(name, x, y, size);
    _items = (Item[])append(_items, item);
  }
  
  public void destroyByIndex(int _i) {
    Item[] newItems = {};
    for(int i = 0; i < _items.length; i++) {
      if(i != _i) newItems = (Item[])append(newItems, _items[i]);
    }
    _items = newItems;
  }
  
  public void update() {
    for(int i = 0; i < _items.length; i++) {
      _items[i].update(); 
    }
  }
  
  public void display() {
    for(int i = 0; i < _items.length; i++) {
      _items[i].display(); 
    }
  }
  
}
