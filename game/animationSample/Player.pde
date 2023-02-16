class CharacterInfo {
  String name;
  int idleImageLength;
  int runImageLength;
  int jumpImageLength;
  float idleAnimationSpeed;
  float runAnimationSpeed;
  float jumpAnimationSpeed;
  
  CharacterInfo(
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
  CharacterInfo characterInfo;
  PImage[] idleImages;
  PImage[] runImages;
  PImage[] jumpImages;
  State state;
  State stateAfterJump;
  Direction direction;
  int animIndex;
  float x;
  float y;
  float size;
  float animStartedTime;
  boolean hasJumped;
  
  Player(CharacterInfo _characterInfo) {
    characterInfo = _characterInfo;
    
    idleImages = new PImage[characterInfo.idleImageLength];
    runImages = new PImage[characterInfo.runImageLength];
    jumpImages = new PImage[characterInfo.jumpImageLength];
    for(int i = 0; i  < idleImages.length; i++) {
       idleImages[i] = loadImage(characterInfo.name + "-idle-" + (i+1) + ".png");   
    }
    for(int i = 0; i  < runImages.length; i++) {
       runImages[i] = loadImage(characterInfo.name + "-run-" + (i+1) + ".png");   
    }
    for(int i = 0; i  < jumpImages.length; i++) {
       jumpImages[i] = loadImage(characterInfo.name + "-jump-" + (i+1) + ".png");   
    }
    
    state = State.idle;
    
    size = 128;
    x = width/2 - size/2;
    y = getBaseY();
    direction = Direction.right;
    animIndex = 0;
    animStartedTime = getTime();
    hasJumped = false;
  }
  PImage[] getImages() {
    if(state == State.idle) {
       return idleImages;       
     } else if(state == State.run) {
       return runImages;
     } else if(state == State.jump) {
       return jumpImages;
     }
     return idleImages;
  }
  float getAnimationSpeed() {
    if(state == State.idle) {
       return characterInfo.idleAnimationSpeed;       
     } else if(state == State.run) {
       return characterInfo.runAnimationSpeed;
     } else if(state == State.jump) {
       return characterInfo.jumpAnimationSpeed;
     }
     return 1;
  }
  float getTime() {
    return (float)millis() / 100 * getAnimationSpeed();
  }
  float getBaseY() {
    return height - size;
  }
  void update() {
    float t = getTime() - animStartedTime;
    
    PImage[] images = getImages();
    animIndex = (int)(t) % images.length;
    
    if(state == State.run || (state == State.jump && stateAfterJump != State.idle)) {
      if(direction == Direction.left) x -= 3;
      else x += 3;
    }
    if(state == State.jump) {
      y = getBaseY() -sin(t / (float)images.length * PI) * 100;       
    }
    
    if(state == State.jump && animIndex == images.length-1) {
      hasJumped = true;
    } else if(hasJumped && animIndex == 0) {
      toggleAnimation(stateAfterJump);
      hasJumped = false;
    }
  }
  void display() {
    PImage[] images = getImages();
    if(direction == Direction.left) {
      scale(-1, 1);
      image(images[animIndex], -x, y, -size, size);
      scale(-1, 1);
    } else {
      image(images[animIndex], x, y, size, size);
    }
      
  }
  void idle() {
    if(state == State.jump) {
      stateAfterJump = State.idle;
      return;
    }
   toggleAnimation(State.idle); 
  }
  void jump() {
    toggleAnimation(State.jump);
  }
  void run(Direction dir) {
    direction = dir;
    if(state == State.jump) {
      stateAfterJump = State.run;
      return;
    }
    toggleAnimation(State.run);    
  }
  void toggleAnimation(State type) {
    if(state == type) return;
    stateAfterJump = state; 
    state = type;
    animIndex = 0;
    animStartedTime = getTime();
  }
}
