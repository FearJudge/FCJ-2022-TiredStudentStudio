using StarterAssets;
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
        RunAroundAimlessly,
        AttackingButDazed,
        FleeingButDazed,
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
    private float _timeKnockedOut = 0f;
    private const float _gripStrength = 0.2f;
    private Animator _animator;
    private bool _hasAnimator;
    private CharacterController _controller;

    private Rigidbody _rigidbody;
    private Transform _carryMeSenpai;
    private Vector3 _safeDistanceFromSenpai;

    VillagerState state = VillagerState.DoingTasks;

    public bool incapacitate;

    public int maxTimeToIncapacitate = 4;
    private int _hitsToKnockout = 1;
    private int _hitsToKnockoutAlert = 2;
    public float meleeTimer;
    public int meleeHitCount;

    [SerializeField] private ThirdPersonController _thirdPersonController;
    private SacrificialSite inOfferingRange;

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
        _thirdPersonController = GameManager.controller;
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
                _timeKnockedOut = 10f;
                break;
            case VillagerState.AttackingPlayer:
                NoticedPlayer?.Invoke(gameObject);
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
                NoticedPlayer?.Invoke(gameObject);
                nma.enabled = true;
                nma.speed = speedWalkRun.y;
                FleeHome();
                break;
            case VillagerState.NervouslyWaiting:
                nma.enabled = true;
                nma.speed = speedWalkRun.x;
                break;
            case VillagerState.RunAroundAimlessly:
                NoticedPlayer?.Invoke(gameObject);
                nma.enabled = true;
                nma.speed = speedWalkRun.y;
                _shadowsToChase = _shadowsSeenWhenDelirious;
                ChaseShadows();
                break;
            case VillagerState.AttackingButDazed:
                if (nma.enabled) { nma.ResetPath(); }
                nma.enabled = false;
                LostInterest?.Invoke(gameObject);
                _animator.SetBool("KnockedOut", true);
                _animator.SetBool("Carried", false);
                _timeKnockedOut = 3f;
                break;
            case VillagerState.FleeingButDazed:
                if (nma.enabled) { nma.ResetPath(); }
                nma.enabled = false;
                LostInterest?.Invoke(gameObject);
                _animator.SetBool("KnockedOut", true);
                _animator.SetBool("Carried", false);
                _timeKnockedOut = 3f;
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
        if (state == VillagerState.AttackingPlayer && !eyes.inVision) { StartCoroutine(LoseInterest()); }
        else if (state == VillagerState.AttackingPlayer) { Attack(); }
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

    void Incapacitate()
    {
        switch (state)
        {
            case VillagerState.AttackingPlayer:
                State = VillagerState.AttackingButDazed;
                break;
            case VillagerState.FleeToHome:
                State = VillagerState.FleeingButDazed;
                break;
            case VillagerState.RunAroundAimlessly:
                State = VillagerState.FleeingButDazed;
                break;
            default:
                State = VillagerState.Incapacitated;
                break;
        }
        meleeHitCount = 0;
    }

    private void Update()
    {
        if (_timeKnockedOut > 0f) { _timeKnockedOut -= Time.deltaTime; if (_timeKnockedOut <= 0f) { Recover(); } }
        if (_carryMeSenpai != null && _timeKnockedOut > 0f) { transform.position = _carryMeSenpai.position + _safeDistanceFromSenpai; _timeKnockedOut += Time.deltaTime * _gripStrength; }

        CheckForMeleeLogic();

        if (!nma.enabled) { return; }
        if (nma.remainingDistance <= targetRadius) { ReEvaluate(); }
        if (eyes.inVision && (state == VillagerState.DoingTasks || state == VillagerState.LookingForPlayer))
        {
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

    private void CheckForMeleeLogic()
    {
        void Alert()
        {
            if (meleeHitCount > 0 && meleeTimer > 0)
            {
                meleeTimer -= Time.deltaTime;

                if (meleeHitCount == _hitsToKnockoutAlert)
                {
                    Incapacitate();
                }
            }
            else
            {
                meleeHitCount = 0;
                meleeTimer = maxTimeToIncapacitate;
            }
        }

        void Oblivious()
        {
            if (meleeHitCount > 0 && meleeTimer > 0)
            {
                meleeTimer -= Time.deltaTime;

                if (meleeHitCount == _hitsToKnockout)
                {
                    Incapacitate();
                }
            }
            else
            {
                meleeHitCount = 0;
                meleeTimer = maxTimeToIncapacitate;
            }
        }

        if (incapacitate) { return; }
        switch (state)
        {
            case VillagerState.AttackingPlayer:
                Alert();
                break;
            case VillagerState.FleeToHome:
                Alert();
                break;
            case VillagerState.AttackingButDazed:
                return;
            case VillagerState.FleeingButDazed:
                return;
            default:
                Oblivious();
                break;
        }
        
    }

    void Recover()
    {
        if (_carryMeSenpai != null) { ReleaseCarriedState(); }
        switch (state)
        {
            case VillagerState.Incapacitated:
                State = VillagerState.DoingTasks;
                break;
            case VillagerState.AttackingButDazed:
                State = VillagerState.AttackingPlayer;
                break;
            case VillagerState.FleeingButDazed:
                State = VillagerState.FleeToHome;
                break;
            default:
                break;
        }
        incapacitate = false;
        _animator.SetBool("KnockedOut", false);
    }

    void Attack()
    {
        if (_animator.GetBool("Melee2")) { return; }
        _animator.SetBool("Melee2", true);
        nma.speed = 0f;
        Invoke("AttackEnd", 1f);
    }

    void AttackEnd()
    {
        _animator.SetBool("Melee2", false);
        nma.speed = speedWalkRun.y;
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

    private void OnTriggerEnter(Collider other)
    {
        
        if (other.CompareTag("Fist"))
        {
            if (_thirdPersonController._currentAnimation == "Punching_Left" || _thirdPersonController._currentAnimation == "Punching_Right")
            {
                meleeHitCount++;
            }
            if (_thirdPersonController._currentAnimation == "Pickup" && (AmICarryable() || _carryMeSenpai != null))
            {
                SetCarriedState(GameManager.playerTransform, new Vector3(0f, 0f, 0f));
            }
        }
        else if (other.CompareTag("SacrificialSite"))
        {
            inOfferingRange = other.GetComponent<SacrificialSite>();
        }
    }

    private void OnTriggerExit(Collider other)
    {
        if (other.CompareTag("SacrificialSite"))
        {
            inOfferingRange = null;
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
            if (state != VillagerState.LookingForPlayer) { yield break; }
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
        return (state == VillagerState.Incapacitated || state == VillagerState.FleeingButDazed || state == VillagerState.AttackingButDazed) && _carryMeSenpai == null;
    }

    public void SetCarriedState(Transform toAttachTo, Vector3 offset = default)
    {
        if (!AmICarryable() || GameManager.controller.heldPerson != null) { return; }
        _carryMeSenpai = toAttachTo;
        _safeDistanceFromSenpai = offset;
        GameManager.controller.heldPerson = this;
        if (_rigidbody != null) { _rigidbody.isKinematic = true; }
    }

    public void ReleaseCarriedState(bool sacrifice = false)
    { 
        _carryMeSenpai = null;
        GameManager.controller.heldPerson = null;
        if (_rigidbody != null) { _rigidbody.isKinematic = false; }
        if (inOfferingRange != null && sacrifice) { inOfferingRange.Sacrifice(this); }
    }

    public bool AmIInteractable()
    {
        return (AmICarryable() || _carryMeSenpai != null);
    }

    public void Interact()
    {
        if (AmICarryable()) { SetCarriedState(GameManager.playerTransform, new Vector3(0f, 0f, 0f)); }
        else { ReleaseCarriedState(); }
    }

}
