import java.util.Map;
import java.util.HashMap;

// キャラクター情報クラス
// dataフォルダに画像が以下のフォーマットで存在する必要あり（インデックスは1始まり）
// [名前]-[ステート(idle | run | jump)]-[インデックス].png
// 例) hoodman-run-1.png
public class CharacterInfo {
  String name;
  HashMap<State, PImage[]> imageMap = new HashMap<State, PImage[]>();  // 各stateのPImage配列
  HashMap<State, Float> animSpeedMap = new HashMap<State, Float>();  // 各stateのanimationSpeed
  
  public CharacterInfo(
    String _name,  // 名前
    int _idleImageLength,   // idleの画像枚数
    int _runImageLength,   // runの画像枚数
    int _jumpImageLength,  // jumpの画像枚数
    float _idleAnim1LoopDuration,  // idleのアニメーションが1周するのにかかる時間
    float _runAnim1LoopDuration,  // runのアニメーションが1周するのにかかる時間
    float _jumpAnim1LoopDuration  // jumpのアニメーションが1周するのにかかる時間
  ) {
    name = _name;
    
    PImage[] idleImages = new PImage[_idleImageLength];
    PImage[] runImages = new PImage[_runImageLength];
    PImage[] jumpImages = new PImage[_jumpImageLength];
    for(int i = 0; i  < idleImages.length; i++) 
      idleImages[i] = loadImage(name + "-idle-" + (i+1) + ".png");   
    for(int i = 0; i  < runImages.length; i++) 
      runImages[i] = loadImage(name + "-run-" + (i+1) + ".png");   
    for(int i = 0; i  < jumpImages.length; i++) 
      jumpImages[i] = loadImage(name + "-jump-" + (i+1) + ".png");
    imageMap.put(State.idle, idleImages);
    imageMap.put(State.run, runImages);
    imageMap.put(State.jump, jumpImages);
       
    animSpeedMap.put(State.idle, _idleImageLength / _idleAnim1LoopDuration);
    animSpeedMap.put(State.run, _runImageLength / _runAnim1LoopDuration);
    animSpeedMap.put(State.jump, _jumpImageLength / _jumpAnim1LoopDuration);
  }
} 
