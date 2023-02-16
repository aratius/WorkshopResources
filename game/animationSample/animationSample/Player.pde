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
  PImage[] idleImages = new PImage[10];
  PImage[] runImages = new PImage[8];
  PImage[] jumpImages = new PImage[3];
  State state;
  State stateAfterJump;
  Direction direction;
  int animIndex;
  float x;
  float y;
  float size;
  float animStartedTime;
  boolean hasJumped;
  
  Player() {
    size = 128;
    x = width/2 - size/2;
    y = getBaseY();
    direction = Direction.right;
    animIndex = 0;
    animStartedTime = getTime();
    hasJumped = false;
    
    for(int i = 0; i  < idleImages.length; i++) {
       idleImages[i] = loadImage("idle-" + (i+1) + ".png");   
    }
    for(int i = 0; i  < runImages.length; i++) {
       runImages[i] = loadImage("run-" + (i+1) + ".png");   
    }
    for(int i = 0; i  < jumpImages.length; i++) {
       jumpImages[i] = loadImage("jump-" + (i+1) + ".png");   
    }
    
    state = State.idle;
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
       return 1;       
     } else if(state == State.run) {
       return 1;
     } else if(state == State.jump) {
       return .5;
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
