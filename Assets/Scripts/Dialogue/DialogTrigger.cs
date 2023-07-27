using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

public class DialogTrigger : MonoBehaviour
{
    [Header("Ink Json")]
    [SerializeField]
    private TextAsset inkJson;

    [SerializeField]
    private InputActionReference actionPressedInput;

    private GameObject visualCue;

    private bool playerInRange;

    private void Awake()
    {
        visualCue = transform.GetChild(0).gameObject;

        visualCue.SetActive(false);
        playerInRange = false;
    }

    private void PerformAction(InputAction.CallbackContext obj)
    {
        if (playerInRange)
        {
            DialogueManager dm = DialogueManager.instance;
            if (!dm.dialogIsPlaying)
            {
                dm.EnterDialogueMode(inkJson);
            }
        }
    }

    private void Update()
    {
        if (playerInRange)
        {
            visualCue.SetActive(true);
        }
        else
        {
            visualCue.SetActive(false);
        }
    }

    private void OnTriggerEnter2D(Collider2D collider)
    {
        if (collider.gameObject.tag == "Player")
        {
            playerInRange = true;
        }
    }

    private void OnTriggerExit2D(Collider2D collider)
    {
        if (collider.gameObject.tag == "Player")
        {
            playerInRange = false;
        }
    }

    private void OnEnable()
    {
        actionPressedInput.action.performed += PerformAction;
    }

    private void OnDisable()
    {
        actionPressedInput.action.performed -= PerformAction;
    }
}