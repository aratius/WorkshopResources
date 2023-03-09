using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public enum EffectType
{
    Cure,
    Collision,
    Jump,
    Run
}

[System.Serializable]
/// <summary>
/// SerializeFieldを呼び出す名前＝Serializable
/// </summary>
public struct EffectInfo
{
    public EffectType type;
    public GameObject prefab;
}

public class EffectContoller : SingletonMonoBehaviour<EffectContoller>
{

    [SerializeField] List<EffectInfo> m_EffectInfomations;


    /// <summary>
    /// 外から呼び出せる戻り値のない関数
    /// ()の中は引数でそこを変えたら処理の答えも変わる
    /// 内容の処理 
    /// </summary>
    /// <param name="type">なにを</param>
    /// <param name="position">どこで</param>
    public void Occour(EffectType type,Vector3 position)
    {
        foreach (EffectInfo item in m_EffectInfomations)
        {
            if(item.type == type)
            {
                GameObject effect = Instantiate(item.prefab, transform);
                effect.transform.position = position;
            }
        }
    }

    void Update()
    {

    }
}
