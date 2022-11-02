using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class PlayerHudManager : MonoBehaviour
{
    private List<GameObject> npcsKnowingOfPlayer = new List<GameObject>();
    private List<LookAtMeAllwaysSenpai> markers = new List<LookAtMeAllwaysSenpai>();
    public Slider playerHP;
    public Image stealthNotification;
    public Sprite[] allStealthIcons;
    public int[] thresholdForNextIcon;
    public Animator promptAnimator;
    public RectTransform[] cards;
    public GameObject gameOver;

    public MarkerPool pool;

    private void Awake()
    {
        NPCLogic.NoticedPlayer += AddObjectToPoolOfSeen;
        NPCLogic.LostInterest += RemoveObjectFromPoolOfSeen;
    }

    private void OnDestroy()
    {
        NPCLogic.NoticedPlayer -= AddObjectToPoolOfSeen;
        NPCLogic.LostInterest -= RemoveObjectFromPoolOfSeen;
    }

    public void DrawPlayerHP(int value, int valueMax)
    {
        playerHP.value = (float)value / valueMax;
        if (value <= 0) { gameOver.SetActive(true); GameManager.controller.ReleaseMouse(); }
    }

    public void AddObjectToPoolOfSeen(GameObject newObject)
    {
        if (npcsKnowingOfPlayer.Contains(newObject)) { return; }
        npcsKnowingOfPlayer.Add(newObject);
        LookAtMeAllwaysSenpai lap = pool.GetPooledObjectComponent(newObject.transform);
        markers.Add(lap);
        newObject.GetComponent<NPCLogic>().marker = lap;
        UpdateStealthIcon();
    }

    public void RemoveObjectFromPoolOfSeen(GameObject oldObject)
    {
        if (!npcsKnowingOfPlayer.Contains(oldObject)) { return; }
        NPCLogic npc = oldObject.GetComponent<NPCLogic>();
        npcsKnowingOfPlayer.Remove(oldObject);
        markers.Remove(npc.marker);
        npc.marker.gameObject.SetActive(false);
        npc.marker = null;
        UpdateStealthIcon();
    }

    public void DisplayCards(bool state)
    {
        if (promptAnimator.GetBool("Show") == state) { return; }
        promptAnimator.SetBool("Show", state);
        for (int a = 0; a < cards.Length; a++)
        {
            cards[a].eulerAngles = new Vector3(0f, 0f, Random.Range(-5f, 5f));
        }
    }

    public void UpdateStealthIcon()
    {
        int amount = npcsKnowingOfPlayer.Count;
        for (int a = 0; a < allStealthIcons.Length; a++)
        {
            if (amount <= 0) { stealthNotification.sprite = allStealthIcons[a]; return; }
            amount -= thresholdForNextIcon[a];
        }
        if (amount > 0) { stealthNotification.sprite = allStealthIcons[allStealthIcons.Length - 1]; }
    }
}
