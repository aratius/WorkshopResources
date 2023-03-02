using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public class Fighter : MonoBehaviour
{

    public string name = "undefined";
    public float hp = 1;
    public float attackPower = 1;
    public UnityEvent<Fighter> onDamaged = new UnityEvent<Fighter>();
    [SerializeField] Animator m_AnimCtrl;

    bool m_IsFighting = false;  // 戦っているかどうかフラグ

    void Start()
    {

    }

    void Update()
    {
        if(Input.GetKeyDown(KeyCode.LeftArrow))
        {
            // Start running
            m_AnimCtrl.SetTrigger("Run");
        }
        if(Input.GetKeyUp(KeyCode.LeftArrow))
        {
            // End running
            m_AnimCtrl.SetTrigger("Idle");
        }
        if(Input.GetKeyDown(KeyCode.UpArrow))
        {
            // Jump
            m_AnimCtrl.SetTrigger("Jump");
        }
    }

    void OnTriggerEnter2D(Collider2D other)
    {
        // もし敵の攻撃なら
        // onDamaged.Invoke(this);  // 発火
    }

    /// <summary>
    ///
    /// </summary>
    public void StartFighting()
    {
        m_IsFighting = true;
        Debug.Log($"### {name} start fighting");
    }

    /// <summary>
    ///
    /// </summary>
    public void EndFighting()
    {
        m_IsFighting = false;
        Debug.Log($"### {name} end fighting");
    }

    public void Attack()
    {

    }

    public void Run(float direction)
    {

    }

    public void Jump()
    {

    }

}
