using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using SoundManager;

public class GameController : MonoBehaviour
{

  [SerializeField] FighterController m_FighterController;

  void Start()
  {
    m_FighterController.Prepare();
    m_FighterController.StartFighting();

    Sound.StopAndEffect = 1;
    Sound.Music = 0;

  }

  void Update()
  {

  }
}
