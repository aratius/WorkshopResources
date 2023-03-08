using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public class Fighter : MonoBehaviour
{

  public string name = "undefined";
  public float hp = 1;
  public UnityEvent<Fighter> onDamaged = new UnityEvent<Fighter>();

  [SerializeField] Color m_Color;
  [SerializeField] protected GroundChecker m_GroundChecker;
  [SerializeField] protected Attack m_Attack;
  [SerializeField] protected Animator m_AnimCtrl;
  [SerializeField] protected float m_Size = 2f;
  [SerializeField] protected int m_AllowableJumpCnt = 2;

  protected Rigidbody2D m_RigidBody;
  protected Vector2 m_Velocity = Vector2.zero;
  protected Vector2 m_VelocityImpulse = Vector2.zero;
  protected float m_Direction = 1f;
  protected int m_JumpCnt = 0;
  protected bool m_IsGround = false;
  protected bool m_IsSitting = false;
  protected bool m_IsFreezing = false;

  bool m_IsFighting = false;  // 戦っているかどうかフラグ

  protected void Awake()
  {
    m_RigidBody = GetComponent<Rigidbody2D>();
    Cameraman.Instance.AddTarget(gameObject);
    SpriteRenderer r = GetComponent<SpriteRenderer>();
    r.material = new Material(r.material.shader);
    r.material.SetColor("_Color", m_Color);
  }

  protected void Start()
  {
    transform.localScale = Vector3.one * m_Size;
  }

  protected void Update()
  {

  }

  private void OnTriggerEnter2D(Collider2D collision)
  {
    // もし敵の攻撃なら
    if (collision.gameObject.tag == "Attack" && !collision.gameObject.Equals(m_Attack.gameObject))
    {
      // onDamaged.Invoke(this);  // 発火
      Vector2 direction = transform.position - collision.gameObject.transform.position;
      // m_VelocityImpulse += new Vector2(1f * Mathf.Sign(direction.x), .2f) * 10f;
      m_RigidBody.AddForce(new Vector2(1f * Mathf.Sign(direction.x), .5f) * 5f, ForceMode2D.Impulse);
      Cameraman.Instance.Shake();
      m_AnimCtrl.SetTrigger("Damaged");
      Freeze();
      CancelInvoke("UnFreeze");
      Invoke("UnFreeze", .5f);
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
    m_Attack.Execute(.1f, .3f);
  }

  public void Run(float inputX)
  {
    float velX = inputX * 100f;
    Move(velX, 5f);
  }

  public void Walk(float inputX)
  {
    float velX = inputX * 100f;
    Move(velX, 2f);
  }

  public void Jump()
  {
    if (m_GroundChecker.isGround) m_JumpCnt = 0;
    if (m_JumpCnt < m_AllowableJumpCnt)
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
    m_IsSitting = isDown;
    if (isDown)
    {
      m_AnimCtrl.SetBool("Stand", false);
      m_AnimCtrl.SetTrigger("Sit");
    }
    else
    {
      m_AnimCtrl.SetBool("Stand", true);
    }
  }

  void Move(float velX, float max)
  {
    float direction = Mathf.Sign(velX);
    if (velX != 0f) m_Direction = direction;
    transform.localScale = new Vector3(
        m_Direction * m_Size,
        transform.localScale.y,
        transform.localScale.z
    );
    if (velX != 0)
    {
      if (velX > 0)
      {
        m_RigidBody.AddForce(new Vector3(1f, 0f, 0f) * m_RigidBody.mass * velX * UnityEngine.Time.deltaTime, ForceMode2D.Impulse);
        if (m_RigidBody.velocity.x > max)
          m_RigidBody.velocity = new Vector2(max, m_RigidBody.velocity.y);
      }
      else
      {
        m_RigidBody.AddForce(new Vector3(1f, 0f, 0f) * m_RigidBody.mass * velX * UnityEngine.Time.deltaTime, ForceMode2D.Impulse);
        if (m_RigidBody.velocity.x < -max)
          m_RigidBody.velocity = new Vector2(-max, m_RigidBody.velocity.y);
      }
    }
    m_AnimCtrl.SetFloat("Speed", Mathf.Abs(m_RigidBody.velocity.x));
  }

  void Freeze()
  {
    m_IsFreezing = true;
  }

  void UnFreeze()
  {
    m_IsFreezing = false;
  }

}
