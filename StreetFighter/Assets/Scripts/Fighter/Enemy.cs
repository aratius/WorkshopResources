using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DG.Tweening;

public class Enemy : Fighter
{

  List<Fighter> m_Targets = new List<Fighter>();
  float m_LastAttackedTime = 0;
  float m_TargetDirection = 0;
  Tween m_Tween;

  void Start()
  {
    base.Start();
  }

  void Update()
  {
    base.Update();
    if (m_IsFreezing) return;
    if (m_Targets.Count > 0)
    {
      float nearest = 999;
      Fighter nearestTarget = m_Targets[0];
      foreach (Fighter target in m_Targets)
      {
        float dist = Vector3.Distance(transform.position, target.transform.position);
        if (dist < nearest)
        {
          nearest = dist;
          nearestTarget = target;
        }
      }

      Vector3 toTargetVec = nearestTarget.transform.position - transform.position;
      float dist = toTargetVec.magnitude;
      if (dist < 2f) InvokeAttack();

      if (dist < 2f) Walk(Mathf.Sign(m_TargetDirection));
      else if (dist < 6f) Run(Mathf.Sign(m_TargetDirection));
      else
      {
        // なんもない時適当にうろうろ
        float t = UnityEngine.Time.time;
        float dir = Mathf.Sin(t * .8f) + Mathf.Cos(t * .9f) / 2f;
        float noise = Mathf.Cos(t * .8f) + Mathf.Sin(t * .9f) / 2f;
        if (noise > 0f) Walk((Mathf.Pow(dir, 2f) * Mathf.Sign(dir)));
        else Run((Mathf.Pow(dir, 2f) * Mathf.Sign(dir)));
      }

      if (m_Tween != null) m_Tween.Kill();
      m_Tween = DOTween.To(
          () => m_TargetDirection,
          v => m_TargetDirection = v,
          toTargetVec.x,
          1f
      );
    }
  }

  public void AddTarget(Fighter target)
  {
    m_Targets.Add(target);
  }

  void InvokeAttack()
  {
    float interval = 1f;
    if (UnityEngine.Time.time - m_LastAttackedTime > interval)
    {
      Attack();
      m_LastAttackedTime = UnityEngine.Time.time;
    }
  }

}
