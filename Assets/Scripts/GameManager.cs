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
    public int innocentsPerGame = 12;
    public int innocentRandomRangeUpDown = 0;
    public static Transform playerTransform;
    public Transform elevateToStaticPlayer;

    private void Start()
    {
        SetUpGame();
    }

    public void SetUpGame()
    {
        _workList = new List<TarotCard>(targetCardsToHuntBy);
        cardsToPrint.Clear();
        for (int i = 0; i < targetsPerGame; i++)
        {
            int _ran = Random.Range(0, _workList.Count);
            TarotCard _randomCard = _workList[_ran];
            _workList.RemoveAt(_ran);
            GameObject _newNPC = Instantiate(villagerKnowledge.npcPrefab);
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
        for (int j = 0; j < innocentsPerGame; j++)
        {
            GameObject _newNPC = Instantiate(villagerKnowledge.npcPrefab);
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
