using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class UIContoller : MonoBehaviour
{
    [SerializeField]GaugeUIManager m_GaugeManager;

    public void CreateFigher(string name)
    {
        m_GaugeManager.Create(name);
    }

    public void SetGauge(string name, float percent)
    {
        m_GaugeManager.Set(name, percent);
    }
    
}
