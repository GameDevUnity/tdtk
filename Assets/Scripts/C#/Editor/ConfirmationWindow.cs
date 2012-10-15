using UnityEngine;
using UnityEditor;
using System.Collections;

public delegate void ConfirmCallBack(bool flag);

public class ConfirmationWindow : EditorWindow {

	//~ static public Vector2 windowPos;
	static public string message="";
	static public ConfirmCallBack callback;
	
	static ConfirmationWindow window;
	
	static void Init (Vector2 pos) {
		window = (ConfirmationWindow)EditorWindow.GetWindow(typeof (ConfirmationWindow));
		window.minSize=new Vector2(150, 50);
		window.maxSize=new Vector2(151, 51);
		window.position=new Rect(pos.x-75, pos.y-25, 150, 150);
    }
	
	// Use this for initialization
	void Start () {
	
	}
	
	public static void InitWindow(string msg, ConfirmCallBack cb){
		InitWindow(msg, cb, new Vector2(10, 10));
	}
	public static void InitWindow(string msg, ConfirmCallBack cb, Vector2 pos){
		message=msg;
		callback=cb;
		Init(pos);
	}
	
	void OnGUI(){
		GUI.skin.label.alignment = TextAnchor.MiddleCenter;

		GUI.Label(new Rect(5, 5, window.position.width-10, 20), message);
		if(GUI.Button(new Rect(20, 25, 40, 20), "yes")){
			if(callback!=null) callback(true);
			CloseWindow();
		}
		if(GUI.Button(new Rect(90, 25, 40, 20), "No")){
			if(callback!=null) callback(false);
			CloseWindow();
		}
	}
	
	void OnLostFocus(){
		CloseWindow();
	}
	
	void CloseWindow(){
		callback=null;
		this.Close();
	}
	
}
