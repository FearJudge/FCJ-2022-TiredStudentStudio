using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameManager : MonoBehaviour
{
    public VillageBrain villagerKnowledge;

    [System.Serializable] public class TarotCard
    {
        public string cardName = "The Fool";
        public Sprite cardArt;
        public NPCLogic.GoalToAchieve killMethod = NPCLogic.GoalToAchieve.DoNotKill;
        public NPCLogic.VillagerUniqueTrait personTrait = NPCLogic.VillagerUniqueTrait.NoTrait;
        public NPCLogic.HauntedBy personPosessed = NPCLogic.HauntedBy.None;
        public NPCLogic.VillagerType bravery = NPCLogic.VillagerType.Attacking;

        public bool overrideCharacterDailyRoutine = false;
        public List<NPCLogic.VillagerTask> overridenTasks = new List<NPCLogic.VillagerTask>();
    }

    public List<TarotCard> targetCardsToHuntBy = new List<TarotCard>();
    public List<Sprite> cardsToPrint = new List<Sprite>();
    List<TarotCard> _workList;
    public int targetsPerGame = 3;
    public int copiesOfTagetPerGame = 3;
    public int innocentsPerGame = 12;
    public int innocentRandomRangeUpDown = 0;
    public static List<TarotCard> chosenCards = new List<TarotCard>();
    public static Transform playerTransform;
    public static StarterAssets.ThirdPersonController controller;
    public Transform elevateToStaticPlayer;
    private NPCLogic.HauntedBy[] _haunters = new NPCLogic.HauntedBy[]
    {
        NPCLogic.HauntedBy.RedSpiritOfHatred,
        NPCLogic.HauntedBy.GreenSpiritOfEnvy,
        NPCLogic.HauntedBy.BlueSpiritOfSorrow
    };

    private void Awake()
    {
        playerTransform = elevateToStaticPlayer;
        controller = playerTransform.GetComponent<StarterAssets.ThirdPersonController>();
    }

    private void Start()
    {
        SetUpGame();
    }

    public void SetUpGame()
    {
        _workList = new List<TarotCard>(targetCardsToHuntBy);
        cardsToPrint.Clear();
        chosenCards.Clear();
        for (int i = 0; i < targetsPerGame; i++)
        {
            int _ran = Random.Range(0, _workList.Count);
            TarotCard _randomCard = _workList[_ran];
            _randomCard.personPosessed = _haunters[i];
            for (int k = 0; k < copiesOfTagetPerGame; k++)
            {
                GameObject _newNPC = Instantiate(villagerKnowledge.npcPrefab, villagerKnowledge.spawnPoints[Random.Range(0, villagerKnowledge.spawnPoints.Length)].position, Quaternion.identity);
                NPCLogic _newLogic = _newNPC.GetComponent<NPCLogic>();
                _newLogic.villagerName = villagerKnowledge.GenerateName();
                if (_randomCard.overrideCharacterDailyRoutine)
                { _newLogic.tasksToDo = _randomCard.overridenTasks; }
                else { _newLogic.tasksToDo = villagerKnowledge.GenerateRandomTasks(); }
                _newLogic.killBy = _randomCard.killMethod;
                _newLogic.haunted = _randomCard.personPosessed;
                _newLogic.trait = _randomCard.personTrait;
                _newLogic.onSpotting = _randomCard.bravery;
                cardsToPrint.Add(_randomCard.cardArt);
            }
            chosenCards.Add(_workList[_ran]);
            _workList.RemoveAt(_ran);
        }
        for (int j = 0; j < innocentsPerGame; j++)
        {
            GameObject _newNPC = Instantiate(villagerKnowledge.npcPrefab, villagerKnowledge.spawnPoints[j].position, Quaternion.identity);
            NPCLogic _newLogic = _newNPC.GetComponent<NPCLogic>();
            _newLogic.villagerName = villagerKnowledge.GenerateName();
            _newLogic.tasksToDo = villagerKnowledge.GenerateRandomTasks();
            // MODIFY, if you want to have red herrings'
            _newLogic.killBy = NPCLogic.GoalToAchieve.DoNotKill;
            _newLogic.haunted = NPCLogic.HauntedBy.None;
            _newLogic.trait = NPCLogic.VillagerUniqueTrait.NoTrait;
            _newLogic.onSpotting = (NPCLogic.VillagerType)Random.Range(0, 3);
        }
        villagerKnowledge.GatherLocations();
    }
}
