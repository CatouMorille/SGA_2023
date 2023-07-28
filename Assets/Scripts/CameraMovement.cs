using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraMovement : MonoBehaviour
{
    [SerializeField]
    private Transform characterToFollow;

    [SerializeField]
    private Camera cam;

    [SerializeField]
    private GameObject mapBorder;

    private float cameraHalfWidth;
    private float cameraHalfHeight;
    private float top;
    private float right;
    private float bottom;
    private float left;

    // Start is called before the first frame update
    void Start()
    {
        cameraHalfHeight = cam.orthographicSize;
        cameraHalfWidth = cameraHalfHeight * cam.aspect;

        float mapBorderCenterX = mapBorder.transform.position.x;
        float mapBorderCenterY = mapBorder.transform.position.y;
        float haflScaleX = mapBorder.transform.localScale.x / 2;
        float halfScaleY = mapBorder.transform.localScale.y / 2;

        top = mapBorderCenterY + halfScaleY - cameraHalfHeight;
        right = mapBorderCenterX + haflScaleX - cameraHalfWidth;
        bottom = mapBorderCenterY - halfScaleY + cameraHalfHeight;
        left = mapBorderCenterX - haflScaleX + cameraHalfWidth;
    }

    // Update is called once per frame
    void Update()
    {
        float cameraX = transform.position.x;
        float cameraY = transform.position.y;

        //Empeche la camera d'aller au-dela d'un certain x
        float charX = characterToFollow.position.x;
        if (charX > left && charX < right)
        {
            cameraX = charX;
        }
        else
        {
            if (charX <= left)
            {
                cameraX = left;
            }

            if (charX >= right)
            {
                cameraX = right;
            }
        }

        //Empeche la camera d'aller au-dela d'un certain y
        float charY = characterToFollow.position.y;
        if (charY > bottom && charY < top)
        {
            cameraY = charY;
        }
        else
        {
            if (charY <= bottom)
            {
                cameraY = bottom;
            }

            if (charY >= top)
            {
                cameraY = top;
            }
        }

        //Mouvement de la carmera
        transform.position = new Vector3(cameraX, cameraY, transform.position.z);
    }
}
