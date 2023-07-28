using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class beamAnimation : MonoBehaviour
{
    [SerializeField]
    private float animationDurationInSec;

    [SerializeField, Range(1, 10)]
    private float beamingSpeed;

    [SerializeField]
    private GameObject[] toBeamObjects;

    private GameObject beam;
    private bool isGoingDown = true;
    private bool isCheckDone = false;

    private float endTime;

    // Start is called before the first frame update
    void Start()
    {
        beam = gameObject;
        endTime = Time.time + animationDurationInSec;
    }

    // Update is called once per frame
    void Update()
    {
        if (!isCheckDone && beam.transform.position.y < -0.85)
        {
            isGoingDown = false;
            isCheckDone = true;
        }

        if (isGoingDown)
        {
            beamDown();
        }
        else
        {
            beamUpWithAll();
        }

        if (Time.time > endTime)
        {
            SceneManager.LoadScene("Start");
        }
    }

    private void beamDown()
    {
        moveObject(beam, beamingSpeed * -0.01f);
    }

    private void beamUpWithAll()
    {
        float speed = beamingSpeed * 0.01f;

        moveObject(beam, speed);
        foreach (GameObject itemToBeam in toBeamObjects)
        {
            moveObject(itemToBeam, speed);
        }
    }

    private void moveObject(GameObject obj, float speed)
    {
        obj.transform.Translate(0, beamingSpeed * speed, 0);
    }
}
