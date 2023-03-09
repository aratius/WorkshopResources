using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GaugeUIManager : MonoBehaviour
{
    [SerializeField] GameObject m_GaugePrefab;

    Dictionary<string, GaugeUI> m_Gauges = new Dictionary<string, GaugeUI>();

    public void Create(string name) 
    {
        if(m_Gauges.Count > 2) 
        {
            Debug.LogWarning("can not create 2 more");
        }

        GameObject gaugeGO = Instantiate(m_GaugePrefab, transform);
        GaugeUI gaugeUI = gaugeGO.GetComponent<GaugeUI>();
        m_Gauges.Add(name, gaugeUI);


        if(m_Gauges.Count == 2) 
        {
            Vector3 s = gaugeGO.transform.localScale;
            gaugeGO.transform.localScale = new Vector3(-s.x, s.y, s.z);
        }
    }

    public void Set(string name, float percent)
    {
        if(!m_Gauges.ContainsKey(name))
        {
            Debug.LogWarning($"not found {name}");
            return;
        }
        m_Gauges[name].Set(percent);
    }

    public void Clear()
    {
        m_Gauges.Clear();
    }
    
}
