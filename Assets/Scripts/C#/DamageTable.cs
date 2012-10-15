using UnityEngine;
using System.Collections;
using System.Collections.Generic;

using System;
using System.Xml;
using System.IO;

public class DamageTable : MonoBehaviour {

	private static List<ArmorType> armorTypes=new List<ArmorType>();
	private static List<DamageType> dmgTypes=new List<DamageType>();
	
	
	// Use this for initialization
	void Awake() {
		Load();
	}
	
	static void Load(){
		XmlDocument xmlDoc = new XmlDocument();
		
		TextAsset dmgTextAsset=Resources.Load("DmgType", typeof(TextAsset)) as TextAsset;
		if(dmgTextAsset!=null){
			xmlDoc.Load(new MemoryStream(dmgTextAsset.bytes));
			XmlNode rootNode = xmlDoc.FirstChild;
			if (rootNode.Name == "something"){
				int damageNumber=rootNode.ChildNodes.Count;
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
				
				int armorNumber=rootNode.ChildNodes.Count;
				armorTypes=new List<ArmorType>();
				for(int n=0; n<armorNumber; n++){
					armorTypes.Add(new ArmorType());
				}
				
				for (int i=0; i<rootNode.ChildNodes.Count; i++){
					armorTypes[i].name=rootNode.ChildNodes[i].Attributes[0].Value;
					armorTypes[i].desp=rootNode.ChildNodes[i].Attributes[1].Value;
					armorTypes[i].modifiers=new List<float>();
					
					if (rootNode.ChildNodes[i].Name == "ArmorType"+i.ToString()){
						for(int j=0; j<dmgTypes.Count; j++){
							armorTypes[i].modifiers.Add((float)double.Parse(rootNode.ChildNodes[i].Attributes[j+2].Value));
						}
					}
				}
			}
		}
		
	}
	
	void InitSingleDamage(){
		dmgTypes=new List<DamageType>();
		dmgTypes.Add(new DamageType());
	}
	
	void InitSingleArmor(){
		armorTypes=new List<ArmorType>();
		armorTypes.Add(new ArmorType(dmgTypes.Count));
	}
	
	public static float GetModifier(int armorID=0, int dmgID=0){
		armorID=Mathf.Max(0, armorID);
		dmgID=Mathf.Max(0, dmgID);
		if(armorID<armorTypes.Count && dmgID<dmgTypes.Count){
			return armorTypes[armorID].modifiers[dmgID];
		}
		else{
			return 1f;
		}
	}
	
	public static ArmorType GetArmorInfo(int ID){
		if(ID>armorTypes.Count){
			Debug.Log("ArmorType requested does not exist");
			return new ArmorType();
		}
		
		return armorTypes[ID];
	}
	
	public static DamageType GetDamageInfo(int ID){
		if(ID>dmgTypes.Count){
			Debug.Log("DamageType requested does not exist");
			return new DamageType();
		}
		
		return dmgTypes[ID];
	}
	
}


public class DamageType{
	public int typeID=-1;
	public string name="";
	public string desp="";
}

public class ArmorType{
	public int typeID=-1;
	public string name="";
	public string desp="";
	public List<float> modifiers=new List<float>();
	
	public ArmorType(int ID, string n, string d, List<float> mods){
		typeID=ID;
		name=n;
		desp=d;
		modifiers=mods;
	}
	
	public ArmorType(){
		modifiers.Add(1.0f);
	}
	
	public ArmorType(int modsNum){
		for(int i=0; i<modsNum; i++){
			modifiers.Add(1f);
		}
	}
}