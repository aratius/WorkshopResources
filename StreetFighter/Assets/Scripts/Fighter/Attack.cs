using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Cysharp.Threading.Tasks;

public class Attack : MonoBehaviour
{

    [SerializeField] float attackPower = 1f;
    BoxCollider2D m_Collider;
    Vector2 initialSize;

    void Awake()
    {
      m_Collider = GetComponent<BoxCollider2D>();
      m_Collider.enabled = false;
      initialSize = m_Collider.size;
    }
    void Start () {
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
      m_Collider.size = initialSize;
    }

    void Off()
    {
      m_Collider.enabled = false;
      m_Collider.size = Vector2.zero;
    }

}
