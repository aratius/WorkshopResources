using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Player : Fighter
{
    // Start is called before the first frame update
    void Start()
    {
        base.Start();
    }

    void Update()
    {
        base.Update();
        if(!m_IsSitting)
        {
            Vector2 input = new Vector2(Input.GetAxis("Horizontal"), Input.GetAxis("Vertical"));
            float direction = Mathf.Sign(input.x);
            if(input.x != 0f) m_Direction = direction;
            transform.localScale = new Vector3(
                m_Direction * m_Size,
                transform.localScale.y,
                transform.localScale.z
            );

            if(Input.GetKey(KeyCode.B)) Run(input.x);
            else Walk(input.x);
        }

        if(Input.GetKeyDown(KeyCode.UpArrow)) Jump();
        if(Input.GetKeyDown(KeyCode.DownArrow)) Sit(true);
        if(Input.GetKeyUp(KeyCode.DownArrow)) Sit(false);
        if(Input.GetKeyDown(KeyCode.Space)) Attack();
    }

}
