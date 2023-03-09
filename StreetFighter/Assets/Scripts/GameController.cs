using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameController : MonoBehaviour
{

  [SerializeField] FighterController m_FighterController;
  [SerializeField] UIContoller m_UIController;
  

  void Start()
  {
    m_FighterController.onChangeHpPercent.AddListener(m_UIController.SetGauge);
    m_FighterController.onCreateFighter.AddListener(m_UIController.CreateFigher);

    m_FighterController.Prepare();
    m_FighterController.StartFighting();
  }

  void Update()
  {

  }
}
