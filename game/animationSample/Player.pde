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
  private int _animIndex;
  private float _animStartedTime;
  private boolean _hasJumped;
  
  public Player(CharacterInfo __characterInfo) {
    _characterInfo = __characterInfo;
    state = State.idle;
    size = 128;
    x = width/2;
    y = _getBaseY();
    direction = Direction.right;
    _animIndex = 0;
    _animStartedTime = _getTime();
    _hasJumped = false;
    
    // 画像のセット
    _idleImages = new PImage[_characterInfo.idleImageLength];
    _runImages = new PImage[_characterInfo.runImageLength];
    _jumpImages = new PImage[_characterInfo.jumpImageLength];
    for(int i = 0; i  < _idleImages.length; i++) {
       _idleImages[i] = loadImage(_characterInfo.name + "-idle-" + (i+1) + ".png");   
    }
    for(int i = 0; i  < _runImages.length; i++) {
       _runImages[i] = loadImage(_characterInfo.name + "-run-" + (i+1) + ".png");   
    }
    for(int i = 0; i  < _jumpImages.length; i++) {
       _jumpImages[i] = loadImage(_characterInfo.name + "-jump-" + (i+1) + ".png");   
    }

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
  private float getAnimationSpeed() {
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
    return (float)millis() / 100 * getAnimationSpeed();
  }
  private float _getBaseY() {
    return height - size/2;
  }
  public void update() {
    float t = _getTime() - _animStartedTime;
    
    PImage[] images = _getImages();
    _animIndex = (int)(t) % images.length;
    
    if(state == State.run || (state == State.jump && _stateAfterJump != State.idle)) {
      if(direction == Direction.left) x -= 3;
      else x += 3;
    }
    if(state == State.jump) {
      y = _getBaseY() -sin(t / (float)images.length * PI) * 100;       
    }
    
    if(state == State.jump && _animIndex == images.length-1) {
      _hasJumped = true;
    } else if(_hasJumped && _animIndex == 0) {
      _toggleAnimation(_stateAfterJump);
      _hasJumped = false;
    }
  }
  public void display() {
    PImage[] images = _getImages();
      translate(x - size/2, y - size/2);
    if(direction == Direction.left) {
      scale(-1, 1);
      image(images[_animIndex], 0, 0, -size, size);
      scale(-1, 1);
    } else {
      image(images[_animIndex], 0, 0, size, size);
    }
    translate(-(x - size/2), -(y - size/2));
  }
  public void idle() {
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
    _animIndex = 0;
    _animStartedTime = _getTime();
  }
}
