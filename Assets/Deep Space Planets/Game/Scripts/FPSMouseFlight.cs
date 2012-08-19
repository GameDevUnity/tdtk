using UnityEngine;
using System.Collections;

public class FPSMouseFlight : MonoBehaviour
{

	public float moveSpeed = 6.0f;
	public float rotationSpeedX = 2;
	public float rotationSpeedY = 2;
	public float maxSpeed = 60.0f;
	public Transform shipModel;
	public float actualSpeed = 0.0f;
	public Scale[] engineScale;

	private Vector3 moveDirection = Vector3.zero;
	private float baseRotationX = 0.0f;
	private float baseRotationY = 0.0f;
	private float oldSpeed = 0.0f;
	
	void Start()
	{
		for (int i = 0; i < engineScale.Length; i++) {
				engineScale[i].scale = 0.15f;
				engineScale[i].UpdateScale();
			}
	}
	
	void OnDestroy()
	{
		for (int i = 0; i < engineScale.Length; i++) {
				engineScale[i].scale = 1f;
				
		}
	}

	void FixedUpdate ()
	{
		
		actualSpeed = Mathf.Clamp (actualSpeed + Input.GetAxis ("Vertical"), 0, maxSpeed);
		if (actualSpeed != oldSpeed) {
			for (int i = 0; i < engineScale.Length; i++) {
				engineScale[i].scale = actualSpeed / maxSpeed * (0.35f) + 0.15f;
				engineScale[i].UpdateScale();
			}
			oldSpeed = actualSpeed;
					}
		moveDirection = new Vector3 (0, 0, actualSpeed);
		moveDirection = transform.TransformDirection (moveDirection);
		moveDirection *= moveSpeed;
		
		baseRotationX = (Input.mousePosition.x - Screen.width * 0.5f) * 0.001f * rotationSpeedX;
		baseRotationY = (Input.mousePosition.y - Screen.height * 0.5f) * 0.001f * rotationSpeedY;

		transform.Rotate (Vector3.up, baseRotationX);
		transform.Rotate (Vector3.left, baseRotationY);
		
		float angleZ = baseRotationX * 30;
		
		
		float angleX = baseRotationY * 30;
		
		shipModel.localEulerAngles = new Vector3 (angleX, 180, angleZ);
		
		// Move the controller
		//CharacterController controller  = (CharacterController)GetComponent("CharacterController");
		//controller.Move(moveDirection * Time.deltaTime);
		
		this.transform.position += moveDirection * Time.deltaTime;
		
	}
	
	
}
