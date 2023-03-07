using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Cysharp.Threading.Tasks;

public class Attack : MonoBehaviour
{

    [SerializeField] float attackPower = 1f;
    Collider2D m_Collider;

    void Awake()
    {
      m_Collider = GetComponent<Collider2D>();
      m_Collider.enabled = false;
    }

    public void Execute(float duration, float delay)
    {
      Off();
      CancelInvoke("On");
      CancelInvoke("Off");

      Invoke("On", delay);
      Invoke("Off", delay + duration);
    }

    void On()
    {
      m_Collider.enabled = true;
    }

    void Off()
    {
      m_Collider.enabled = false;
    }

}
