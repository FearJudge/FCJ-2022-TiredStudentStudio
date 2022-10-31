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
    public Vector2 speedWalkRun = new Vector2(2f, 3f);
    Vector2 _speedWalkRunAnim = new Vector2(2f, 5.9f);

    public AudioClip[] FootstepAudioClips;
    [Range(0, 1)] public float FootstepAudioVolume;
    public AudioClip LandingAudioClip;

    private Animator _animator;
    private bool _hasAnimator;
    private CharacterController _controller;

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
        _animator = GetComponent<Animator>();
        _controller = GetComponent<CharacterController>();
        _hasAnimator = (_animator != null);
        _animator.SetBool("Grounded", true);
        _animator.SetFloat("MotionSpeed", 1f);
    }

    void ManageNewState()
    {
        switch (state)
        {
            case VillagerState.DoingTasks:
                nma.enabled = true;
                nma.speed = speedWalkRun.x;
                DoTask();
                break;
            case VillagerState.Incapacitated:
                nma.enabled = false;
                break;
            case VillagerState.AttackingPlayer:
                nma.enabled = true;
                nma.speed = speedWalkRun.y;
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

        if (_hasAnimator)
        {
            _animator.SetFloat("Speed", nma.velocity.magnitude * ((state == VillagerState.AttackingPlayer) ? _speedWalkRunAnim.y : _speedWalkRunAnim.x) / nma.speed);
        }
    }

    private void OnFootstep(AnimationEvent animationEvent)
    {
        if (animationEvent.animatorClipInfo.weight > 0.5f)
        {
            if (FootstepAudioClips.Length > 0)
            {
                var index = Random.Range(0, FootstepAudioClips.Length);
                AudioSource.PlayClipAtPoint(FootstepAudioClips[index], transform.TransformPoint(_controller.center), FootstepAudioVolume);
            }
        }
    }

    private void OnLand(AnimationEvent animationEvent)
    {
        if (animationEvent.animatorClipInfo.weight > 0.5f)
        {
            AudioSource.PlayClipAtPoint(LandingAudioClip, transform.TransformPoint(_controller.center), FootstepAudioVolume);
        }
    }
}
