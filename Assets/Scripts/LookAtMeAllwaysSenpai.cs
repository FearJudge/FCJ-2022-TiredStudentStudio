using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class LookAtMeAllwaysSenpai : MonoBehaviour
{
    public Image marker;
    public Transform target;
    public Transform player;

    public AudioSource audioPlayer;
    public Animator anim;

    public Vector2 xyLimits;
    public Vector2 xyOffset;
    Vector2 xLimits;
    Vector2 yLimits;

    public ObjectPool markerPool;

    bool alive = false;
    Color baseCol;

    private void Awake()
    {
        xLimits = new Vector2(xyLimits.x, Screen.width - xyLimits.x);
        yLimits = new Vector2(xyLimits.y, Screen.height - xyLimits.y);
    }

    public void Set(Transform kouhai)
    { 
        target = kouhai;
        alive = true;
    }

    public void Initialize(ObjectPool pool, Transform focuser)
    {
        baseCol = marker.color;
        player = focuser;
    }

    public void Unset()
    {
        alive = false;
        gameObject.SetActive(false);
    }

    // Update is called once per frame
    void Update()
    {
        if (!alive) { return; }
        Vector2 pos = Camera.main.WorldToScreenPoint(target.position);
        float dp = Vector3.Dot((target.position - player.position).normalized, player.forward);
        float dist = Vector3.Distance(target.position, player.position);

        if (dp < 0)
        {
            if (pos.x < Screen.width / 2) { pos.x = xLimits.y; }
            else { pos.x = xLimits.x; }
        }

        pos.x = Mathf.Clamp(pos.x + xyOffset.x, xLimits.x, xLimits.y);
        pos.y = Mathf.Clamp(pos.y + xyOffset.y, yLimits.x, yLimits.y);

        marker.transform.position = pos;
    }
}
