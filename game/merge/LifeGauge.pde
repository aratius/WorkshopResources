// ライフゲージ
public class LifeGauge {
  
  private float _hpMax;
  private float _hp;
  
  public LifeGauge() {
    _hp = 0; 
  }
  
  public float getHp() {
    return _hp; 
  }
  
  public void setHpMax(float hpMax) {
    _hpMax = hpMax;
  }
  
  public void addDamage(float damage) {
     _hp -= damage;
     _hp = max(min(_hp, _hpMax), 0);
  }
  
  public void resetHp() {
    _hp = _hpMax;
  }
  
  public void display() {
    float wMax = width * .4;
    float w = (_hp / _hpMax) * wMax;
    float h = 20;
    float x = width - wMax - 20;  // 20=margin-right
    float y = 20;
    noStroke();
    fill(200, 200, 200);
    rect(x, y, wMax, h);
    if(w / wMax > .3) fill(0, 255, 0);
    else fill(255, 0, 0);
    rect(x, y, w, h);
  }
  
}
