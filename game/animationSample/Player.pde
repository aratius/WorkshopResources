public class CharacterInfo {
  String name;
  int idleImageLength;
  int runImageLength;
  int jumpImageLength;
  float idleAnimationSpeed;
  float runAnimationSpeed;
  float jumpAnimationSpeed;
  
  public CharacterInfo(
    String _name, 
    int _idleImageLength, 
    int _runImageLength, 
    int _jumpImageLength,
    float _idleAnimationSpeed,
    float _runAnimationSpeed,
    float _jumpAnimationSpeed
  ) {
    name = _name;
    idleImageLength = _idleImageLength;
    runImageLength = _runImageLength;
    jumpImageLength = _jumpImageLength;
    idleAnimationSpeed = _idleAnimationSpeed;
    runAnimationSpeed = _runAnimationSpeed;
    jumpAnimationSpeed = _jumpAnimationSpeed;
  }
} 

enum State {
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
  
  public Player(CharacterInfo __characterInfo) {
    _characterInfo = __characterInfo;
    state = State.idle;
    size = 128;
    x = width/2;
    y = _getBaseY();
    direction = Direction.right;
    _animStartedTime = _getTime();
    _hasJumped = false;
    
    // 画像のセット
    _idleImages = new PImage[_characterInfo.idleImageLength];
    _runImages = new PImage[_characterInfo.runImageLength];
    _jumpImages = new PImage[_characterInfo.jumpImageLength];
    String name = _characterInfo.name;
    for(int i = 0; i  < _idleImages.length; i++) 
       _idleImages[i] = loadImage(name + "-idle-" + (i+1) + ".png");   
    for(int i = 0; i  < _runImages.length; i++) 
       _runImages[i] = loadImage(name + "-run-" + (i+1) + ".png");   
    for(int i = 0; i  < _jumpImages.length; i++) 
       _jumpImages[i] = loadImage(name + "-jump-" + (i+1) + ".png");   

  }
  private PImage[] _getImages() {
    if(state == State.idle) {
       return _idleImages;       
     } else if(state == State.run) {
       return _runImages;
     } else if(state == State.jump) {
       return _jumpImages;
     }
     return _idleImages;
  }
  private float _getAnimationSpeed() {
    if(state == State.idle) {
       return _characterInfo.idleAnimationSpeed;       
     } else if(state == State.run) {
       return _characterInfo.runAnimationSpeed;
     } else if(state == State.jump) {
       return _characterInfo.jumpAnimationSpeed;
     }
     return 1;
  }
  private float _getTime() {
    return (float)millis() / 100 * _getAnimationSpeed();
  }
  private int _getAnimIndex() {
    float t = _getTime() - _animStartedTime;
    PImage[] images = _getImages();
    return (int)(t) % images.length;
  }
  private float _getBaseY() {
    return height - size/2;
  }
  public void update() {
    float t = _getTime() - _animStartedTime;
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
  public void idle() {
    // idle中のjumpはjump終わり次第idleに戻るので、stateAfterJumpをidleに
    if(state == State.jump) {
      _stateAfterJump = State.idle;
      return;
    }
   _toggleAnimation(State.idle); 
  }
  public void jump() {
    _toggleAnimation(State.jump);
  }
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
    _animStartedTime = _getTime();
  }
}
