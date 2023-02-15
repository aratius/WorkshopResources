public enum AnimationType {
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
  AnimationType animationType;
  AnimationType lastType;
  Direction direction;
  int animationIndex;
  float x;
  float y;
  float size;
  float animationSpeed;
  float animationStartedTime;
  boolean shouldReturnLastState;
  
  Player() {
    x = 0;
    y = 0;
    size = 128;
    direction = Direction.right;
    animationIndex = 0;
    animationStartedTime = getTime();
    shouldReturnLastState = false;
    
    for(int i = 0; i  < idleImages.length; i++) {
       idleImages[i] = loadImage("idle-" + (i+1) + ".png");   
    }
    for(int i = 0; i  < runImages.length; i++) {
       runImages[i] = loadImage("run-" + (i+1) + ".png");   
    }
    for(int i = 0; i  < jumpImages.length; i++) {
       jumpImages[i] = loadImage("jump-" + (i+1) + ".png");   
    }
    
    animationType = AnimationType.idle;
  }
  PImage[] getImages() {
    if(animationType == AnimationType.idle) {
       return idleImages;       
     } else if(animationType == AnimationType.run) {
       return runImages;
     } else if(animationType == AnimationType.jump) {
       return jumpImages;
     }
     return idleImages;
  }
  float getAnimationSpeed() {
    if(animationType == AnimationType.idle) {
       return 1;       
     } else if(animationType == AnimationType.run) {
       return 1;
     } else if(animationType == AnimationType.jump) {
       return .7;
     }
     return 1;
  }
  float getTime() {
    return (float)millis() / 100 * getAnimationSpeed();
  }
  void update() {
    PImage[] images = getImages();
    animationIndex = (int)(getTime() - animationStartedTime) % images.length;
    
    if(animationType == AnimationType.jump && animationIndex == images.length-1) {
      shouldReturnLastState = true;
    } else if(shouldReturnLastState && animationIndex == 0) {
      toggleAnimation(lastType);
      shouldReturnLastState = false;
    }
  }
  void display() {
    PImage[] images = getImages();
    if(direction == Direction.left) {
      scale(-1, 1);
      image(images[animationIndex], x, y, -size, size);
      scale(-1, 1);
    } else {
      image(images[animationIndex], x, y, size, size);
    }
      
  }
  void idle() {
    if(animationType == AnimationType.jump) {
      lastType = AnimationType.idle;
      return;
    }
   toggleAnimation(AnimationType.idle); 
  }
  void jump() {
    toggleAnimation(AnimationType.jump);
  }
  void run(Direction dir) {
    direction = dir;
    toggleAnimation(AnimationType.run);    
  }
  void toggleAnimation(AnimationType type) {
    if(animationType == type) return;
    lastType = animationType; 
    animationType = type;
    animationIndex = 0;
    animationStartedTime = getTime();
  }
}
