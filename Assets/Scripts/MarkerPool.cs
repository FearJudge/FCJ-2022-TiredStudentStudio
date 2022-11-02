using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MarkerPool : ObjectPool
{
    public Transform player;

    public void Start()
    {
        foreach (GameObject g in getAllPooledObjects())
        {
            LookAtMeAllwaysSenpai la = g.GetComponent<LookAtMeAllwaysSenpai>();
            la.Initialize(this, player);
        }
    }

    public LookAtMeAllwaysSenpai GetPooledObjectComponent(Transform target)
    {
        GameObject g = GetPooledObject();
        LookAtMeAllwaysSenpai a = g.GetComponent<LookAtMeAllwaysSenpai>();
        a.Set(target);
        return a;
    }

    protected override GameObject AddNewObjectToPool(bool activate = false)
    {
        GameObject g = base.AddNewObjectToPool(activate); ;
        LookAtMeAllwaysSenpai la = g.GetComponent<LookAtMeAllwaysSenpai>();
        la.Initialize(this, player);
        return g;
    }
}
