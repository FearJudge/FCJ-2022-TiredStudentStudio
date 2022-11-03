﻿using UnityEngine;
#if ENABLE_INPUT_SYSTEM && STARTER_ASSETS_PACKAGES_CHECKED
using UnityEngine.InputSystem;
#endif

/* Note: animations are called via the controller for both the character and capsule using animator null checks
 */

namespace StarterAssets
{
    [RequireComponent(typeof(CharacterController))]
#if ENABLE_INPUT_SYSTEM && STARTER_ASSETS_PACKAGES_CHECKED
    [RequireComponent(typeof(PlayerInput))]
#endif
    public class ThirdPersonController : MonoBehaviour
    {
        [Header("Player")]
        [Tooltip("Move speed of the character in m/s")]
        public float MoveSpeed = 2.0f;

        [Tooltip("Sprint speed of the character in m/s")]
        public float SprintSpeed = 5.335f;

        [Tooltip("How fast the character turns to face movement direction")]
        [Range(0.0f, 0.3f)]
        public float RotationSmoothTime = 0.12f;

        [Tooltip("Acceleration and deceleration")]
        public float SpeedChangeRate = 10.0f;

        public AudioClip LandingAudioClip;
        public AudioClip[] FootstepAudioClips;
        [Range(0, 1)] public float FootstepAudioVolume = 0.5f;

        [Space(10)]
        [Tooltip("The height the player can jump")]
        public float JumpHeight = 1.2f;

        [Tooltip("The character uses its own gravity value. The engine default is -9.81f")]
        public float Gravity = -15.0f;

        [Space(10)]
        [Tooltip("Time required to pass before being able to jump again. Set to 0f to instantly jump again")]
        public float JumpTimeout = 0.50f;

        [Tooltip("Time required to pass before entering the fall state. Useful for walking down stairs")]
        public float FallTimeout = 0.15f;

        [Header("Player Grounded")]
        [Tooltip("If the character is grounded or not. Not part of the CharacterController built in grounded check")]
        public bool Grounded = true;

        [Tooltip("Useful for rough ground")]
        public float GroundedOffset = -0.14f;

        [Tooltip("The radius of the grounded check. Should match the radius of the CharacterController")]
        public float GroundedRadius = 0.28f;

        [Tooltip("What layers the character uses as ground")]
        public LayerMask GroundLayers;

        [Header("Cinemachine")]
        [Tooltip("The follow target set in the Cinemachine Virtual Camera that the camera will follow")]
        public GameObject CinemachineCameraTarget;

        [Tooltip("How far in degrees can you move the camera up")]
        public float TopClamp = 70.0f;

        [Tooltip("How far in degrees can you move the camera down")]
        public float BottomClamp = -30.0f;

        [Tooltip("Additional degress to override the camera. Useful for fine tuning camera position when locked")]
        public float CameraAngleOverride = 0.0f;

        [Tooltip("For locking the camera position on all axis")]
        public bool LockCameraPosition = false;

        public bool crouched = false;
        public bool dead = false;
        public PlayerHudManager hud;
        private int health = 100;
        public int Health
            {
                get { return health; }
                set { health = value; hud.DrawPlayerHP(health, _maxHealth); }
            }
        private const int _maxHealth = 100;
        bool heldMelee;

        // cinemachine
        private float _cinemachineTargetYaw;
        private float _cinemachineTargetPitch;

        // player
        #region
        private float _speed;
        private float _animationBlend;
        private float _targetRotation = 0.0f;
        private float _rotationVelocity;
        private float _verticalVelocity;
        private float _terminalVelocity = 53.0f;
        #endregion
        // timeout deltatime
        private float _jumpTimeoutDelta;
        private float _fallTimeoutDelta;

        // animation IDs
        #region
        private int _animIDSpeed;
        private int _animIDGrounded;
        private int _animIDJump;
        private int _animIDFreeFall;
        private int _animIDMotionSpeed;
        private int _animIDMelee;
        private int _animIDInteract;
        private int _animIDCrouching;
        #endregion

        // melee attack components
        #region
        public int meleeHitCount;

        [SerializeField] private SphereCollider _fistColLeft; 
        [SerializeField] private SphereCollider _fistColRight;
        #endregion

        Collider[] bodyCheckPosX;
        Collider[] bodyCheckNegX;
        Collider[] bodyCheckPosZ;
        Collider[] bodyCheckNegZ;

        public NPCLogic heldPerson;

#if ENABLE_INPUT_SYSTEM && STARTER_ASSETS_PACKAGES_CHECKED
        private PlayerInput _playerInput;
#endif
        [SerializeField] private Animator _animator;
        private CharacterController _controller;
        public StarterAssetsInputs _input;
        private Transform _mainCamera;

        private const float _threshold = 0.01f;

        private bool _hasAnimator;

        private AnimatorClipInfo[] animatorClipInfo;
        public string _currentAnimation;

        private bool IsCurrentDeviceMouse
        {
            get
            {
#if ENABLE_INPUT_SYSTEM && STARTER_ASSETS_PACKAGES_CHECKED
                return _playerInput.currentControlScheme == "KeyboardMouse";
#else
				return false;
#endif
            }
        }


        private void Awake()
        {
            _mainCamera = Camera.main.transform;
            SacrificialSite.Tribute += SuccessfulSacrifice;
            SacrificialSite.PointlessSacrifice += FailedSacrifice;
        }

        private void OnDestroy()
        {
            SacrificialSite.Tribute -= SuccessfulSacrifice;
            SacrificialSite.PointlessSacrifice -= FailedSacrifice;
        }

        private void Start()
        {
            _cinemachineTargetYaw = CinemachineCameraTarget.transform.rotation.eulerAngles.y;

            _hasAnimator = true;
            _controller = GetComponent<CharacterController>();
            _input = GetComponent<StarterAssetsInputs>();
#if ENABLE_INPUT_SYSTEM && STARTER_ASSETS_PACKAGES_CHECKED
            _playerInput = GetComponent<PlayerInput>();
#else
			Debug.LogError( "Starter Assets package is missing dependencies. Please use Tools/Starter Assets/Reinstall Dependencies to fix it");
#endif

            AssignAnimationIDs();

            // reset our timeouts on start
            _jumpTimeoutDelta = JumpTimeout;
            _fallTimeoutDelta = FallTimeout;
        }

        private void Update()
        {
            animatorClipInfo = _animator.GetCurrentAnimatorClipInfo(0);
            if (animatorClipInfo.Length > 0) { _currentAnimation = animatorClipInfo[0].clip.name; }
            GroundedCheck();
            JumpAndGravity();
            if (dead) { return; }
            if (!_animator.GetCurrentAnimatorStateInfo(0).IsName("Interact") && !_animator.GetCurrentAnimatorStateInfo(0).IsName("Punching_Left") && !_animator.GetCurrentAnimatorStateInfo(0).IsName("Punching_Right"))
            {
                Move();
            }
            MeleeCheck();
            InteractCheck();
            CrouchCheck();
        }


        // Hacky workaround for the input system error, need to check if this causes
        // problems with retrying etc.
        private void OnDisable()
        {
            _playerInput.actions = null;
        }
        private void CrouchCheck()
        {
            if (_hasAnimator)
            {
                if (_input.crouch && heldPerson == null)
                {
                    _animator.SetBool(_animIDCrouching, true);
                    crouched = true;
                }
                else
                {
                    _animator.SetBool(_animIDCrouching, false);
                    crouched = false;
                }
            }

        }

        private void InteractCheck()
        {
            if (_hasAnimator)
            {
                if (_input.interact)
                {
                    if (heldPerson != null) { heldPerson.ReleaseCarriedState(true); }
                    _animator.SetBool(_animIDInteract, true);
                }
                else
                {
                    _animator.SetBool(_animIDInteract, false);
                }
                if (_input.show)
                {
                    hud.DisplayCards(true);
                }
                else
                {
                    hud.DisplayCards(false);
                }
            }
        }

        private void MeleeCheck()
        {
            if (_animator.GetCurrentAnimatorStateInfo(0).IsName("Punching_Right"))
            {
                _fistColRight.enabled = true;
                _fistColLeft.enabled = false;
            }
            else if (_animator.GetCurrentAnimatorStateInfo(0).IsName("Punching_Left"))
            {
                _fistColRight.enabled = false;
                _fistColLeft.enabled = true;
            }
            else if (_animator.GetCurrentAnimatorStateInfo(0).IsName("Interact") && _animator.GetCurrentAnimatorStateInfo(0).normalizedTime <= 0.5f)
            {
                _fistColRight.enabled = true;
                _fistColLeft.enabled = false;
            }
            else
            {
                _fistColRight.enabled = false;
                _fistColLeft.enabled = false;
            }

            if (_hasAnimator)
            {
                if (heldPerson != null) { _input.melee = false; }
                if (_input.melee && !heldMelee)
                {
                    _animator.SetTrigger(_animIDMelee);
                    heldMelee = true;
                }
                else if (!_input.melee)
                {
                    heldMelee = false;
                }
            }
        }

        private void LateUpdate()
        {
            CameraRotation();
        }

        private void AssignAnimationIDs()
        {
            _animIDSpeed = Animator.StringToHash("Speed");
            _animIDGrounded = Animator.StringToHash("Grounded");
            _animIDJump = Animator.StringToHash("Jump");
            _animIDFreeFall = Animator.StringToHash("FreeFall");
            _animIDMotionSpeed = Animator.StringToHash("MotionSpeed");
            _animIDMelee = Animator.StringToHash("Melee");
            _animIDInteract = Animator.StringToHash("Interact");
            _animIDCrouching = Animator.StringToHash("Crouch");
        }

        private void GroundedCheck()
        {
            // set sphere position, with offset
            Vector3 spherePosition = new Vector3(transform.position.x, transform.position.y - GroundedOffset,
                transform.position.z);
            Grounded = Physics.CheckSphere(spherePosition, GroundedRadius, GroundLayers,
                QueryTriggerInteraction.Ignore);

            // update animator if using character
            if (_hasAnimator)
            {
                _animator.SetBool(_animIDGrounded, Grounded);
            }
        }

        private void CameraRotation()
        {
            // if there is an input and camera position is not fixed
            if (_input.look.sqrMagnitude >= _threshold && !LockCameraPosition)
            {
                //Don't multiply mouse input by Time.deltaTime;
                float deltaTimeMultiplier = IsCurrentDeviceMouse ? 1.0f : Time.deltaTime;

                _cinemachineTargetYaw += _input.look.x * deltaTimeMultiplier;
                _cinemachineTargetPitch += _input.look.y * deltaTimeMultiplier;
            }

            // clamp our rotations so our values are limited 360 degrees
            _cinemachineTargetYaw = ClampAngle(_cinemachineTargetYaw, float.MinValue, float.MaxValue);
            _cinemachineTargetPitch = ClampAngle(_cinemachineTargetPitch, BottomClamp, TopClamp);

            // Cinemachine will follow this target
            CinemachineCameraTarget.transform.rotation = Quaternion.Euler(_cinemachineTargetPitch + CameraAngleOverride,
                _cinemachineTargetYaw, 0.0f);
        }

        private void Move()
        {
            // set target speed based on move speed, sprint speed and if sprint is pressed
            float targetSpeed = _input.sprint ? SprintSpeed : MoveSpeed;

            // a simplistic acceleration and deceleration designed to be easy to remove, replace, or iterate upon

            // note: Vector2's == operator uses approximation so is not floating point error prone, and is cheaper than magnitude
            // if there is no input, set the target speed to 0
            if (_input.move == Vector2.zero) targetSpeed = 0.0f;

            // a reference to the players current horizontal velocity
            float currentHorizontalSpeed = new Vector3(_controller.velocity.x, 0.0f, _controller.velocity.z).magnitude;

            float speedOffset = 0.1f;
            float inputMagnitude = _input.analogMovement ? _input.move.magnitude : 1f;

            // accelerate or decelerate to target speed
            if (currentHorizontalSpeed < targetSpeed - speedOffset ||
                currentHorizontalSpeed > targetSpeed + speedOffset)
            {
                // creates curved result rather than a linear one giving a more organic speed change
                // note T in Lerp is clamped, so we don't need to clamp our speed
                _speed = Mathf.Lerp(currentHorizontalSpeed, targetSpeed * inputMagnitude,
                    Time.deltaTime * SpeedChangeRate);

                // round speed to 3 decimal places
                _speed = Mathf.Round(_speed * 1000f) / 1000f;
            }
            else
            {
                _speed = targetSpeed;
            }

            _animationBlend = Mathf.Lerp(_animationBlend, targetSpeed, Time.deltaTime * SpeedChangeRate);
            if (_animationBlend < 0.01f) _animationBlend = 0f;

            // normalise input direction
            Vector3 inputDirection = new Vector3(_input.move.x, 0.0f, _input.move.y).normalized;

            // note: Vector2's != operator uses approximation so is not floating point error prone, and is cheaper than magnitude
            // if there is a move input rotate player when the player is moving
            if (_input.move != Vector2.zero)
            {
                _targetRotation = Mathf.Atan2(inputDirection.x, inputDirection.z) * Mathf.Rad2Deg +
                                  _mainCamera.eulerAngles.y;
                float rotation = Mathf.SmoothDampAngle(transform.eulerAngles.y, _targetRotation, ref _rotationVelocity,
                    RotationSmoothTime);

                // rotate to face input direction relative to camera position
                transform.rotation = Quaternion.Euler(0.0f, rotation, 0.0f);
            }


            Vector3 targetDirection = Quaternion.Euler(0.0f, _targetRotation, 0.0f) * Vector3.forward;
            ColliderSet();
            float strength = 0.012f * _speed;
            if (bodyCheckNegX.Length > 0)
            {
                transform.position += new Vector3(1f ,0f, 0f) * strength;
            }
            if (bodyCheckPosX.Length > 0)
            {
                transform.position += new Vector3(-1f, 0f, 0f) * strength;
            }
            if (bodyCheckNegZ.Length > 0)
            {
                transform.position += new Vector3(0f, 0f, 1f) * strength;
            }
            if (bodyCheckPosZ.Length > 0)
            {
                transform.position += new Vector3(0f, 0f, -1f) * strength;
            }
            if (bodyCheckNegZ.Length + bodyCheckPosZ.Length + bodyCheckPosX.Length + bodyCheckNegX.Length < 2)
            {
                // move the player
                _controller.Move(targetDirection.normalized * (_speed * Time.deltaTime) +
                                 new Vector3(0.0f, _verticalVelocity, 0.0f) * Time.deltaTime);
            }
            else if (bodyCheckNegZ.Length + bodyCheckPosZ.Length + bodyCheckPosX.Length + bodyCheckNegX.Length >= 4)
            {
                transform.position += new Vector3(Random.Range(-1f, 1f), 0f, Random.Range(-1f, 1f)) * strength;
            }


            // update animator if using character
            if (_hasAnimator)
            {
                _animator.SetFloat(_animIDSpeed, _animationBlend);
                _animator.SetFloat(_animIDMotionSpeed, inputMagnitude);
            }
        }

        void ColliderSet()
        {
            float height = 1.4f;
            float bodyCollSize = 0.45f + Time.deltaTime * _speed;
            Vector3 bodyBox = new Vector3(0.45f, 0.8f, 0.45f);
            bodyCheckPosX = Physics.OverlapBox(new Vector3((transform.position.x + bodyCollSize), transform.position.y + height, transform.position.z), bodyBox, Quaternion.identity, GroundLayers);
            bodyCheckNegX = Physics.OverlapBox(new Vector3((transform.position.x - bodyCollSize), transform.position.y + height, transform.position.z), bodyBox, Quaternion.identity, GroundLayers);
            bodyCheckPosZ = Physics.OverlapBox(new Vector3(transform.position.x, transform.position.y + height, (transform.position.z + bodyCollSize)), bodyBox, Quaternion.identity, GroundLayers);
            bodyCheckNegZ = Physics.OverlapBox(new Vector3(transform.position.x, transform.position.y + height, (transform.position.z - bodyCollSize)), bodyBox, Quaternion.identity, GroundLayers);
        }

        private void JumpAndGravity()
        {
            if (Grounded)
            {
                if (heldPerson != null) { _input.jump = false; }
                // reset the fall timeout timer
                _fallTimeoutDelta = FallTimeout;

                // update animator if using character
                if (_hasAnimator)
                {
                    _animator.SetBool(_animIDJump, false);
                    _animator.SetBool(_animIDFreeFall, false);
                }

                // stop our velocity dropping infinitely when grounded
                if (_verticalVelocity < 0.0f)
                {
                    _verticalVelocity = -2f;
                }

                // Jump
                if (_input.jump && _jumpTimeoutDelta <= 0.0f)
                {
                    // the square root of H * -2 * G = how much velocity needed to reach desired height
                    _verticalVelocity = Mathf.Sqrt(JumpHeight * -2f * Gravity);

                    // update animator if using character
                    if (_hasAnimator)
                    {
                        _animator.SetBool(_animIDJump, true);
                    }

                }

                // jump timeout
                if (_jumpTimeoutDelta >= 0.0f)
                {
                    _jumpTimeoutDelta -= Time.deltaTime;
                }
            }
            else
            {
                // reset the jump timeout timer
                _jumpTimeoutDelta = JumpTimeout;

                // fall timeout
                if (_fallTimeoutDelta >= 0.0f)
                {
                    _fallTimeoutDelta -= Time.deltaTime;
                }
                else
                {
                    // update animator if using character
                    if (_hasAnimator)
                    {
                        _animator.SetBool(_animIDFreeFall, true);
                    }
                }

                // if we are not grounded, do not jump
                _input.jump = false;
            }

            // apply gravity over time if under terminal (multiply by delta time twice to linearly speed up over time)
            if (_verticalVelocity < _terminalVelocity)
            {
                _verticalVelocity += Gravity * Time.deltaTime;
            }
        }

        private static float ClampAngle(float lfAngle, float lfMin, float lfMax)
        {
            if (lfAngle < -360f) lfAngle += 360f;
            if (lfAngle > 360f) lfAngle -= 360f;
            return Mathf.Clamp(lfAngle, lfMin, lfMax);
        }

        private void OnDrawGizmosSelected()
        {
            Color transparentGreen = new Color(0.0f, 1.0f, 0.0f, 0.35f);
            Color transparentRed = new Color(1.0f, 0.0f, 0.0f, 0.35f);

            if (Grounded) Gizmos.color = transparentGreen;
            else Gizmos.color = transparentRed;

            // when selected, draw a gizmo in the position of, and matching radius of, the grounded collider
            Gizmos.DrawSphere(
                new Vector3(transform.position.x, transform.position.y - GroundedOffset, transform.position.z),
                GroundedRadius);
        }

        public void OnFootstep(AnimationEvent animationEvent)
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

        public void OnLand(AnimationEvent animationEvent)
        {
            if (animationEvent.animatorClipInfo.weight > 0.5f)
            {
                AudioSource.PlayClipAtPoint(LandingAudioClip, transform.TransformPoint(_controller.center), FootstepAudioVolume);
            }
        }

        private void OnTriggerEnter(Collider other)
        {
            if (other.CompareTag("Hurting"))
            {
                Health -= 5;
            }
        }

        private void OnTriggerStay(Collider other)
        {
            if (other.CompareTag("SacrificialSite"))
            {
                SacrificialSite ss = other.GetComponent<SacrificialSite>();
                if (heldPerson == null) { hud.DisplayMessage(ss.siteUnheldMessages[(int)ss.typeOfSite]); }
                else { hud.DisplayMessage(ss.siteHeldMessages[(int)ss.typeOfSite]); }
            }
        }

        public void Damage()
        {
            Health -= 5;
        }

        public void ReleaseMouse()
        {
            dead = true;
            _animator.SetBool("KnockedOut", true);
            _input.cursorLocked = false;
            _input.cursorInputForLook = false;
            Cursor.lockState = CursorLockMode.None;
        }

        public void FailedSacrifice(NPCLogic.HauntedBy haunt, SacrificialSite.SacrificeSite site)
        {
            Damage();
            if (haunt == NPCLogic.HauntedBy.None) { hud.DisplayMessage("Iku-Valr is displeased with your time wasting", 6); }
            else { hud.DisplayMessage("This method will not exorcise the competing spirit", 6); }
        }

        public void SuccessfulSacrifice(NPCLogic.HauntedBy haunt, SacrificialSite.SacrificeSite site)
        {
            hud.DisplayMessage("One of the competing spirits has left this realm.", 6);
        }
    }
}