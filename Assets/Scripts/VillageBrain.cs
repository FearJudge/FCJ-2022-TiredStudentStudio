using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class VillageBrain : MonoBehaviour
{
    public NPCLogic[] allVillagers = new NPCLogic[0];
    public static int loopTime = 0; // Goes up to 60*24 = 1440, then loops. This does not have to represent time of day, just the logic of Villagers.
    public float waitPerTick = 0.06f;
    public const int LOOPENDTIME = 1440;
    public Transform[] pointsOfInterest;
    public static Dictionary<string, Transform> locationDict = new Dictionary<string, Transform>();
    public Transform player;

    void Awake()
    {
        GatherLocations();
        StartCoroutine(TimeStep());
    }

    IEnumerator TimeStep()
    {
        loopTime = 0;
        while (gameObject != null)
        {
            yield return new WaitForSeconds(waitPerTick);
            loopTime++;
            if (loopTime > LOOPENDTIME) { loopTime = 0; }
            Debug.Log(loopTime);
        }
    }

    void GatherLocations()
    {
        locationDict.Clear();
        for (int a = 0; a < pointsOfInterest.Length; a++)
        {
            locationDict.Add(pointsOfInterest[a].name, pointsOfInterest[a]);
        }
    }
}
