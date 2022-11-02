using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyVision : MonoBehaviour
{
    public float maximumDistanceToSee = 3f;
    public float maximumDistanceToSeeCrouched = 2f;
    public string tagToFind;
    public string enemyTag;
    public GameObject mainBody;
    public Vector3 stdOffset = new Vector3(0f, 1f, 0f);
    public LayerMask lm;

    public bool inVision;
    public bool isAlly;
    public float visionStrength = 0f;
    private float _mult = 3.6f;
    public Vector3 lastSeen;

    private void OnTriggerStay(Collider other)
    {
        void CheckPlayer()
        {
            float seeDistance = 0f;
            switch (GameManager.controller.crouched)
            {
                case true:
                    seeDistance = maximumDistanceToSeeCrouched;
                    break;
                default:
                    seeDistance = maximumDistanceToSee;
                    break;
            }

            Ray castRay = new Ray(mainBody.transform.position + stdOffset, other.transform.position - mainBody.transform.position);
            bool saw = Physics.Raycast(castRay, out RaycastHit info, seeDistance, lm);
            if (saw && info.transform.tag == tagToFind) { inVision = true; isAlly = false; lastSeen = info.point; visionStrength = (1.01f * _mult) - ((info.distance / maximumDistanceToSee) * _mult) + 0.2f; }
        }

        void CheckOnAlly()
        {
            float seeDistance = maximumDistanceToSeeCrouched;

            Ray castRay = new Ray(mainBody.transform.position + stdOffset, other.transform.position - mainBody.transform.position);
            bool saw = Physics.Raycast(castRay, out RaycastHit info, seeDistance, lm);
            if (saw && info.transform.tag == enemyTag)
            {
                NPCLogic ally = info.transform.GetComponent<NPCLogic>();
                if (ally.State == NPCLogic.VillagerState.AttackingButDazed || ally.State == NPCLogic.VillagerState.FleeingButDazed || ally.State == NPCLogic.VillagerState.Incapacitated)
                {
                    inVision = true;
                    isAlly = true;
                    lastSeen = info.point;
                    visionStrength = (1.01f * _mult) - ((info.distance / maximumDistanceToSee) * _mult) + 0.2f;
                }
            }
        }
        switch (other.tag)
        {
            case string p when (p == tagToFind):
                CheckPlayer();
                break;
            case string p when (p == enemyTag):
                CheckOnAlly();
                break;
            default:
                break;
        }
    }

    private void OnTriggerExit(Collider other)
    {
        if (other.tag != tagToFind) { return; }
        if (!inVision) { return; }
        inVision = false;
    }
}
