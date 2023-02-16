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
    float seed = random(0.0, 1.0);
    int index = seed < .8 ? 0 : seed < .9 ? 1 : 2;
    String name = "item-" + index + ".png";
    float ability = new float[]{1.0, -2.0, -1.0}[index];
    Item item = new Item(name, x, y, size, ability);
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
