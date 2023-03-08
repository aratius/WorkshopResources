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
        if(m_IsFreezing) return;
        if(m_Targets.Count > 0)
        {
            float nearest = 999;
            Fighter nearestTarget = m_Targets[0];
            foreach (Fighter target in m_Targets)
            {
                float dist = Vector3.Distance(transform.position, target.transform.position);
                if(dist < nearest)
                {
                    nearest = dist;
                    nearestTarget = target;
                }
            }

            Vector3 direction = nearestTarget.transform.position - transform.position;
            if(direction.magnitude < 1.5f)
            {
                InvokeAttack();
            }

            if(direction.magnitude < 2f)
            {
                Walk(Mathf.Sign(m_TargetDirection));
            }
            else if(direction.magnitude < 6f)
            {
                Run(Mathf.Sign(m_TargetDirection));
            }

            if(m_Tween != null) m_Tween.Kill();
            m_Tween = DOTween.To(
                () => m_TargetDirection,
                v => m_TargetDirection = v,
                direction.x,
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
        if(UnityEngine.Time.time - m_LastAttackedTime > interval)
        {
            Attack();
            m_LastAttackedTime = UnityEngine.Time.time;
        }
    }

}
