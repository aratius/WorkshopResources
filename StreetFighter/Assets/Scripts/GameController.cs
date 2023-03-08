using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameController : MonoBehaviour
{

  [SerializeField] FighterController m_FighterController;

  void Start()
  {
    m_FighterController.Prepare();
    m_FighterController.StartFighting();
  }

  void Update()
  {

  }
}
