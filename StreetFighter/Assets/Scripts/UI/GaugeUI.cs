using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class GaugeUI : MonoBehaviour
{

    Material m_Mat;

    void Awake()
    {
        RawImage image = GetComponent<RawImage>();
        Texture texture = image.material.GetTexture("_MainTex");
        image.material = new Material(image.material.shader);
        m_Mat = image.material;
        m_Mat.SetTexture("_MainTex", texture);
    }
    
    public void Set(float percent)
    {
        m_Mat.SetFloat("_Percent", percent);
    }

}
