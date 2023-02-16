import java.util.Map;
import java.util.HashMap;

public enum State {
 idle,
 run,
 jump 
}

public enum Direction {
 left,
 right
}

public class Player {
  
  // public members
  public State state;
  public Direction direction;
  public float x;
  public float y;
  public float size;
  
  // private members
  private CharacterInfo _characterInfo;
  private PImage[] _idleImages;
  private PImage[] _runImages;
  private PImage[] _jumpImages;
  private State _stateAfterJump;
  private float _animStartedTime;
  private boolean _hasJumped;
  
  // constructor
  public Player(CharacterInfo __characterInfo) {
    _characterInfo = __characterInfo;
    state = State.idle;
    size = 128;
    x = width/2;
    y = _getBaseY();
    direction = Direction.right;
    _animStartedTime = _getAnimTime();
    _hasJumped = false;
  }
  
  // 現在のstateのPImage配列を取得
  private PImage[] _getImages() {
    return _characterInfo.imageMap.get(state);
  }
  
  // 現在のstateのanimationSpeedを取得
  private float _getAnimationSpeed() {
    return _characterInfo.animSpeedMap.get(state);
  }
  
  // 時間を取得
  private float _getAnimTime() {
    return getTime() * _getAnimationSpeed();
  }
  
  private int _getAnimIndex() {
    float t = _getAnimTime() - _animStartedTime;
    PImage[] images = _getImages();
    return (int)(t) % images.length;
  }
  
  private float _getBaseY() {
    return height - size/2;
  }
  
  public void update() {
    float t = _getAnimTime() - _animStartedTime;
    PImage[] images = _getImages();
    int animIndex = _getAnimIndex();
    
    // 左右移動が必要なstate
    if(state == State.run || (state == State.jump && _stateAfterJump != State.idle)) {
      if(direction == Direction.left) x -= 3;
      else x += 3;
    }
    
    // jumpが必要なstate
    if(state == State.jump) {
      float jumpAnimProgress = t / (float)images.length;
      float jumpMaxHeight = 100;
      y = _getBaseY() -sin(jumpAnimProgress * PI) * jumpMaxHeight;       
    }
    
    // jump終わりに遷移すべきstateへ移る処理
    if(state == State.jump && animIndex == images.length-1) {
      _hasJumped = true;
    } else if(_hasJumped && animIndex == 0) {
      _toggleAnimation(_stateAfterJump);
      _hasJumped = false;
    }
  }
  
  // 描画関数
  public void display() {
    PImage[] images = _getImages();
    int animIndex = _getAnimIndex();
    translate(x - size/2, y - size/2);
    
    // 左向きの場合は画像をflipする
    if(direction == Direction.left) {
      scale(-1, 1);
      image(images[animIndex], 0, 0, -size, size);
      scale(-1, 1);
    } else {
      image(images[animIndex], 0, 0, size, size);
    }
    
    translate(-(x - size/2), -(y - size/2));
  }
  
  // idleへ遷移
  public void idle() {
    // idle中のjumpはjump終わり次第idleに戻るので、stateAfterJumpをidleに
    if(state == State.jump) {
      _stateAfterJump = State.idle;
      return;
    }
   _toggleAnimation(State.idle); 
  }
  
  // jumpへ遷移
  public void jump() {
    _toggleAnimation(State.jump);
  }
  
  // runへ遷移
  public void run(Direction dir) {
    direction = dir; 
    // jump中のrunはjump終わり次第runに遷移するためstateAfterJumpをrunに
    if(state == State.jump) {
      _stateAfterJump = State.run;
      return;
    }
    _toggleAnimation(State.run);    
  }
  
  private void _toggleAnimation(State type) {
    if(state == type) return;
    _stateAfterJump = state; 
    state = type;
    _animStartedTime = _getAnimTime();
  }
  
}
