using UnityEngine;
using UnityEditor;

using System;
using System.Xml;
using System.IO;

using System.Collections;
using System.Collections.Generic;


public class DamageArmorTableEditor : EditorWindow {

	static private DamageArmorTableEditor window;
	
    // Add menu named "TowerEditor" to the Window menu
    [MenuItem ("TDTK/DamageArmorTable")]
    static void Init () {
        // Get existing open window or if none, make a new one:
        window = (DamageArmorTableEditor)EditorWindow.GetWindow(typeof (DamageArmorTableEditor));
		window.minSize=new Vector2(340, 170);
		
		armorNumber=1;
		armorTypes=new List<ArmorType>();
		armorTypes.Add(new ArmorType());
		
		dmgTypes=new List<DamageType>();
		
		Load();
    }
	
	private static int armorNumber=1;
	private static int damageNumber=1;
	
	private static List<ArmorType> armorTypes=new List<ArmorType>();
	private static List<DamageType> dmgTypes=new List<DamageType>();
	
	void SaveToXML(){
		
		Debug.Log("writing...");
		
		XmlDocument xmlDocDmg=new XmlDocument();
		xmlDocDmg.LoadXml("<something></something>");
		
		for(int j=0; j<dmgTypes.Count; j++){
			XmlNode docRoot = xmlDocDmg.DocumentElement;
			XmlElement armorEle = xmlDocDmg.CreateElement("DmgType"+j.ToString());
		
			XmlAttribute Attr1 = xmlDocDmg.CreateAttribute("Name");
			XmlAttribute Attr2 = xmlDocDmg.CreateAttribute("Desp");
			
			Attr1.Value = dmgTypes[j].name.ToString(); 
			Attr2.Value = dmgTypes[j].desp.ToString();
				
			armorEle.Attributes.Append(Attr1);
			armorEle.Attributes.Append(Attr2);
			
			docRoot.AppendChild(armorEle);
		}
		
		xmlDocDmg.Save(Application.dataPath  + "\\TDTK\\Resources\\DmgType.txt");
		
		
		
		XmlDocument xmlDoc=new XmlDocument();
		xmlDoc.LoadXml("<something></something>");
		
		for(int j=0; j<armorTypes.Count; j++){
			XmlNode docRoot = xmlDoc.DocumentElement;
			XmlElement armorEle = xmlDoc.CreateElement("ArmorType"+j.ToString());
		
			XmlAttribute Attr1 = xmlDoc.CreateAttribute("Name");
			XmlAttribute Attr2 = xmlDoc.CreateAttribute("Desp");
			
			Attr1.Value = armorTypes[j].name.ToString(); 
			Attr2.Value = armorTypes[j].desp.ToString();
				
			armorEle.Attributes.Append(Attr1);
			armorEle.Attributes.Append(Attr2);
			
			for(int i=0; i<armorTypes[j].modifiers.Count; i++){
				XmlAttribute Attr = xmlDoc.CreateAttribute("mod"+i);
				Attr.Value = armorTypes[j].modifiers[i].ToString();
				armorEle.Attributes.Append(Attr);
			}
			
			docRoot.AppendChild(armorEle);
		}
		
		Debug.Log("saving...");
		xmlDoc.Save(Application.dataPath  + "\\TDTK\\Resources\\ArmorType.txt");
		
		AssetDatabase.Refresh();
		
		Debug.Log("done");
	}
	
	static void Load(){
		XmlDocument xmlDoc = new XmlDocument();
		
		TextAsset dmgTextAsset=Resources.Load("DmgType", typeof(TextAsset)) as TextAsset;
		if(dmgTextAsset!=null){
			xmlDoc.Load(new MemoryStream(dmgTextAsset.bytes));
			XmlNode rootNode = xmlDoc.FirstChild;
			if (rootNode.Name == "something"){
				damageNumber=rootNode.ChildNodes.Count;
				dmgTypes=new List<DamageType>();
				for(int n=0; n<damageNumber; n++){
					dmgTypes.Add(new DamageType());
					dmgTypes[n].name=rootNode.ChildNodes[n].Attributes[0].Value;
					dmgTypes[n].desp=rootNode.ChildNodes[n].Attributes[1].Value;
				}
			}
		}
		
		TextAsset textAsset=Resources.Load("ArmorType", typeof(TextAsset)) as TextAsset;
		if(textAsset!=null){
			xmlDoc.Load(new MemoryStream(textAsset.bytes));
			XmlNode rootNode = xmlDoc.FirstChild;
			if (rootNode.Name == "something"){
				
				armorNumber=rootNode.ChildNodes.Count;
				armorTypes=new List<ArmorType>();
				for(int n=0; n<armorNumber; n++){
					armorTypes.Add(new ArmorType());
				}
				
				for (int i=0; i<rootNode.ChildNodes.Count; i++){
					
					armorTypes[i].name=rootNode.ChildNodes[i].Attributes[0].Value;
					armorTypes[i].desp=rootNode.ChildNodes[i].Attributes[1].Value;
					
					//damageNumber=rootNode.ChildNodes[i].Attributes.Count-2;
					//~ armorTypes[i].modifiers=new float[rootNode.ChildNodes[i].Attributes.Count-2];
					armorTypes[i].modifiers=new List<float>();
					
					if (rootNode.ChildNodes[i].Name == "ArmorType"+i.ToString()){
						
						for(int j=0; j<damageNumber; j++){
							//~ armorTypes[i].modifiers[j]=(float)double.Parse(rootNode.ChildNodes[i].Attributes[j+2].Value);
							armorTypes[i].modifiers.Add((float)double.Parse(rootNode.ChildNodes[i].Attributes[j+2].Value));
						}
						
					}
					//else Debug.Log("wrong name");
				}

			}
			
		}
		else{
			Debug.Log("file does not exist");
		}
	}
	
	static public void Test(){
		Debug.Log("update");
	}
	
	void OnFocus(){
		//Debug.Log("on focus");
	}
	
	public static void DeleteArmor(ArmorType armor){
		for(int i=0; i<armorTypes.Count; i++){
			if(armorTypes[i]==armor){
				armorTypes.RemoveAt(i);
				armorNumber-=1;
				Debug.Log("armor deleted");
			}
		}
	}
	
	public static void EditArmor(ArmorType armor){
		for(int i=0; i<armorTypes.Count; i++){
			if(armorTypes[i]==armor){
				armorTypes[i]=armor;
			}
		}
	}
	
	public static void NewArmor(ArmorType armor){
		for(int i=0; i<damageNumber; i++) armor.modifiers.Add(1.0f);
		armorTypes.Add(armor);
		armorNumber+=1;
		Debug.Log("new armor added");
	}
	
	
	public static void DeleteDmg(DamageType dmg){
		for(int i=0; i<dmgTypes.Count; i++){
			if(dmgTypes[i]==dmg){
				dmgTypes.RemoveAt(i);
				damageNumber=dmgTypes.Count;
			}
		}
	}
	
	public static void EditDmg(DamageType dmg){
		for(int i=0; i<dmgTypes.Count; i++){
			if(dmgTypes[i]==dmg){
				dmgTypes[i]=dmg;
			}
		}
	}
	
	public static void NewDmg(DamageType dmg){
		dmgTypes.Add(dmg);
		damageNumber=dmgTypes.Count;
	}
	
	void OnInspectorGUI(){
		//~ Event e = Event.current;
        //~ Debug.Log(e.mousePosition);
		Debug.Log(Event.current.mousePosition);
	}
	
	void OnGUI () {
		//~ Debug.Log(Event.current.mousePosition);
		if(GUI.Button(new Rect(window.position.width-110, 10, 100, 30), "Save")){
			SaveToXML();
		}
		if(GUI.Button(new Rect(10, 10, 100, 30), "New Armor")){
			ArmorTypeEditor.newArmor=true;
			ArmorTypeEditor.armorType=new ArmorType();
			Vector2 pos=new Vector2(window.position.x, window.position.y);
			ArmorTypeEditor.Init(Event.current.mousePosition+pos);
		}
		if(GUI.Button(new Rect(120, 10, 100, 30), "New Damage")){
			DmgTypeEditor.newDmg=true;
			DmgTypeEditor.dmgType=new DamageType();
			Vector2 pos=new Vector2(window.position.x, window.position.y);
			DmgTypeEditor.Init(Event.current.mousePosition+pos);
		}
		
		GUI.skin.label.alignment=TextAnchor.MiddleLeft;
		GUI.Label(new Rect(10, 100, 50, 20), "Armor");
		GUI.Label(new Rect(90, 50, 55, 20), "Damage");
		
		GUI.skin.button.alignment=TextAnchor.MiddleCenter;
		GUI.skin.textField.alignment=TextAnchor.MiddleLeft;
		
		
		
		int startX=160;
		int startY=70;
		int spaceY=30;
		int height=20;
		
		//~ startY+=10;
		//~ startX=30;
		
		for(int n=0; n<damageNumber; n++){
			if(n<dmgTypes.Count){
				//Debug.Log(dmgTypes[n].name);
				GUI.skin.label.alignment=TextAnchor.MiddleCenter;
				GUI.Label(new Rect(startX, startY-20, 50, 20), n.ToString());
				GUI.Label(new Rect(startX, startY, 50, 20), dmgTypes[n].name);
				if(GUI.Button(new Rect(startX, startY+25, 50, 20), "Edit")){
					DmgTypeEditor.newDmg=false;
					DmgTypeEditor.dmgType=dmgTypes[n];
					Vector2 pos=new Vector2(window.position.x, window.position.y);
					DmgTypeEditor.Init(Event.current.mousePosition+pos);
				}
				startX+=60;
			}
		}
		
		startX=30;
		startY+=55;
		
		for(int i=0; i<armorTypes.Count; i++){
			//Debug.Log(armorTypes[i].name);
			GUI.skin.label.alignment=TextAnchor.MiddleLeft;
			GUI.Label(new Rect(startX-20, startY, 60, 20), i.ToString());
			GUI.skin.label.alignment=TextAnchor.MiddleRight;
			GUI.Label(new Rect(startX, startY, 65, 20), armorTypes[i].name);
			if(GUI.Button(new Rect(startX+70, startY, 50, 20), "Edit")){
				ArmorTypeEditor.newArmor=false;
				ArmorTypeEditor.armorType=armorTypes[i];
				Vector2 pos=new Vector2(window.position.x, window.position.y);
				ArmorTypeEditor.Init(Event.current.mousePosition+pos);
			}
			
			startX+=130;
			
			for(int j=0; j<damageNumber; j++){
				if(j>=armorTypes[i].modifiers.Count) armorTypes[i].modifiers.Add(1f);
				armorTypes[i].modifiers[j]=EditorGUI.FloatField(new Rect(startX, startY, 50, height), armorTypes[i].modifiers[j]);
				startX+=60;				
			}
			startY+=spaceY;
			startX=30;
		}
	}
	

}





//~ [ExecuteInEditMode]
//~ [Serializable]
//~ public static class XmlTools
//~ {
    //~ public static XmlDocument loadXml(TextAsset xmlFile)
    //~ {
        //~ MemoryStream assetStream = new MemoryStream(xmlFile.bytes);
        //~ XmlReader reader = XmlReader.Create(assetStream);
        //~ XmlDocument xmlDoc = new XmlDocument();
        //~ try
        //~ {
            //~ xmlDoc.Load(reader);
        //~ }
        //~ catch (Exception ex)
        //~ {
            //~ Debug.Log("Error loading "+ xmlFile.name + ":\n" + ex);
        //~ }
        //~ finally
        //~ {
            //~ Debug.Log(xmlFile.name + " loaded");
        //~ }

        //~ return xmlDoc;
    //~ }

    //~ public static void writeXml(string filepath, XmlDocument xmlDoc)
    //~ {
        //~ if (File.Exists(filepath))
        //~ {
            //~ using (TextWriter sw = new StreamWriter(filepath, false, System.Text.Encoding.UTF8)) //Set encoding
            //~ {
                //~ xmlDoc.Save(sw);
            //~ }
        //~ }
    //~ }
//~ }
