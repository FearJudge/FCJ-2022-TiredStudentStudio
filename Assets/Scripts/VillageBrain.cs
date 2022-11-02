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
    public Transform[] spawnPoints;
    public static Dictionary<string, Transform> locationDict = new Dictionary<string, Transform>();
    public Transform player;

    public List<NPCLogic.VillagerTask> randomSetOfTasksToGenerate;

    public GameObject npcPrefab;

    private string[] _firstNameArray = new string[]
    {
        "Michael", "David", "John", "James", "Robert", "Mark", "William", "Richard", "Thomas", "Jeffrey",
        "Steven", "Joseph", "Timothy", "Kevin", "Scott", "Brian", "Charles", "Paul", "Daniel", "Christopher"

    };
    private string[] _lastNameArray = new string[]
    {
        "Smith", "Johnson", "Williams", "Jones", "Brown", "Davis", "Miller", "Wilson", "Moore", "Taylor",
        "Anderson", "Thomas", "Jackson", "White", "Harris", "Martin", "Thompson", "Garcia", "Martinez", "Clark"
    };


    void Awake()
    {
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
        }
    }

    public void GatherLocations()
    {
        locationDict.Clear();
        for (int a = 0; a < pointsOfInterest.Length; a++)
        {
            locationDict.Add(pointsOfInterest[a].name, pointsOfInterest[a]);
        }
    }

    public string GenerateName()
    {
        return _firstNameArray[Random.Range(0, _firstNameArray.Length)] + " " + _lastNameArray[Random.Range(0, _lastNameArray.Length)];
    }

    public List<NPCLogic.VillagerTask> GenerateRandomTasks()
    {
        int _minimumTimeAdd = 70;
        int _maximumTimeAdd = 190;
        List<NPCLogic.VillagerTask> tasks = new List<NPCLogic.VillagerTask>();
        int index = 0;
        int time = 0;
        while (time < LOOPENDTIME)
        {
            tasks.Add(new NPCLogic.VillagerTask(randomSetOfTasksToGenerate[Random.Range(0, randomSetOfTasksToGenerate.Count)]));
            tasks[index].taskStartAt = time;
            time += Random.Range(_minimumTimeAdd, _maximumTimeAdd);
            index++;
        }
        return tasks;
    }
}
