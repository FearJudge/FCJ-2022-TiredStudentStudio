using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class MenuController : MonoBehaviour
{
    public GameObject levelChanger;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public void GoToScene(string levelName)
    {
        GameObject go = Instantiate(levelChanger);
        LevelChanger lc = go.GetComponent<LevelChanger>();
        lc.StartTransition(levelName);
    }

    public void Quit()
    {
        Application.Quit();
    }
}
