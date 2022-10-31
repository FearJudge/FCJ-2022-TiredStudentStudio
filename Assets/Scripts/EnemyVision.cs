using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyVision : MonoBehaviour
{
    public float maximumDistanceToSee = 1000f;
    public string tagToFind;
    public GameObject mainBody;
    public Vector3 stdOffset = new Vector3(0f, 1f, 0f);
    public LayerMask lm;

    public bool inVision;
    public Vector3 lastSeen;

    private void OnTriggerStay(Collider other)
    {
        if (other.tag != tagToFind) { return; }

        Ray castRay = new Ray(mainBody.transform.position + stdOffset, other.transform.position - mainBody.transform.position);
        bool saw = Physics.Raycast(castRay, out RaycastHit info, maximumDistanceToSee, lm);
        Debug.DrawRay(mainBody.transform.position + stdOffset, other.transform.position - mainBody.transform.position, Color.red, 2f);
        if (saw) { Debug.Log(info.transform.name); }
        if (saw && info.transform.tag == tagToFind) { inVision = true; lastSeen = info.point; Debug.Log(info.transform.tag); }
    }

    private void OnTriggerExit(Collider other)
    {
        if (other.tag != tagToFind) { return; }
        if (!inVision) { return; }
        inVision = false;
    }
}
