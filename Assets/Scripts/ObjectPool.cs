using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public abstract class ObjectPool : MonoBehaviour
{
    
    private List<GameObject> pool;
    [Header("Object Pooling Properties")]
    public GameObject objectToPool;
    public int poolBaseAmount;
    public Transform spawnParent;

    void Awake()
    {
        InitializeObjectPool();
    }

    protected virtual GameObject AddNewObjectToPool(bool activate=false)
    {
        GameObject tmp;
        tmp = Instantiate(objectToPool, spawnParent);
        tmp.SetActive(false);
        pool.Add(tmp);
        if (activate) { tmp.SetActive(true); }
        return tmp;
    }

    void InitializeObjectPool()
    {
        pool = new List<GameObject>();
        for (int a = 0; a < poolBaseAmount; a++)
        {
            AddNewObjectToPool();
        }
    }

    public virtual GameObject GetPooledObject()
    {
        for (int i = 0; i < pool.Count; i++)
        {
            if (!pool[i].activeInHierarchy)
            {
                pool[i].SetActive(true);
                return pool[i];
            }
        }
        return AddNewObjectToPool(true);
    }

    public List<GameObject> getAllPooledObjects()
    {
        return pool;
    }

    public void DestroyAllBut(GameObject me = null)
    {
        for (int i = 0; i < pool.Count; i++)
        {
            if (pool[i].activeInHierarchy && pool[i] != me)
            {
                pool[i].SetActive(false);
            }
        }
    }
}
