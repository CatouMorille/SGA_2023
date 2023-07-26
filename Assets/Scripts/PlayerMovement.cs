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

    // Utilisé pour passer derrière et devant l'arbre
    private SpriteRenderer sr;

    void Start()
    {
        rb = GetComponent<Rigidbody2D>();
        sr = GetComponent<SpriteRenderer>();
    }

    void Update()
    {
        movementDirection = movement.action.ReadValue<Vector2>();
    }

    void FixedUpdate()
    {
        currentInputVector = Vector2.SmoothDamp(
            currentInputVector,
            movementDirection,
            ref smoothInputVelocity,
            smoothInputSpeed
        );
        rb.velocity = currentInputVector * movementSpeed;
    }

    private void OnTriggerEnter2D(Collider2D collider)
    {
        Debug.Log("detection with tree");
        if (collider.gameObject.layer == LayerMask.NameToLayer("Tree"))
        {
            sr.sortingOrder = -1;
        }
    }

    private void OnTriggerExit2D(Collider2D collider) {
        if (collider.gameObject.layer == LayerMask.NameToLayer("Tree"))
        {
            sr.sortingOrder = 99;
        }
    }
}
