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
        LookingAround
    }

    public enum VillagerSuspicion
    {
        Neutral,
        ThoughtISawSomething,
        ThoughtIHeardSomething,
        ISawThePlayer,
        Panic
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
    public Collider[] hitBoxes;

    public AudioClip[] FootstepAudioClips;
    [Range(0, 1)] public float FootstepAudioVolume;
    public AudioClip LandingAudioClip;
    public AudioClip CollapseAudioClip;
    public AudioClip[] DraggingAudioClips;
    public AudioClip FistAudioClip;
    public LookAtMeAllwaysSenpai marker;
    public float targetRadius = 2f;

    private const float _waitLookAround = 7f;
    private const int _lookAroundSteps = 5;
    private const float _lookAroundRange = 1f;
    private const float _sightRequired = 1.3f;
    private float moveSpeed = 3f;
    private float _sightToPlayer = 0f;
    private int _shadowsToChase = 0;
    private const int _shadowsSeenWhenDelirious = 6;
    private float _timeKnockedOut = 0f;
    private float _dragNoiseTime = 0.2f;
    private const float _gripStrength = 0.2f;
    private Animator _animator;
    private bool _hasAnimator;
    private CharacterController _controller;

    private Rigidbody _rigidbody;
    private Transform _carryMeSenpai;
    private Vector3 _safeDistanceFromSenpai;

    VillagerState state = VillagerState.DoingTasks;
    VillagerSuspicion playerKnowledge = VillagerSuspicion.Neutral;

    public bool incapacitate;

    public int maxTimeToIncapacitate = 4;
    private int _hitsToKnockout = 1;
    private int _hitsToKnockoutAlert = 2;
    public float meleeTimer;
    public int meleeHitCount;
    public ParticleSystem hauntedParticles;
    ParticleSystem.MainModule psmm;

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
        for (int a = 0; a < hitBoxes.Length; a++) { hitBoxes[a].enabled = false; }
        psmm = hauntedParticles.main;
        switch (haunted)
        {
            case HauntedBy.None:
                break;
            case HauntedBy.BlueSpiritOfSorrow:
                psmm.startColor = Color.blue;
                hauntedParticles.Play();
                break;
            case HauntedBy.RedSpiritOfHatred:
                psmm.startColor = Color.red;
                hauntedParticles.Play();
                break;
            case HauntedBy.GreenSpiritOfEnvy:
                psmm.startColor = Color.green;
                hauntedParticles.Play();
                break;
        }

        SacrificialSite.Tribute += Exorcise;
        SortTasks();
    }

    void ManageNewState()
    {
        switch (state)
        {
            case VillagerState.DoingTasks:
                meleeHitCount = 0;
                nma.enabled = true;
                moveSpeed = speedWalkRun.x;
                LostInterest?.Invoke(gameObject);
                playerKnowledge = VillagerSuspicion.Neutral;
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
                moveSpeed = speedWalkRun.y;
                break;
            case VillagerState.LookingForPlayer:
                meleeHitCount = 0;
                nma.enabled = true;
                moveSpeed = speedWalkRun.x;
                break;
            case VillagerState.Carried:
                if (nma.enabled) { nma.ResetPath(); }
                nma.enabled = false;
                _animator.SetBool("Carried", true);
                break;
            case VillagerState.FleeToHome:
                NoticedPlayer?.Invoke(gameObject);
                nma.enabled = true;
                moveSpeed = speedWalkRun.y;
                FleeHome();
                break;
            case VillagerState.NervouslyWaiting:
                meleeHitCount = 0;
                nma.enabled = true;
                moveSpeed = speedWalkRun.x;
                break;
            case VillagerState.RunAroundAimlessly:
                meleeHitCount = 0;
                NoticedPlayer?.Invoke(gameObject);
                nma.enabled = true;
                moveSpeed = speedWalkRun.y;
                _shadowsToChase = _shadowsSeenWhenDelirious;
                ChaseShadows();
                break;
            case VillagerState.AttackingButDazed:
                if (nma.enabled) { nma.ResetPath(); }
                nma.enabled = false;
                LostInterest?.Invoke(gameObject);
                _animator.SetBool("KnockedOut", true);
                _animator.SetBool("Carried", false);
                _timeKnockedOut = 7f;
                break;
            case VillagerState.FleeingButDazed:
                if (nma.enabled) { nma.ResetPath(); }
                nma.enabled = false;
                LostInterest?.Invoke(gameObject);
                _animator.SetBool("KnockedOut", true);
                _animator.SetBool("Carried", false);
                _timeKnockedOut = 7f;
                break;
            case VillagerState.LookingAround:
                meleeHitCount = 0;
                nma.enabled = true;
                moveSpeed = speedWalkRun.x;
                StartCoroutine(Confused());
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

    public void Spot()
    {
        if (state == VillagerState.DoingTasks || state == VillagerState.LookingForPlayer || state == VillagerState.LookingAround)
        {
            playerKnowledge = VillagerSuspicion.ISawThePlayer;
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
            }
        }
    }

    void RaiseSuspicion(bool ally)
    {
        NoticedPlayer?.Invoke(gameObject);
        _sightToPlayer += Time.deltaTime * eyes.visionStrength;
        _sightToPlayer = Mathf.Clamp(_sightToPlayer, 0f, _sightRequired);
        marker.marker.color = new Color(_sightToPlayer / _sightRequired,
            0f,
            playerKnowledge == VillagerSuspicion.Neutral? 1f : 0f,
            Mathf.Clamp(_sightToPlayer / _sightRequired + (playerKnowledge == VillagerSuspicion.Neutral ? 0f : 1f), 0.2f, 1f));

        switch (ally)
        {
            case true:
                if (_sightToPlayer >= _sightRequired && playerKnowledge == VillagerSuspicion.Neutral)
                {
                    playerKnowledge = VillagerSuspicion.ThoughtISawSomething; _sightToPlayer = 0f;
                    State = VillagerState.LookingAround;
                }
                else if (_sightToPlayer >= _sightRequired && playerKnowledge == VillagerSuspicion.ThoughtISawSomething)
                { State = VillagerState.RunAroundAimlessly; playerKnowledge = VillagerSuspicion.Panic; }
                break;
            default:
                if (_sightToPlayer >= _sightRequired && playerKnowledge == VillagerSuspicion.Neutral)
                {
                    playerKnowledge = VillagerSuspicion.ThoughtISawSomething; _sightToPlayer = 0f;
                    State = VillagerState.LookingAround;
                }
                else if (_sightToPlayer >= _sightRequired && playerKnowledge == VillagerSuspicion.ThoughtISawSomething)
                { Spot(); playerKnowledge = VillagerSuspicion.ISawThePlayer; }
                break;
        }
        
    }

    void LowerSuspicion()
    {
        if ((_sightToPlayer == 0 && playerKnowledge == VillagerSuspicion.Neutral) || marker == null) { if (marker != null) { marker.marker.color = Color.clear; } return; }

        _sightToPlayer -= Time.deltaTime;
        _sightToPlayer = Mathf.Clamp(_sightToPlayer, 0f, _sightRequired);
        marker.marker.color = new Color(_sightToPlayer / _sightRequired,
            0f,
            playerKnowledge == VillagerSuspicion.Neutral ? 1f : 0f,
            Mathf.Clamp(_sightToPlayer / _sightRequired + (playerKnowledge == VillagerSuspicion.Neutral ? 0f : 1f), 0.2f, 1f));

        if (_sightToPlayer <= 0f && (playerKnowledge == VillagerSuspicion.Panic || playerKnowledge == VillagerSuspicion.ISawThePlayer))
        { playerKnowledge = VillagerSuspicion.Neutral; _sightToPlayer = _sightRequired * (2f / 3f); }
        else if (_sightToPlayer <= 0f && playerKnowledge == VillagerSuspicion.ThoughtISawSomething)
        { LostInterest?.Invoke(gameObject); }
    }

    private void Update()
    {
        if (_timeKnockedOut > 0f) { _timeKnockedOut -= Time.deltaTime; if (_timeKnockedOut <= 0f) { Recover(); } }
        if (_timeKnockedOut > 0f && _carryMeSenpai != null) { _dragNoiseTime -= Time.deltaTime; if (_dragNoiseTime <= 0f) { MakeDragNoise(); } }
        if (_carryMeSenpai != null && _timeKnockedOut > 0f) { transform.position = _carryMeSenpai.position + _safeDistanceFromSenpai; _timeKnockedOut += Time.deltaTime * _gripStrength; }

        CheckForMeleeLogic();

        if (!nma.enabled) { return; }
        switch (playerKnowledge)
        {
            case VillagerSuspicion.Neutral: nma.speed = moveSpeed; break;
            case VillagerSuspicion.ThoughtISawSomething: nma.speed = 0f; break;
            case VillagerSuspicion.ThoughtIHeardSomething: nma.speed = 0f; break;
            case VillagerSuspicion.ISawThePlayer: nma.speed = moveSpeed; break;
            case VillagerSuspicion.Panic: nma.speed = moveSpeed; break;
            default: break;
        }
        if (eyes.inVision) { RaiseSuspicion(eyes.isAlly); }
        else if (playerKnowledge != VillagerSuspicion.ISawThePlayer && playerKnowledge != VillagerSuspicion.Panic) { LowerSuspicion(); }
        if (nma.remainingDistance <= targetRadius) { ReEvaluate(); }
        
        if (state == VillagerState.AttackingPlayer) { ChasePlayer(); }

        if (_hasAnimator)
        {
            _animator.SetFloat("Speed", nma.velocity.magnitude * ((nma.speed == speedWalkRun.y) ? _speedWalkRunAnim.y : _speedWalkRunAnim.x) / nma.speed);
        }
    }

    void MakeDragNoise()
    {
        AudioSource.PlayClipAtPoint(DraggingAudioClips[Random.Range(0, DraggingAudioClips.Length)], transform.TransformPoint(_controller.center), FootstepAudioVolume);
        _dragNoiseTime = Random.Range(1.3f, 2.4f);
    }

    private void CheckForMeleeLogic()
    {
        void Alert()
        {
            if (meleeHitCount > 0 && meleeTimer > 0)
            {
                meleeTimer -= Time.deltaTime;

                if (meleeHitCount >= _hitsToKnockoutAlert)
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

                if (meleeHitCount >= _hitsToKnockout)
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
        if (_animator.GetCurrentAnimatorStateInfo(0).IsName("Punching_Left")) { return; }
        _animator.SetTrigger("Melee");
        nma.speed = 0f;
        for (int a = 0; a < hitBoxes.Length; a++) { hitBoxes[a].enabled = true; }
        Invoke("AttackEnd", 0.6f);
    }

    void AttackEnd()
    {
        for (int a = 0; a < hitBoxes.Length; a++) { hitBoxes[a].enabled = false; }
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
            if (_thirdPersonController._currentAnimation == "Punching_Left" || _thirdPersonController._currentAnimation == "Swing")
            {
                AudioSource.PlayClipAtPoint(FistAudioClip, transform.TransformPoint(_controller.center), FootstepAudioVolume);
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

    private void OnCollapse(AnimationEvent animationEvent)
    {
        if (animationEvent.animatorClipInfo.weight > 0.5f)
        {
            AudioSource.PlayClipAtPoint(CollapseAudioClip, transform.TransformPoint(_controller.center), FootstepAudioVolume);
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

    IEnumerator Confused()
    {
        for (int a = 0; a < _lookAroundSteps; a++)
        {
            if (state != VillagerState.LookingAround) { yield break; }
            if (!eyes.inVision)
            { nma.destination += new Vector3(Random.Range(-_lookAroundRange, _lookAroundRange), 0f, Random.Range(-_lookAroundRange, _lookAroundRange)); }
            yield return new WaitForSeconds(_waitLookAround / _lookAroundSteps);
        }
        if (state != VillagerState.LookingAround) { yield break; }
        State = VillagerState.DoingTasks;
    }

    IEnumerator LoseFear()
    {
        State = VillagerState.NervouslyWaiting;
        yield return new WaitForSeconds(_waitLookAround);
        if (state != VillagerState.NervouslyWaiting) { yield break; }
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

    public void Exorcise(HauntedBy type, SacrificialSite.SacrificeSite site)
    {
        if (haunted != type) { return; }
        haunted = HauntedBy.None;
        hauntedParticles.Stop();
        killBy = GoalToAchieve.DoNotKill;
    }

    private void OnDestroy()
    {
        SacrificialSite.Tribute -= Exorcise;
        if (marker == null) { return; }
        marker.Unset();
    }
}
