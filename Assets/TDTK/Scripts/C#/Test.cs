using UnityEngine;
using System.Collections;

public class Test : MonoBehaviour {

	public bool msg;
	public int count=100;
	
	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		if(msg){
			for(int i=0; i<count; i++){
				gameObject.SendMessage("Called", 1, SendMessageOptions.RequireReceiver);
			}
		}
		else{
			for(int i=0; i<count; i++){
				//~ Test test=gameObject.GetComponent<Test>();
				//~ if(test!=null) test.Called(1);
				//~ (Test)gameObject.GetComponent(typeof(Test)).Called(1);
				((Test)gameObject.GetComponent(typeof(Test))).Called(1);
			}
		}
	}
	
	void Called(int num){
		num=0;
	}
}
