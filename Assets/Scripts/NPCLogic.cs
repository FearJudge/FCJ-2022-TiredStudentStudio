using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class NPCLogic : MonoBehaviour
{
    public enum VillagerState
    {
        DoingTasks,
        Incapacitated,
        AttackingPlayer
    }

    public enum GoalToAchieve
    {
        DoNotKill,
        KillViaGallows,         //HIRTTOPUU
        KillViaBeheading,       //MESTAUSPÖLKKY
        KillViaFire,            //ROVIO
        KillViaBreakingWheel,   //TEILAUS
        KillViaWell,            //UHRIKAIVO
        KillViaGuilliotine,     //GILJOTIINI
        KillViaCliffside,       //JYRKÄNNE
        KillViaStarvingInCage   //HÄKKI
    }

    public NavMeshAgent nma;

    [System.Serializable]
    public class VillagerTask
    {
        public string nameOfTask = "New Task";
        public string location = "";
        public int taskStartAt = 0;
        public bool isPatrolling = false;
    }

    public string villagerName = "Relevant Rick";
    public List<VillagerTask> tasksToDo;
    public bool attacksPlayer = false;

    VillagerState state = VillagerState.DoingTasks;

    public VillagerState State {
        get
        { return state; }

        set
        { state = value; ManageNewState(); }
    }
    public GoalToAchieve killBy = GoalToAchieve.DoNotKill;
    public EnemyVision eyes;


    private void Awake()
    {
        SortTasks();
        InvokeRepeating("CheckLogic", 0.4f, 0.4f);
    }

    void ManageNewState()
    {
        switch (state)
        {
            case VillagerState.DoingTasks:
                nma.enabled = true;
                DoTask();
                break;
            case VillagerState.Incapacitated:
                nma.enabled = false;
                break;
            case VillagerState.AttackingPlayer:
                nma.enabled = true;
                break;
            default:
                break;
        }
    }

    void SortTasks()
    {
        tasksToDo.Sort((a, b) => b.taskStartAt.CompareTo(a.taskStartAt));
    }

    void CheckLogic()
    {
        switch (state)
        {
            case VillagerState.DoingTasks:
                DoTask();
                break;
            case VillagerState.Incapacitated:
                break;
            case VillagerState.AttackingPlayer:
                break;
            default:
                break;
        }
    }

    public void DoTask()
    {
        VillagerTask vt = tasksToDo.Find(p => p.taskStartAt <= VillageBrain.loopTime);
        nma.destination = VillageBrain.locationDict[vt.location].position;
    }

    public void ChasePlayer()
    {
        nma.destination = eyes.lastSeen;
    }

    private void Update()
    {
        if (eyes.inVision && state != VillagerState.AttackingPlayer) { State = VillagerState.AttackingPlayer; }
        else if (!eyes.inVision && state == VillagerState.AttackingPlayer) { State = VillagerState.DoingTasks; }

        if (state == VillagerState.AttackingPlayer) { ChasePlayer(); }
    }
}
