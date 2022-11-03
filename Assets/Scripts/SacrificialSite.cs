using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SacrificialSite : MonoBehaviour
{
    public delegate void SacrificeEvent(NPCLogic.HauntedBy type, SacrificeSite site);
    public static event SacrificeEvent Tribute;
    public static event SacrificeEvent PointlessSacrifice;


    public enum SacrificeSite
    {
        Gallows,         //HIRTTOPUU
        Beheading,       //MESTAUSPÖLKKY
        Fire,            //ROVIO
        BreakingWheel,   //TEILAUS
        Well,            //UHRIKAIVO
        Guilliotine,     //GILJOTIINI
        Cliffside,       //JYRKÄNNE
        StarvingInCage   //HÄKKI
    }

    public string[] siteUnheldMessages = new string[]
    {
        "Bring a Villager here to HANG them.",
        "Bring a Villager here to CHOP them.",
        "Bring a Villager here to TORCH them.",
        "Bring a Villager here to BREAK them apart.",
        "Bring a Villager here to DISPOSE of them.",
        "Bring a Villager here to SWIFTLY BEHEAD them.",
        "Bring a Villager here to IMPALE them.",
        "Bring a Villager here to STARVE them."
    };
    public string[] siteHeldMessages = new string[]
    {
        "Release the Villager TO HANG THEM.",
        "Release the Villager TO CHOP THEM.",
        "Release the Villager TO TORCH THEM.",
        "Release the Villager TO BREAK THEM.",
        "Release the Villager TO DISPOSE OF THEM.",
        "Release the Villager TO SWIFTLY BEHEAD THEM.",
        "Release the Villager TO IMPALE THEM.",
        "Release the Villager TO STARVE THEM."
    };

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
        if ((int)villager.killBy - 1 == (int)typeOfSite) { Tribute?.Invoke(villager.haunted, typeOfSite); }
        else { PointlessSacrifice?.Invoke(villager.haunted, typeOfSite); }

        Destroy(villager.gameObject);
    }
}
