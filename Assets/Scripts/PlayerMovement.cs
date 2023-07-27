using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

public class PlayerMovement : MonoBehaviour
{
    [SerializeField]
    private InputActionReference movement;

    [SerializeField]
    private float movementSpeed = 5f;

    [SerializeField]
    private float smoothInputSpeed = 0.2f;

    private Rigidbody2D rb;
    private Vector2 movementDirection;
    private Vector2 currentInputVector;
    private Vector2 smoothInputVelocity;

    // Utilis� pour passer derri�re et devant l'arbre
    private SpriteRenderer sr;

    private Animator animatorPlayer;

    void Start()
    {
        rb = GetComponent<Rigidbody2D>();
        sr = GetComponent<SpriteRenderer>();
        animatorPlayer = GetComponent<Animator>();
    }

    void Update()
    {
        movementDirection = movement.action.ReadValue<Vector2>();
    }

    void FixedUpdate()
    {
        if (DialogueManager.instance.dialogIsPlaying)
        {
            // Force movement speed to 0 if dialog is open
            rb.velocity = currentInputVector * 0;
            return;
        }

        currentInputVector = Vector2.SmoothDamp(
            currentInputVector,
            movementDirection,
            ref smoothInputVelocity,
            smoothInputSpeed
        );
        rb.velocity = currentInputVector * movementSpeed;

        // Changement d'animation
        animatorPlayer.SetFloat("SpeedX", rb.velocity.x);
        animatorPlayer.SetFloat("SpeedY", rb.velocity.y);
    }

    private void OnTriggerEnter2D(Collider2D collider)
    {
        if (collider.gameObject.layer == LayerMask.NameToLayer("Tree"))
        {
            sr.sortingOrder = -1;
        }
    }

    private void OnTriggerExit2D(Collider2D collider)
    {
        if (collider.gameObject.layer == LayerMask.NameToLayer("Tree"))
        {
            sr.sortingOrder = 99;
        }
    }
}
