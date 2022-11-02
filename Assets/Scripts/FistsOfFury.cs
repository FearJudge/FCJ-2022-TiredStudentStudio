using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FistsOfFury : MonoBehaviour
{
    public int toHit;
    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.layer == toHit) { Destroy(other.gameObject); }
    }
}
