using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class PlayerHudManager : MonoBehaviour
{
    private List<GameObject> npcsKnowingOfPlayer = new List<GameObject>();
    public Slider playerHP;
    public Image stealthNotification;
    public Sprite[] allStealthIcons;
    public int[] thresholdForNextIcon;
    public Animator promptAnimator;

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
    }

    public void AddObjectToPoolOfSeen(GameObject newObject)
    {
        if (npcsKnowingOfPlayer.Contains(newObject)) { return; }
        npcsKnowingOfPlayer.Add(newObject);
        UpdateStealthIcon();
    }

    public void RemoveObjectFromPoolOfSeen(GameObject oldObject)
    {
        if (!npcsKnowingOfPlayer.Contains(oldObject)) { return; }
        npcsKnowingOfPlayer.Remove(oldObject);
        UpdateStealthIcon();
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
