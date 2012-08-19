using UnityEngine;
using System.Collections;

public class Crosshair : MonoBehaviour
{

	public Texture2D crosshairTexture;

	void Start ()
	{
		Screen.showCursor = false;
	}

	void OnGUI ()
	{
		Vector3 mousePos = Input.mousePosition;
		Rect pos = new Rect (mousePos.x - crosshairTexture.width * 0.5f, Screen.height - mousePos.y - crosshairTexture.height * 0.5f, 
		                     crosshairTexture.width, crosshairTexture.height);
		GUI.DrawTexture (pos, crosshairTexture);
	}
	
}
