using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GhostlySpawner : MonoBehaviour
{
    float timer = 0f;
    public float timerToSpawn = 15f;
    public Vector3 range;
    public GameObject ghost;
    public Transform parent;

    // Update is called once per frame
    void Update()
    {
        timer += Time.deltaTime;
        if (timer >= timerToSpawn) { timer -= timerToSpawn; Spawn(); }
    }

    void Spawn()
    {
        Instantiate(ghost, new Vector3(Random.Range(-range.x, range.x), Random.Range(-range.y, range.y), Random.Range(-range.z, range.z)), Quaternion.identity, parent);
    }
}
