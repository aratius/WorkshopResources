using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GroundChecker : MonoBehaviour
{

  private bool m_IsGround = false;

  public bool isGround => m_IsGround;

  private void OnTriggerEnter2D(Collider2D collision)
  {
    m_IsGround = true;
  }

  private void OnTriggerStay2D(Collider2D collision)
  {
    m_IsGround = true;
  }

  private void OnTriggerExit2D(Collider2D collision)
  {
    m_IsGround = false;
  }
}
