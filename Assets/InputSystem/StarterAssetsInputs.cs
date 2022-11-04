using UnityEngine;
#if ENABLE_INPUT_SYSTEM && STARTER_ASSETS_PACKAGES_CHECKED
using UnityEngine.InputSystem;
#endif

namespace StarterAssets
{
	public class StarterAssetsInputs : MonoBehaviour
	{
		[Header("Character Input Values")]
		public Vector2 move;
		public Vector2 look;
		public bool jump;
		public bool sprint;
		public bool melee;
		public bool crouch;
		public bool interact;
        public bool show;
        public bool escape;

		[Header("Movement Settings")]
		public bool analogMovement;

		[Header("Mouse Cursor Settings")]
		public bool cursorLocked = true;
		public bool cursorInputForLook = true;

#if ENABLE_INPUT_SYSTEM && STARTER_ASSETS_PACKAGES_CHECKED
		public void OnMove(InputValue value)
		{
			MoveInput(value.Get<Vector2>());
		}

		public void OnLook(InputValue value)
		{
			if(cursorInputForLook)
			{
				LookInput(value.Get<Vector2>());
			}
		}

		public void OnJump(InputValue value)
		{
			JumpInput(value.isPressed);
		}

		public void OnSprint(InputValue value)
		{
			SprintInput(value.isPressed);
		}
        //Lisätty melee input -SY
        public void OnMelee(InputValue value)
		{
			MeleeInput(value.isPressed);
		}
        //Lisätty crouching input -SY
        public void OnCrouch(InputValue value)
		{
			CrouchInput(value.isPressed);
		}
        //Lisätty interact input -SY
        public void OnInteract(InputValue value)
		{
			InteractInput(value.isPressed);
		}
        public void OnShow(InputValue value)
        {
            ShowInput(value.isPressed);
        }
        public void OnEscape(InputValue escape)
        {
            EscapeInput(escape.isPressed);
        }

#endif


		public void MoveInput(Vector2 newMoveDirection)
		{
			move = newMoveDirection;
		} 

		public void LookInput(Vector2 newLookDirection)
		{
			look = newLookDirection;
		}

		public void JumpInput(bool newJumpState)
		{
			jump = newJumpState;
		}

		public void SprintInput(bool newSprintState)
		{
			sprint = newSprintState;
		}
		//Lisätty melee input -SY
		public void MeleeInput(bool newMeleeState)
		{
			melee = newMeleeState;
		}
		//Lisätty crouching input -SY
		public void CrouchInput(bool newCrouchState)
		{
			crouch = newCrouchState;
		}
		//Lisätty interact input -SY
		public void InteractInput(bool newInteractState)
		{
			interact = newInteractState;
		}
        public void ShowInput(bool newShowState)
        {
            show = newShowState;
        }
        public void EscapeInput(bool escapeState)
        {
            escape = escapeState;
        }

		private void OnApplicationFocus(bool hasFocus)
		{
			SetCursorState(cursorLocked);
		}

		private void SetCursorState(bool newState)
		{
			Cursor.lockState = newState ? CursorLockMode.Locked : CursorLockMode.None;
		}
	}
	
}