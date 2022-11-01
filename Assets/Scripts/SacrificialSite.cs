using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SacrificialSite : MonoBehaviour
{
    public enum SacrificeSite
    {
        Gallows,         //HIRTTOPUU
        Beheading,       //MESTAUSP�LKKY
        Fire,            //ROVIO
        BreakingWheel,   //TEILAUS
        Well,            //UHRIKAIVO
        Guilliotine,     //GILJOTIINI
        Cliffside,       //JYRK�NNE
        StarvingInCage   //H�KKI
    }

    public SacrificeSite typeOfSite;
    private Collider _collider;
    private Animator _animator;

    // Start is called before the first frame update
    void Awake()
    {
        _collider = GetComponent<Collider>();
        _animator = GetComponent<Animator>();
    }

    public void Sacrifice(NPCLogic villager)
    {
        Destroy(villager.gameObject);
    }
}
