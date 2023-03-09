using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public class FighterController : MonoBehaviour
{

    public UnityEvent<string> onCreateFighter = new UnityEvent<string>();
    public UnityEvent<string, float> onChangeHpPercent = new UnityEvent<string, float>();

    [SerializeField] GameObject m_PlayerPrefab;  // FighterのPrefab
    [SerializeField] GameObject m_EnemyPrefab;  // FighterのPrefab

    List<Fighter> m_Fighters = new List<Fighter>();  // Fighterの配列

    // Start is called before the first frame update
    void Start()
    {

    }

    // Update is called once per frame
    void Update()
    {

    }

    /// <summary>
    /// 準備
    /// </summary>
    public void Prepare()
    {
        // TODO: プレイヤーもしくはCOMのインスタンスを作る

        // プレイヤー作成
        GameObject playerGO = Instantiate(m_PlayerPrefab, transform);
        Player player = playerGO.GetComponent<Player>();
        player.name = "player";
        player.onChangeHpPercent.AddListener(onChangeHpPercent.Invoke);  // PlayerのonDamagedイベントが発火された時に自身のメソッド"onChangeHpPercent"を発火します
        m_Fighters.Add(player);

        // 敵作成
        GameObject enemyGO = Instantiate(m_EnemyPrefab, transform);
        Enemy enemy = enemyGO.GetComponent<Enemy>();
        enemy.name = "enemy";
        enemy.onChangeHpPercent.AddListener(onChangeHpPercent.Invoke);  // EnemyのonDamagedイベントが発火された時に自身のメソッド"onChangeHpPercent"を発火します
        enemy.AddTarget(player);
        m_Fighters.Add(enemy);

        onCreateFighter.Invoke(player.name);
        onCreateFighter.Invoke(enemy.name);
    }

    /// <summary>
    ///
    /// </summary>
    public void StartFighting()
    {
        foreach (Fighter fighter in m_Fighters)
        {
            fighter.StartFighting();
        }
    }

    /// <summary>
    ///
    /// </summary>
    public void EndFighting()
    {
        foreach (Fighter fighter in m_Fighters)
        {
            fighter.EndFighting();
        }
    }


}
