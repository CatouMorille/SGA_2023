using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;
using Ink.Runtime;
using UnityEngine.InputSystem;
using UnityEngine.EventSystems;
using UnityEngine.UI;
using UnityEngine.SceneManagement;

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

    [Space(10)]
    [Header("Npcs")]
    [SerializeField]
    private GameObject[] normalNpcs;

    [Header("Pierrette")]
    [SerializeField]
    private GameObject pierrette;

    [SerializeField]
    private int[] pierretteCorrectResponses;

    [SerializeField]
    private AudioSource pierretteSound;

    [SerializeField]
    private TextAsset PierretteAppearenceInkJson;

    private bool[] pierretteGivenAnswerValidity;

    private int pierretteResponseIndex;

    private TextMeshProUGUI[] choicesText;

    private Story currentStory;

    private string currentNpcName;

    private Dictionary<string, bool> visitedNpcs = new Dictionary<string, bool>();

    public bool dialogIsPlaying { get; private set; }

    public static DialogueManager instance { get; private set; }

    private float closingTimeInMiliseconds = 0f;

    private void Awake()
    {
        if (instance != null)
        {
            Debug.LogError("creation of multiple DialogueManager found.");
        }
        instance = this;

        pierretteGivenAnswerValidity = new bool[pierretteCorrectResponses.Length];
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

        foreach (var item in normalNpcs)
        {
            visitedNpcs.Add(item.gameObject.name, false);
        }

        pierrette.SetActive(false);
    }

    private void PerformAction(InputAction.CallbackContext obj)
    {
        if (dialogIsPlaying)
        {
            ContinueStory();
        }
    }

    public void EnterDialogueMode(TextAsset inkJson, string npcName, bool hasNextDialog = false)
    {
        if (IsJustClosing() && !hasNextDialog)
        {
            return;
        }

        currentStory = new Story(inkJson.text);
        dialogIsPlaying = true;
        dialoguePanel.SetActive(true);
        currentNpcName = npcName;

        visitedNpcs[npcName] = true;

        ContinueStory();
    }

    private bool isAllNpcVisited()
    {
        foreach (var item in visitedNpcs.Values)
        {
            if (!item)
            {
                return false;
            }
        }
        return true;
    }

    private void ExitDialogueMode()
    {
        dialogIsPlaying = false;
        dialoguePanel.SetActive(false);
        dialogueText.text = "";
        closingTimeInMiliseconds = CurrentTimeInMilliseconds();

        if (isAllNpcVisited() && !pierrette.activeSelf)
        {
            pierrette.SetActive(true);
            EnterDialogueMode(PierretteAppearenceInkJson, "none", true);
            pierretteSound.Play();
        }

        pierretteResponseIndex = 0;
        if (allPierretteResponseCorrect())
        {
            SceneManager.LoadScene("End");
        }
        else
        {
            resetPierretteResponse();
        }
    }

    private void resetPierretteResponse()
    {
        for (int i = 0; i < pierretteGivenAnswerValidity.Length; i++)
        {
            pierretteGivenAnswerValidity[i] = false;
        }
    }

    private bool allPierretteResponseCorrect()
    {
        if (currentNpcName != pierrette.name)
        {
            return false;
        }

        for (int i = 0; i < pierretteGivenAnswerValidity.Length; i++)
        {
            Debug.Log("response validty: " + i + ": " + pierretteGivenAnswerValidity[i]);
        }

        foreach (bool answerValidity in pierretteGivenAnswerValidity)
        {
            if (!answerValidity)
            {
                return false;
            }
            return true;
        }

        return true;
    }

    private void ContinueStory()
    {
        ReadChoice();

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

        // Select the first choice in the next frame
        StartCoroutine(SelectFirstChoice());
    }

    private IEnumerator SelectFirstChoice()
    {
        // Event System requires we clear it first and set it after at least one frame.
        EventSystem.current.SetSelectedGameObject(null);
        yield return new WaitForEndOfFrame();
        EventSystem.current.SetSelectedGameObject(choices[0].gameObject);
    }

    private void ReadChoice()
    {
        GameObject selectedGameObject = EventSystem.current.currentSelectedGameObject;
        if (selectedGameObject == null || !selectedGameObject.activeSelf)
        {
            return;
        }

        int choiceIndex = 0;
        if (selectedGameObject.name == "Choice1")
        {
            choiceIndex = 1;
        }

        currentStory.ChooseChoiceIndex(choiceIndex);

        verifyPierettesChoice(choiceIndex);
    }

    private void verifyPierettesChoice(int answer)
    {
        if (currentNpcName != pierrette.name)
        {
            return;
        }

        if (pierretteCorrectResponses[pierretteResponseIndex] == answer || pierretteCorrectResponses[pierretteResponseIndex]  == 2)
        {
            pierretteGivenAnswerValidity[pierretteResponseIndex] = true;
        }
        pierretteResponseIndex++;
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
