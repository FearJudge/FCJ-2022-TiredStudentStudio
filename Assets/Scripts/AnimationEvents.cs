using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AnimationEvents : MonoBehaviour
{
    public StarterAssets.ThirdPersonController tpc;

    private void OnFootstep(AnimationEvent animationEvent)
    {
        tpc.OnFootstep(animationEvent);
    }

    private void OnLand(AnimationEvent animationEvent)
    {
        tpc.OnLand(animationEvent);
    }

    private void OnCollapse(AnimationEvent animationEvent)
    {
        tpc.OnCollapse(animationEvent);
    }
}
