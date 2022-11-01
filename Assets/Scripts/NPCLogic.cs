using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class NPCLogic : MonoBehaviour, ICarryable
{
    public delegate void AlertEvent(GameObject objectToNotice);
    public static event AlertEvent NoticedPlayer;
    public static event AlertEvent LostInterest;

    public enum VillagerState
    {
        DoingTasks,
        Incapacitated,
        AttackingPlayer,
        LookingForPlayer,
        NervouslyWaiting,
        Carried,
        FleeToHome,
        RunAroundAimlessly
    }

    public enum VillagerType
    {
        Attacking,
        Fleeing,
        Delirius,
        RandomlyAttacksFlees
    }

    public enum VillagerUniqueTrait
    {
        NoTrait,
        RedShirt,
        LimpLeg,
        SomeOtherNotifiableTrait
    }

    public enum HauntedBy
    {
        None,
        BlueSpiritOfSorrow,
        RedSpiritOfHatred,
        GreenSpiritOfEnvy
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

        public VillagerTask(VillagerTask villagerTask)
        {
            this.nameOfTask = villagerTask.nameOfTask;
            this.taskStartAt = villagerTask.taskStartAt;
            this.location = villagerTask.location;
            this.isPatrolling = villagerTask.isPatrolling;
        }
    }

    public string villagerName = "Relevant Rick";
    public List<VillagerTask> tasksToDo;
    public bool attacksPlayer = false;
    public Vector2 speedWalkRun = new Vector2(2f, 3f);
    Vector2 _speedWalkRunAnim = new Vector2(2f, 5.9f);

    public AudioClip[] FootstepAudioClips;
    [Range(0, 1)] public float FootstepAudioVolume;
    public AudioClip LandingAudioClip;
    public float targetRadius = 3f;

    private const float _waitLookAround = 7f;
    private const int _lookAroundSteps = 5;
    private const float _lookAroundRange = 1f;
    private int _shadowsToChase = 0;
    private const int _shadowsSeenWhenDelirious = 6;
    private Animator _animator;
    private bool _hasAnimator;
    private CharacterController _controller;

    private Rigidbody _rigidbody;
    private Transform _carryMeSenpai;
    private Vector3 _safeDistanceFromSenpai;

    VillagerState state = VillagerState.DoingTasks;

    public bool incapacitate;

    public VillagerState State {
        get
        { return state; }

        set
        { state = value; ManageNewState(); }
    }
    public GoalToAchieve killBy = GoalToAchieve.DoNotKill;
    public VillagerUniqueTrait trait = VillagerUniqueTrait.NoTrait;
    public HauntedBy haunted = HauntedBy.None;
    public VillagerType onSpotting = VillagerType.Attacking;
    public Vector3 homeLocation;
    public EnemyVision eyes;


    private void Awake()
    {
        InvokeRepeating("CheckLogic", 0.4f, 0.4f);
        _animator = GetComponent<Animator>();
        _controller = GetComponent<CharacterController>();
        _hasAnimator = (_animator != null);
        _animator.SetBool("Grounded", true);
        _animator.SetFloat("MotionSpeed", 1f);
        _rigidbody = GetComponent<Rigidbody>();
    }

    private void Start()
    {
        SortTasks();
    }

    void ManageNewState()
    {
        switch (state)
        {
            case VillagerState.DoingTasks:
                nma.enabled = true;
                nma.speed = speedWalkRun.x;
                LostInterest?.Invoke(gameObject);
                DoTask();
                break;
            case VillagerState.Incapacitated:
                if (nma.enabled) { nma.ResetPath(); }
                nma.enabled = false;
                LostInterest?.Invoke(gameObject);
                _animator.SetBool("KnockedOut", true);
                _animator.SetBool("Carried", false);
                break;
            case VillagerState.AttackingPlayer:
                nma.enabled = true;
                nma.speed = speedWalkRun.y;
                break;
            case VillagerState.LookingForPlayer:
                nma.enabled = true;
                nma.speed = speedWalkRun.x;
                break;
            case VillagerState.Carried:
                if (nma.enabled) { nma.ResetPath(); }
                nma.enabled = false;
                _animator.SetBool("Carried", true);
                break;
            case VillagerState.FleeToHome:
                nma.enabled = true;
                nma.speed = speedWalkRun.y;
                FleeHome();
                break;
            case VillagerState.NervouslyWaiting:
                nma.enabled = true;
                nma.speed = speedWalkRun.x;
                break;
            case VillagerState.RunAroundAimlessly:
                nma.enabled = true;
                nma.speed = speedWalkRun.y;
                _shadowsToChase = _shadowsSeenWhenDelirious;
                ChaseShadows();
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
            default:
                break;
        }
    }

    void ReEvaluate()
    {
        if (state == VillagerState.AttackingPlayer) { StartCoroutine(LoseInterest()); }
        else if (state == VillagerState.FleeToHome) { StartCoroutine(LoseFear()); }
        else if (state == VillagerState.RunAroundAimlessly) { ChaseShadows(); }
    }

    public void DoTask()
    {
        VillagerTask vt = tasksToDo.Find(p => p.taskStartAt <= VillageBrain.loopTime);
        nma.destination = VillageBrain.locationDict[vt.location].position;
    }

    public void FleeHome()
    {
        nma.destination = homeLocation;
    }

    public void ChasePlayer()
    {
        nma.destination = eyes.lastSeen;
    }

    public void ChaseShadows()
    {
        if (_shadowsToChase == 0) { State = VillagerState.DoingTasks; return; }
        nma.destination = nma.destination + new Vector3(Random.Range(-6f, 6f), 0f, Random.Range(-6f, 6f));
        _shadowsToChase--;
    }

    private void Update()
    {
        if (_carryMeSenpai != null) { transform.position = _carryMeSenpai.position + _safeDistanceFromSenpai; }
        if (!nma.enabled) { return; }

        if (incapacitate)
        {
            State = VillagerState.Incapacitated;
        }

        if (nma.remainingDistance <= targetRadius) { ReEvaluate(); }
        if (eyes.inVision && (state == VillagerState.DoingTasks || state == VillagerState.LookingForPlayer))
        {
            NoticedPlayer?.Invoke(gameObject);
            switch (onSpotting)
            {
                case VillagerType.Attacking:
                    State = VillagerState.AttackingPlayer;
                    break;
                case VillagerType.Fleeing:
                    State = VillagerState.FleeToHome;
                    break;
                case VillagerType.Delirius:
                    State = VillagerState.RunAroundAimlessly;
                    break;
                case VillagerType.RandomlyAttacksFlees:
                    if (Random.Range(0, 2) == 1) { State = VillagerState.FleeToHome; }
                    else { State = VillagerState.AttackingPlayer; }
                    break;
                default:
                    break;
            }}
        if (state == VillagerState.AttackingPlayer) { ChasePlayer(); }

        if (_hasAnimator)
        {
            _animator.SetFloat("Speed", nma.velocity.magnitude * ((nma.speed == speedWalkRun.y) ? _speedWalkRunAnim.y : _speedWalkRunAnim.x) / nma.speed);
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

    IEnumerator LoseInterest()
    {
        State = VillagerState.LookingForPlayer;
        for (int a = 0; a < _lookAroundSteps; a++)
        {
            if (state == VillagerState.AttackingPlayer) { yield break; }
            nma.destination += new Vector3(Random.Range(-_lookAroundRange, _lookAroundRange), 0f, Random.Range(-_lookAroundRange, _lookAroundRange));
            yield return new WaitForSeconds(_waitLookAround / _lookAroundSteps);
        }
        if (state == VillagerState.AttackingPlayer) { yield break; }
        State = VillagerState.DoingTasks;
    }

    IEnumerator LoseFear()
    {
        State = VillagerState.NervouslyWaiting;
        yield return new WaitForSeconds(_waitLookAround);
        State = VillagerState.DoingTasks;
    }

    public bool AmICarryable()
    {
        return (state == VillagerState.Incapacitated);
    }

    public void SetCarriedState(Transform toAttachTo, Vector3 offset = default)
    {
        if (!AmICarryable()) { return; }
        _carryMeSenpai = toAttachTo;
        _safeDistanceFromSenpai = offset;
        State = VillagerState.Carried;
        if (_rigidbody != null) { _rigidbody.isKinematic = true; }
    }

    public void ReleaseCarriedState()
    {
        if (state != VillagerState.Carried) { return; }
        _carryMeSenpai = null;
        State = VillagerState.Incapacitated;
        if (_rigidbody != null) { _rigidbody.isKinematic = false; }
    }

    public bool AmIInteractable()
    {
        throw new System.NotImplementedException();
    }

    public void Interact()
    {
        throw new System.NotImplementedException();
    }
}
