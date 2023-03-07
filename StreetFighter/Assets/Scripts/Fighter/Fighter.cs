using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public class Fighter : MonoBehaviour
{

    public string name = "undefined";
    public float hp = 1;
    public UnityEvent<Fighter> onDamaged = new UnityEvent<Fighter>();

    [SerializeField] protected GroundChecker m_GroundChecker;
    [SerializeField] protected Attack m_Attack;
    [SerializeField] protected Animator m_AnimCtrl;
    [SerializeField] protected float m_Size = 2f;
    [SerializeField] protected int m_AllowableJumpCnt = 2;

    protected Rigidbody2D m_RigidBody;
    protected Vector2 m_Velocity = Vector2.zero;
    protected Vector2 m_VelocityAdditional = Vector2.zero;
    protected float m_Direction = 1f;
    protected int m_JumpCnt = 0;
    protected bool m_IsGround = false;

    bool m_IsFighting = false;  // 戦っているかどうかフラグ

    protected void Awake()
    {
        m_RigidBody = GetComponent<Rigidbody2D>();
    }

    protected void Start()
    {
        transform.localScale = Vector3.one * m_Size;
    }

    protected void Update()
    {

    }

    void FixedUpdate() {
        m_RigidBody.velocity = new Vector2(m_Velocity.x, m_RigidBody.velocity.y) + m_VelocityAdditional;
        m_VelocityAdditional = m_VelocityAdditional * .9f;
    }

    private void OnTriggerEnter2D(Collider2D collision)
    {
        // もし敵の攻撃なら
        // onDamaged.Invoke(this);  // 発火
        if(collision.gameObject.tag == "Attack" && !collision.gameObject.Equals(m_Attack.gameObject))
        {
            Vector2 direction = transform.position - collision.gameObject.transform.position;
            m_VelocityAdditional += (direction + Vector2.up * .15f) * 3f;
        }
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
        m_AnimCtrl.SetTrigger("Attack");
        m_Attack.Execute(.3f, .3f);
    }

    public void Run(float direction)
    {

    }

    public void Jump()
    {
        if(m_GroundChecker.isGround) m_JumpCnt = 0;
        if(m_JumpCnt < m_AllowableJumpCnt)
        {
            // Jump
            m_AnimCtrl.SetTrigger("Jump");
            m_RigidBody.velocity = new Vector2(m_RigidBody.velocity.x, 0f);
            m_RigidBody.AddForce(transform.up * 10f, ForceMode2D.Impulse);
            m_JumpCnt++;
        }
    }

    public void Sit(bool isDown)
    {
        m_AnimCtrl.SetBool("Sit", isDown);
    }

}
