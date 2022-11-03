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
    public Animator messageAnimator;
    public TMPro.TextMeshProUGUI textMessage;
    public RectTransform[] cards;
    public Image[] cardImages;
    public Image[] cardBorders;
    public GameObject gameOver;
    bool _initialized = false;
    int _priorityMessage = 0;
    float _msgTime = 0f;

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
        if (!_initialized) { Initialize(); }
        promptAnimator.SetBool("Show", state);
        for (int a = 0; a < cards.Length; a++)
        {
            cards[a].eulerAngles = new Vector3(0f, 0f, Random.Range(-5f, 5f));
        }
    }

    void Initialize()
    {
        _initialized = true;
        for (int a = 0; a < cardImages.Length; a++)
        {
            cardImages[a].sprite = GameManager.chosenCards[a].cardArt;
            Color hauntedBy = Color.white;
            switch (GameManager.chosenCards[a].personPosessed)
            {
                case NPCLogic.HauntedBy.BlueSpiritOfSorrow:
                    hauntedBy = Color.blue;
                    break;
                case NPCLogic.HauntedBy.RedSpiritOfHatred:
                    hauntedBy = Color.red;
                    break;
                case NPCLogic.HauntedBy.GreenSpiritOfEnvy:
                    hauntedBy = Color.green;
                    break;
            }
            cardBorders[a].color = hauntedBy;
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

    public void DisplayMessage(string msg, int priority = 3, float time = 0.6f)
    {
        if (priority >= _priorityMessage) { textMessage.text = msg; _priorityMessage = priority; _msgTime = time; };
        StartCoroutine(UnDisplay());
    }

    public IEnumerator UnDisplay()
    {
        if (messageAnimator.GetBool("Display")) { yield break; }
        messageAnimator.SetBool("Display", true);
        while (_msgTime > 0f)
        {
            _msgTime -= 0.3f;
            yield return new WaitForSeconds(0.3f);
        }
        messageAnimator.SetBool("Display", false);
        yield return new WaitForSeconds(0.4f);
        _priorityMessage = 0;
    }
}
