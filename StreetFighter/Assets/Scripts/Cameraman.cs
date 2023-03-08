using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DG.Tweening;

public class Cameraman : SingletonMonoBehaviour<Cameraman>
{

  [SerializeField] float m_MinSize = 3f;
  [SerializeField] float m_MaxSize = 5f;
  Camera m_Camera;
  List<GameObject> m_Targets = new List<GameObject>();
  Transform m_MoveTransform;
  Transform m_ShakeTransform;
  Tween m_CameraTween;
  Tween m_OrthographicSizeTween;

  void Awake()
  {
    m_Camera = GetComponent<Camera>();
    m_MoveTransform = new GameObject().transform;
    m_ShakeTransform = new GameObject().transform;
    Wiggle();
  }

  void Update()
  {
    if (m_Targets.Count > 0)
    {
      Vector3 pos = Vector3.zero;
      float minX = m_Targets[0].transform.position.x;
      float maxX = m_Targets[0].transform.position.x;
      foreach (GameObject go in m_Targets)
      {
        Vector3 p = go.transform.position;
        pos += p;
        if (p.x < minX) minX = p.x;
        if (p.x > maxX) maxX = p.x;
      }
      pos = pos / m_Targets.Count;
      m_MoveTransform.DOMoveX(pos.x, .5f).SetEase(Ease.OutExpo);

      // キャラクターの位置に合わせてカメラのサイズ変える
      float captureAreaLength = maxX - minX + 2f;  // ギチギチにならないように+2で余裕持たせる
      float aspect = (float)Screen.width / (float)Screen.height;
      float orthographicSize = captureAreaLength / aspect / 2f;
      orthographicSize = Mathf.Clamp(orthographicSize, m_MinSize, m_MaxSize);
      if (m_OrthographicSizeTween != null) m_OrthographicSizeTween.Kill();
      m_OrthographicSizeTween = DOTween.To(
          () => m_Camera.orthographicSize,
          v => m_Camera.orthographicSize = v,
          orthographicSize,
          5f
      ).SetEase(Ease.OutExpo).OnUpdate(() =>
      {
        m_MoveTransform.DOMoveY(-(5f - m_Camera.orthographicSize), 0f);
      });
    }

    transform.position = m_MoveTransform.position + m_ShakeTransform.position + new Vector3(0f, 0f, -10f);
  }

  public void AddTarget(GameObject target)
  {
    m_Targets.Add(target);
  }

  /// <summary>
  /// shock
  /// </summary>
  public void Shake()
  {
    if (m_CameraTween != null) m_CameraTween.Kill();
    m_CameraTween = m_ShakeTransform.DOShakePosition(duration: .5f, strength: 0.3f, vibrato: 10, randomness: 100f, snapping: false, fadeOut: true);
    m_CameraTween.OnComplete(Wiggle);
  }

  /// <summary>
  /// wiggle
  /// </summary>
  void Wiggle()
  {
    if (m_CameraTween != null) m_CameraTween.Kill();
    m_CameraTween = DOTween.To(
        setter: (_) => { }, startValue: 0f, endValue: 1f, duration: 1f
    )
    .SetLoops(-1)
    .OnUpdate(() =>
    {
      float t = UnityEngine.Time.time * 1f;
      float range = .1f;
      Vector3 p = new Vector3(
              (Mathf.Sin(t * .8f) + Mathf.Sin(t * .9f)) * 1f,
              (Mathf.Sin(t * .88f) + Mathf.Cos(t * .98f)) * 1f,
              (Mathf.Cos(t * .84f) + Mathf.Cos(t * .94f)) * 1f
          ) * range;
      m_ShakeTransform.DOLocalMove(p, .1f);
    });
  }

}
