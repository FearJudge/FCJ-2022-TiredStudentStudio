using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class PlayerHudManager : MonoBehaviour
{
    private List<GameObject> npcsKnowingOfPlayer = new List<GameObject>();
    private List<LookAtMeAllwaysSenpai> markers = new List<LookAtMeAllwaysSenpai>();
    public Slider playerHP;
    public int[] thresholdForNextIcon;
    public Animator promptAnimator;
    public Animator messageAnimator;
    public Animator introAnimator;
    public TMPro.TextMeshProUGUI textMessage;
    public RectTransform[] cards;
    public Image[] cardBorders;
    public Image[] cardImages;
    public GameObject gameOver;
    public GameObject victoryScreen;
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

    public void Victory()
    {
        victoryScreen.SetActive(true); GameManager.controller.ReleaseMouse(true);
    }

    public void AddObjectToPoolOfSeen(GameObject newObject)
    {
        if (npcsKnowingOfPlayer.Contains(newObject)) { return; }
        npcsKnowingOfPlayer.Add(newObject);
        LookAtMeAllwaysSenpai lap = pool.GetPooledObjectComponent(newObject.transform);
        markers.Add(lap);
        newObject.GetComponent<NPCLogic>().marker = lap;
    }

    public void RemoveObjectFromPoolOfSeen(GameObject oldObject)
    {
        if (!npcsKnowingOfPlayer.Contains(oldObject)) { return; }
        NPCLogic npc = oldObject.GetComponent<NPCLogic>();
        npcsKnowingOfPlayer.Remove(oldObject);
        markers.Remove(npc.marker);
        npc.marker.gameObject.SetActive(false);
        npc.marker = null;
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
        for (int a = 0; a < cardBorders.Length; a++)
        {
            cardImages[a].sprite = GameManager.chosenCards[a].cardArt;
            Color hauntedBy = Color.white;
            switch (GameManager.chosenCards[a].personPosessed)
            {
                case NPCLogic.HauntedBy.BlueSpiritOfSorrow:
                    hauntedBy = new Color(0.8f, 0.8f, 1f);
                    break;
                case NPCLogic.HauntedBy.RedSpiritOfHatred:
                    hauntedBy = new Color(1f, 0.8f, 0.8f);
                    break;
                case NPCLogic.HauntedBy.GreenSpiritOfEnvy:
                    hauntedBy = new Color(0.8f, 1f, 0.8f);
                    break;
            }
            cardBorders[a].color = hauntedBy;
        }
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

    public void EndIntro()
    {
        introAnimator.SetTrigger("EndIntro");
    }
}
