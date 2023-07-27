using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;
using Ink.Runtime;
using UnityEngine.InputSystem;

public class DialogueManager : MonoBehaviour
{
    [Header("Dialogue UI")]
    [SerializeField]
    private GameObject dialoguePanel;

    [SerializeField]
    private TextMeshProUGUI dialogueText;

    [Header("Input Ref")]
    [SerializeField]
    private InputActionReference actionPressedInput;

    private Story currentStory;

    public bool dialogIsPlaying { get; private set; }

    public static DialogueManager instance { get; private set; }

    public float closingTimeInMiliseconds = 0f;

    private void Awake()
    {
        if (instance != null)
        {
            Debug.LogError("creation of multiple DialogueManager found.");
        }
        instance = this;
    }

    public void Start()
    {
        dialogIsPlaying = false;
        dialoguePanel.SetActive(false);
    }

    private void PerformAction(InputAction.CallbackContext obj)
    {
        if (dialogIsPlaying)
        {
            ContinueStory();
        }
    }

    public void EnterDialogueMode(TextAsset inkJson)
    {
        if (IsJustClosing())
        {
            return;
        }

        currentStory = new Story(inkJson.text);
        dialogIsPlaying = true;
        dialoguePanel.SetActive(true);

        ContinueStory();
    }

    private void ExitDialogueMode()
    {
        dialogIsPlaying = false;
        dialoguePanel.SetActive(false);
        dialogueText.text = "";
        closingTimeInMiliseconds = CurrentTimeInMilliseconds();
    }

    private void ContinueStory()
    {
        if (currentStory.canContinue)
        {
            dialogueText.text = currentStory.Continue();
        }
        else
        {
            ExitDialogueMode();
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

    private bool IsJustClosing()
    {
        return closingTimeInMiliseconds != 0 && CurrentTimeInMilliseconds() - closingTimeInMiliseconds < 200;
    }

    private float CurrentTimeInMilliseconds() {
        return Time.time * 1000;
    }
}
