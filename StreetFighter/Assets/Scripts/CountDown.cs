using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class CountDown : MonoBehaviour
{
    [SerializeField] TMP_Text timerText;
    private float time = 3.0f;
    public bool isTimeUp;

    void Update()
    {
        if (0 <= time)
        {
            time -= UnityEngine.Time.deltaTime;
            timerText.text = time.ToString("F1");
        }
        else if (time <= 0)
        {
            isTimeUp = true;
            timerText.text = "TimeUp!";
        }
    }
}