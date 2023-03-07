using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DG.Tweening;

public class Cameraman : SingletonMonoBehaviour<Cameraman>
{

    List<GameObject> m_Targets = new List<GameObject>();
    Transform m_MoveTransform;
    Transform m_ShakeTransform;
    Tween m_CameraTween;

    void Awake()
    {
        m_MoveTransform = new GameObject().transform;
        m_ShakeTransform = new GameObject().transform;
        Wiggle();
    }

    void Update()
    {
        if(m_Targets.Count > 0)
        {
            Vector3 pos = Vector3.zero;
            foreach(GameObject go in m_Targets) {
                Vector3 p = go.transform.position;
                pos += p;
            }
            pos = pos / m_Targets.Count;
            m_MoveTransform.DOMove(new Vector3(pos.x, 0f, -10f), .5f).SetEase(Ease.OutExpo);
        }

        transform.position = m_MoveTransform.position + m_ShakeTransform.position;
    }

    public void AddTarget(GameObject target)
    {
        m_Targets.Add(target);
    }

    /// <summary>
    /// wiggle
    /// </summary>
    void Wiggle()
    {
        if(m_CameraTween != null) m_CameraTween.Kill();
        m_CameraTween = DOTween.To(
            setter: (_) => {}, startValue: 0f, endValue: 1f, duration: 1f
        )
        .SetLoops(-1)
        .OnUpdate(() => {
            float t = UnityEngine.Time.time * 1f;
            float range = .01f;
            Vector3 p = new Vector3(
                (Mathf.Sin(t * .8f) + Mathf.Sin(t * .9f)) * 1f,
                (Mathf.Sin(t * .88f) + Mathf.Cos(t * .98f)) * 1f,
                (Mathf.Cos(t * .84f) + Mathf.Cos(t * .94f)) * 1f
            ) * range;
            m_ShakeTransform.DOLocalMove(p, .1f);
        });
    }

    /// <summary>
    /// shock
    /// </summary>
    public void Shake()
    {
        if(m_CameraTween != null) m_CameraTween.Kill();
        m_CameraTween = m_ShakeTransform.DOShakePosition(duration: .5f, strength: 0.1f, vibrato: 10, randomness: 100f, snapping: false, fadeOut: true);
        m_CameraTween.OnComplete(Wiggle);
    }

}
