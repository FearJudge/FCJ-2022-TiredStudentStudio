using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class GhostNPC : MonoBehaviour
{

    public NavMeshAgent nma;
    public Transform target;
    public float retargetTime = 0.35f;

    // Start is called before the first frame update
    void Start()
    {
        target = GameManager.playerTransform;
        StartCoroutine(LoopingCheck());
    }

    // Update is called once per frame
    IEnumerator LoopingCheck()
    {
        nma.enabled = true;
        while (gameObject != null)
        {
            nma.destination = target.position;
            yield return new WaitForSeconds(retargetTime);
        }
    }

    IEnumerator Possess(GameObject other)
    {
        yield return new WaitForSeconds(0.2f);
        if (gameObject != null)
        {
            other.GetComponent<StarterAssets.ThirdPersonController>().Damage();
            Destroy(gameObject);
        }
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.tag == "Fist") { Destroy(gameObject); }
        else if (other.tag == "Player")
        {
            StartCoroutine(Possess(other.gameObject));
        }
    }
}
