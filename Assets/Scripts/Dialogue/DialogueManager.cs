using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;
using Ink.Runtime;
using UnityEngine.InputSystem;
using UnityEngine.EventSystems;

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

    [Header("Choices UI")]
    [SerializeField]
    private GameObject[] choices;

    private TextMeshProUGUI[] choicesText;

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

        // Get all the choices text
        choicesText = new TextMeshProUGUI[choices.Length];
        int index = 0;
        foreach (GameObject choice in choices)
        {
            choicesText[index] = choice.GetComponentInChildren<TextMeshProUGUI>();
            index++;
        }
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
            // set the text of dialog
            dialogueText.text = currentStory.Continue();

            // set the text of choices
            DisplayChoices();
        }
        else
        {
            ExitDialogueMode();
        }
    }

    private void DisplayChoices()
    {
        Debug.Log("Display choices");
        List<Choice> currentChoices = currentStory.currentChoices;

        // defensive check in case inky file contains more choices than supported by GUI
        if (currentChoices.Count > choices.Length)
        {
            Debug.LogError("Inky file contains more choices than supported by GUI");
        }

        // enable and initialize the text of the buttons(choices)
        int index = 0;
        foreach (Choice choice in currentChoices)
        {
            choices[index].gameObject.SetActive(true);
            choicesText[index].text = choice.text;
            index++;
        }
        // Set not used choice(button) to hidden
        for (int i = index; i < choices.Length; i++)
        {
            choices[i].gameObject.SetActive(false);
        }

        StartCoroutine(SelectFirstChoice());
    }

    private IEnumerator SelectFirstChoice()
    {
        // Event System requires we clear it first and set it after at least one frame.
        EventSystem.current.SetSelectedGameObject(null);

        yield return new WaitForEndOfFrame();

        EventSystem.current.SetSelectedGameObject(choices[0].gameObject);
    }

    public void MakeChoice(int choiceIndex){
        currentStory.ChooseChoiceIndex(choiceIndex);
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
        return closingTimeInMiliseconds != 0
            && CurrentTimeInMilliseconds() - closingTimeInMiliseconds < 200;
    }

    private float CurrentTimeInMilliseconds()
    {
        return Time.time * 1000;
    }
}
