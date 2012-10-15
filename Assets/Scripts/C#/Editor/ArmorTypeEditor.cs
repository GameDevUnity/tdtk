using UnityEngine;
using UnityEditor;

using System.Collections;

public class ArmorTypeEditor : EditorWindow {

	public static DamageArmorTableEditor target;
	
	public static ArmorTypeEditor window;
	
	public static void Init(Vector2 pos) {
        // Get existing open window or if none, make a new one:
        //~ (TestEditor)EditorWindow.GetWindow(typeof (TestEditor));
		
		window = (ArmorTypeEditor)EditorWindow.GetWindow(typeof (ArmorTypeEditor));
		window.minSize=new Vector2(300, 150);
		window.maxSize=window.minSize+new Vector2(1, 0);
		window.position=new Rect(pos.x-150, pos.y-75, 300, 150);
		//~ window.maxSize=window.minSize+new Vector2(2, 2);
		//~ window.maxSize=new Vector2(310, 160);
		
		//~ Debug.Log("init");
    }
	
	public static ArmorType armorType;
	public static bool newArmor=true;
	
	void OnGUI(){
		int startX=5;
		int startY=5;
		int height=20;
		
		if(armorType!=null){
			GUI.skin.textField.alignment=TextAnchor.UpperLeft;
			EditorGUI.LabelField(new Rect(startX, startY, 150, height), "Armor Name: ");
			armorType.name=EditorGUI.TextArea(new Rect(startX, startY+=17, 290, height), armorType.name);
			
			EditorGUI.LabelField(new Rect(startX, startY+=25, 150, height), "Armor Description: ");
			armorType.desp=EditorGUI.TextArea(new Rect(startX, startY+=17, 290, 50), armorType.desp);
			
			startY+=60;
			
			if(newArmor){
				if(GUI.Button(new Rect(window.position.width-75, startY, 70, 20), "Confirm")){
					DamageArmorTableEditor.NewArmor(armorType);
					this.Close();
				}
			}
			else{
				if(GUI.Button(new Rect(window.position.width/2-35, startY, 70, 20), "OK")){
					DamageArmorTableEditor.EditArmor(armorType);
					this.Close();
				}
				if(GUI.Button(new Rect(window.position.width-75, startY, 70, 20), "Delete")){
					Vector2 pos=new Vector2(window.position.x, window.position.y);
					pos+=Event.current.mousePosition;
					ConfirmationWindow.InitWindow("Are you sure?", this.DeleteArmor, pos);
				}
			}
		}
		
		if(GUI.Button(new Rect(startX, startY, 70, 20), "Cancel")){
			//~ target.OnFocus();
			//DamageArmorTableEditor.Test();
			this.Close();
		}
	}
	
	void DeleteArmor(bool flag){
		if(flag){
			DamageArmorTableEditor.DeleteArmor(armorType);
			this.Close();
		}
		else{
			
		}
	}
	
	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}
}
