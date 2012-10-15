using UnityEngine;
using System.Collections;

public class UInGUI : MonoBehaviour {

	private UnitTower currentSelectedTower;
	
	//camera for nGUI layer, used to detect if any mouse/touch is landed on any of the GUI element
	public Camera nGUICam;
	//layer name for nGUI, must match the layer assigned in nGUI setup
	public string nGUILayer="NGUI";
	
	//name of the next scene and main menu
	public string nextScene;
	public string mainMenu;
	
	//build mode and build button related variable
	public enum _BuildMode{PointNBuild, DragNDrop}
	public _BuildMode buildMode;
	public bool alwaysShowBuildButton=false;
	public bool autoGenerateBuildButton=true;
	
	public enum _ButtonOrientation{Right, Left, Down, Up}
	public _ButtonOrientation buttonOrientation;
	public float buildButtonSpacing=60;
	
	public GameObject buildButtonTemplate;
	public GameObject[] buildButtons;
	private bool buildMenu=false;
	
	
	//tooltip for build button
	public GameObject tooltipTower;
	public UILabel tooltipTowerName;
	public UILabel[] tooltipTowerCost;
	public UILabel tooltipTowerInfo;
	private Vector3 posOffsetFromButton;
	
	public bool showBuildSample=true;
	
	//label for general info
	public UILabel labelLife;
	public UILabel[] labelResource;
	public UILabel labelWave;
	public UILabel labelTimer;
	public GameObject labelGameMessage;
	
	//spawn and fastforward button
	public float FastForwardTime=3;
	public UILabel buttonFFText;
	public GameObject buttonSpawn;
	public GameObject buttonSpawnHighlight;
	private UIButtonScale buttonSpawnScale;
	
	//pause button and pause/game-end menu
	private bool pause=false;
	public GameObject menu;
	public GameObject menuGeneral;
	public GameObject menuOption;
	public UILabel labelGeneralMessage;
	public UILabel labelResumeButton;
	
	
	//selected tower info panel
	public GameObject towerSelectedPanel;
	public UILabel towerLabelName;
	public UILabel towerLabelInfo;
	public UILabel[] towerLabelUpgradeCost;
	public UILabel[] towerLabelSellCost;
	public GameObject towerUpgradeUI;
	
	//selected tower targeting setting
	public bool enableTargetPrioritySwitch=true;
	public bool enableTargetDirectionSwitch=true;
	public GameObject towerTargetingPriority;
	public UIPopupList towerTargetingPriorityList;
	public BoxCollider towerTargetingPriorityBox;
	public GameObject towerTargetingDirection;
	public UISlider towerTargetingDirectionSlider;
	
	
	void Awake(){
		//if this ui is not used, deactivate all the nGUI gameObject
		if(!this.enabled){
			UIRoot[] uiRoots=(UIRoot[])FindObjectsOfType(typeof(UIRoot));
			foreach(UIRoot uiRoot in uiRoots){
				uiRoot.gameObject.SetActiveRecursively(false);
			}
		}
	}
	
	// Use this for initialization
	void Start () {
		//initiate all the display
		OnResource();
		OnLife();
		OnNewWave(0);
		OnTowerSelect();
		
		//if a continuous mode is used, show spawn timer
		_SpawnMode mode=SpawnManager.GetSpawnMode();
		if(mode==_SpawnMode.Continuous || mode==_SpawnMode.SkippableContinuous){
			StartCoroutine(SpawnTimerRoutine());
		}
		else{
			if(labelTimer!=null) labelTimer.text="";
		}
		
		//disable all the menu
		if(menu && menu.active) menu.SetActiveRecursively(false);
		if(menuGeneral && menuGeneral.active) menuGeneral.SetActiveRecursively(false);
		if(menuOption && menuOption.active) menuOption.SetActiveRecursively(false);
		
		//cache the UIButtonScale component on spawnButton, so we can disable it if we want to override it
		buttonSpawnScale=buttonSpawn.GetComponent<UIButtonScale>();
		
		//disable tower tooltip
		OnTowerClearTooltip();
		
		//generate build button is needed
		if(autoGenerateBuildButton) InitBuildButton();
		//get the position offset of the tooltip from the first button, so this offset can be cached and applied when other button are mouse overed
		if(buildButtons[0]!=null)	posOffsetFromButton=tooltipTower.transform.position-buildButtons[0].transform.position;
		
		//initiate sample menu, so player can preview the tower in pointNBuild buildphase
		if(buildMode==_BuildMode.PointNBuild && showBuildSample) BuildManager.InitiateSampleTower();
	}
	
	
	//generate build button based on the template
	void InitBuildButton(){
		//get the full tower list from the BuildManager
		UnitTower[] towerList=BuildManager.GetTowerList();
		
		buildButtons=new GameObject[towerList.Length];
		
		for(int i=0; i<towerList.Length ; i++){
			//clone a new button based on the template, set the position and parent to that of the template
			GameObject obj=(GameObject) Instantiate(buildButtonTemplate);
			obj.transform.parent=buildButtonTemplate.transform.parent;
			obj.transform.position=buildButtonTemplate.transform.position;
			
			//shift the position of the clone button
			if(buttonOrientation==_ButtonOrientation.Right)
				obj.transform.localPosition+=new Vector3(i*buildButtonSpacing, 0, 0);
			else if(buttonOrientation==_ButtonOrientation.Left)
				obj.transform.localPosition+=new Vector3(i*-buildButtonSpacing, 0, 0);
			else if(buttonOrientation==_ButtonOrientation.Down)
				obj.transform.localPosition+=new Vector3(0, -i*buildButtonSpacing, 0);
			else if(buttonOrientation==_ButtonOrientation.Up)
				obj.transform.localPosition+=new Vector3(0, i*buildButtonSpacing, 0);
			
			//set the scale
			obj.transform.localScale=buildButtonTemplate.transform.localScale;
			
			//assign the cloned buttonto the button list,
			//this list will be used for comparison to decide which tower to be build when any of the build button is pressed
			buildButtons[i]=obj;
			obj.name="buildButton"+i.ToString();
			
			//assign the tower icon to the button, if there's one in the atlas
			UISlicedSprite sprite=obj.GetComponentInChildren<UISlicedSprite>();
			if(sprite!=null && sprite.atlas.GetSprite(towerList[i].icon.name)!=null){
				sprite.spriteName=towerList[i].icon.name;
			}
		}
		
		//disable the template button
		buildButtonTemplate.SetActiveRecursively(false);
		
		//if PointNBuild mode is selected, hide the buttons
		if(buildMode==_BuildMode.PointNBuild && !alwaysShowBuildButton) DisableBuildButtons();
	}
	
	
	
	
	void OnEnable(){
		//subscribe to these events so we can change the UI accordingly when they happen
		GameControl.onGameOverE += OnGameOver;
		GameControl.onResourceE += OnResource;
		GameControl.onLifeE += OnLife;
		
		SpawnManager.onClearForSpawningE += OnClearForSpawning;
		SpawnManager.onWaveStartSpawnE += OnNewWave;
		
		UnitTower.onDestroyE += OnTowerDestroyed;
		UnitTower.onBuildCompleteE += OnTowerBuildComplete;
		UnitTower.onDragNDropE += OnTowerDragNDropEnd;
	}
	
	void OnDisable(){
		//on disable, unsubcribe
		GameControl.onGameOverE -= OnGameOver;
		GameControl.onResourceE -= OnResource;
		GameControl.onLifeE -= OnLife;
		
		SpawnManager.onClearForSpawningE -= OnClearForSpawning;
		SpawnManager.onWaveStartSpawnE += OnNewWave;
		
		UnitTower.onDestroyE -= OnTowerDestroyed;
		UnitTower.onBuildCompleteE -= OnTowerBuildComplete;
		UnitTower.onDragNDropE -= OnTowerDragNDropEnd;
	}
	
	void OnTowerDragNDropEnd(string msg){
		if(msg!="") DisplayMessage(msg);
	}
	
	// Update is called once per frame
	void Update () {
		#if !UNITY_IPHONE && !UNITY_ANDROID
			if(buildMode==_BuildMode.PointNBuild)
				BuildManager.SetIndicator(Input.mousePosition);
		#endif
		
		//when is pressed, make sure it's not on any of the ui element and the game is not paused
		if(Input.GetMouseButtonDown(0) && !IsCursorOnUI(Input.mousePosition) && !pause){
			
			//call function to see if any tower is being selected upon the click
			UnitTower tower=GameControl.Select(Input.mousePosition);
			
			//if a tower has been selected on the click
			if(tower!=null){
				//set the selecte tower
				currentSelectedTower=tower;
				//for PointNBuild mode, clear buildpoint if buildmenu is currently activated
				if(buildMode==_BuildMode.PointNBuild && buildMenu){
					BuildManager.ClearBuildPoint();
					DisableBuildButtons();
					buildMenu=false;
				}
			}
			//if no tower has been selected
			else{
				// if a tower has been selected previous, clear the selection now
				if(currentSelectedTower!=null){
					GameControl.ClearSelection();
					currentSelectedTower=null;
				}
				
				
				if(buildMode==_BuildMode.PointNBuild){
					
					//check for build point, if true initiate build menu
					if(BuildManager.CheckBuildPoint(Input.mousePosition)){
						if(!alwaysShowBuildButton){
							buildMenu=true;
							UpdateBuildList();
						}
					}
					//if there are no valid build point but we are in build mode, disable it
					else{
						if(buildMenu && !alwaysShowBuildButton){
							buildMenu=false;
							DisableBuildButtons();
						}
						BuildManager.ClearBuildPoint();
					}
					
				}
			}
			
			//call function to update the tower selection panel
			OnTowerSelect();
		}
		
	}
	
	//function call to check if the cursor pos on screen is hitting any nGUI lelements
	bool IsCursorOnUI(Vector3 point){
		if( nGUICam != null ){
			// pos is the Vector3 representing the screen position of the input
			Ray inputRay = nGUICam.ScreenPointToRay( Input.mousePosition );    
			RaycastHit hit;

			if( Physics.Raycast( inputRay, out hit, Mathf.Infinity, LayerMask.NameToLayer( nGUILayer ) ) ){
				// UI was hit
				return true;
			}
		}
		
		return false;
	}
	
	
	
	//A coroutine used to update spawn timer, only called when time-based spawn mode is usded
	IEnumerator SpawnTimerRoutine(){
		if(labelTimer==null) yield break;
		
		//while game is not started, dont do anything
		labelTimer.text="";
		while(GameControl.gameState==_GameState.Idle){
			yield return null;
		}
		
		//while the game is still going, display the time
		while(SpawnManager.GetCurrentWave()<SpawnManager.GetTotalWave()){
			if(GameControl.gameState==_GameState.Ended) break;
			labelTimer.text="Next Wave: "+SpawnManager.GetTimeNextSpawn().ToString("f1")+"s";
			yield return null;
		}
		
		//once the last wave is spawned, clear the label
		labelTimer.text="";
	}
	
	
	//called when game is over, just change the label accordingly
	void OnGameOver(bool flag){
		//check if the label has been assigned
		if(labelResumeButton) labelResumeButton.text="Continue";
		
		//check if the label has been assigned
		if(labelGeneralMessage){
			//if player won, show victory
			if(flag){
				labelGeneralMessage.text="Victory!";
			}
			//else show gameover
			else{
				labelGeneralMessage.text="GameOver";
			}
		}
	
		if(menu && !menu.active) menu.SetActiveRecursively(true);
		if(menuGeneral && !menuGeneral.active) menuGeneral.SetActiveRecursively(true);
	}
	
	//called whenever resource is gain or used
	void OnResource(){
		//make sure the label for resource is assigned
		if(labelResource==null) return;
		
		//get all resource value
		int[] rsc=GameControl.GetAllResourceVal();
		
		//check how many label is there, so there's no error
		int num=Mathf.Min(rsc.Length, labelResource.Length);
		
		//show the resource value in appropriate label
		for(int i=0; i<num; i++){
			if(labelResource[i]) labelResource[i].text=rsc[i].ToString();
		}
	}
	
	//called whenever player life value is change, update the label accordingly
	void OnLife(){
		if(labelLife) labelLife.text="Life: "+GameControl.GetPlayerLife().ToString();
	}
	
	//called when pause button is pressed, toggle between pause and unpause
	void OnPause(){
		if(GameControl.gameState==_GameState.Ended) return;
		
		//if the game is currently pause, unpause it
		if(pause){
			pause=false;
			
			//resume timeScale
			if(Time.timeScale==0) Time.timeScale=1;
			
			//deactivate all pause/option menu
			if(menu && menu.active) menu.SetActiveRecursively(false);
			if(menuGeneral && menuGeneral.active) menuGeneral.SetActiveRecursively(false);
			if(menuOption && menuOption.active) menuOption.SetActiveRecursively(false);
		}
		//if the game is currently running, pause it
		else{
			pause=true;
			
			//stop time
			if(Time.timeScale>0) Time.timeScale=0;
			
			//activate pause menu
			if(menu && !menu.active) menu.SetActiveRecursively(true);
			if(menuGeneral && !menuGeneral.active) menuGeneral.SetActiveRecursively(true);
			//if(menuOption.active) menuOption.SetActiveRecursively(false);
		}
	}
	
	//called when back button on option menu is pressed
	void OnOptionBack(){
		if(menuGeneral && !menuGeneral.active) menuGeneral.SetActiveRecursively(true);
		if(menuOption && menuOption.active) menuOption.SetActiveRecursively(false);
	}
	
	//called when option button on pause menu is pressed
	void OnOption(){
		if(menuGeneral && menuGeneral.active) menuGeneral.SetActiveRecursively(false);
		if(menuOption && !menuOption.active) menuOption.SetActiveRecursively(true);
	}
	
	
	//called when sfxvolume slider is adjust
	void OnSetSFXVolume(float val){
		AudioManager.SetSFXVolume(val);
	}
	
	//called when music volume slider is adjust
	void OnSetMusicVolume(float val){
		AudioManager.SetMusicVolume(val);
	}
	
	//called when resume button on pause menu is pressed
	void OnResume(){
		//if the game is over, load next scene
		if(GameControl.gameState==_GameState.Ended){
			if(nextScene!="") Application.LoadLevel(nextScene);
		}
		//else resume the game by calling OnPause 
		else{
			OnPause();
		}
	}
	
	void OnRestart(){
		Application.LoadLevel(Application.loadedLevelName);
	}
	
	//called when menu button on pause menu is pressed
	void OnMenu(){
		if(mainMenu!="") Application.LoadLevel(mainMenu);
	}
	
	//called when fastforward button is pressed, toggle between normal speed and fastforward speed
	void OnFFButton(){
		//ignore if the game is current being paused
		if(pause) return;
		
		if(Time.timeScale==1){
			//set the timeScale
			Time.timeScale=FastForwardTime;
			//change the text on the button
			buttonFFText.text="Timex"+FastForwardTime.ToString("f0");
		}
		else if(Time.timeScale>1){
			//set the timeScale
			Time.timeScale=1;
			//change the text on the button
			buttonFFText.text="Timex1";
		}
	}
	
	//called when spawn button is pressed
	void OnSpawn(){
		//if this is before game started and spawnHighLight is still on, disable it
		if(buttonSpawnHighlight.active){
			buttonSpawnHighlight.active=false;
		}
		
		//call the function to spawn the next wave
		SpawnManager.Spawn();
		//diasble the buttonScaleTween component on the button so we can override the scale tweening
		buttonSpawnScale.enabled=false;
		
		StartCoroutine(SpawnButtonScaleDown());
	}
	
	//called when spawnManager indicate that it's ready to be spawn the next wave
	void OnClearForSpawning(bool flag){
		_SpawnMode mode=SpawnManager.GetSpawnMode();
		if(mode!=_SpawnMode.SkippableWaveCleared && mode!=_SpawnMode.SkippableContinuous){
			return;
		}
		
		//enable the default scalingTween on the spawn button 
		buttonSpawnScale.enabled=true;
		//scale the button back to default size
		if(flag){
			TweenScale.Begin(buttonSpawn, 0.2f, new Vector3(1, 1, 1));
		}
		//~ else{
			//~ buttonSpawnScale.enabled=false;
			//~ StartCoroutine(ScaleDown());
		//~ }
	}
	
	//scale the spawn button to invisible, wait for 1 frame so the command override the default button scaling animation
	IEnumerator SpawnButtonScaleDown(){
		yield return null;
		TweenScale.Begin(buttonSpawn, 0.2f, Vector3.zero);
	}
	
	//called when a new wave is spawned
	void OnNewWave(int wave){
		//update the wave count label
		labelWave.text="Wave: "+SpawnManager.GetCurrentWave()+"/"+SpawnManager.GetTotalWave();
		//show message on screen
		if(wave>1) DisplayMessage("Incoming wave "+(wave-1).ToString()+"!!");
	}
	
	
	//function call to enable all build button
	void EnableBuildButtons(){
		foreach(GameObject button in buildButtons){
			if(!button.active) button.SetActiveRecursively(true);
		}
	}
	
	//function call to disaable all build button
	void DisableBuildButtons(){
		foreach(GameObject button in buildButtons){
			if(button.active) button.SetActiveRecursively(false);
		}
	}
	
	//called when a build button is pressed, the button object which is pressed is passed
	void OnTowerBuild(GameObject obj){
		//check which button has been pressed exactly
		//we can know from comparing to the buildButton list
		//from the position of the button in the list, we can know which towers is associated with the button
		int towerID=-1;
		for(int i=0; i<buildButtons.Length; i++){
			if(obj==buildButtons[i]){
				towerID=i;
				break;
			}
		}
		
		if(towerID==-1){
			return;
		}
		//if there's a matching button
		else{
			
			//get the tower
			UnitTower[] towerList=BuildManager.GetTowerList();
			UnitTower tower=towerList[towerID];
			
			//for PointNBuild mode
			if(buildMode==_BuildMode.PointNBuild){
				//call the function to build a tower, an empty string will be returned if building is sucessful
				string result=BuildManager.BuildTowerPointNBuild(tower);
				//if a tower is built
				if(result==""){
					//hide the build menu and clear the tooltip
					if(buildMenu && !alwaysShowBuildButton){
						buildMenu=false;
						DisableBuildButtons();
						BuildManager.ClearBuildPoint();
						OnTowerClearTooltip();
					}
				}
				//else just display why the building operation failed
				else{
					DisplayMessage(result);
				}
			}
			//for drag and drop mode
			else if(buildMode==_BuildMode.DragNDrop){
				//call the function to build a tower, an empty string will be returned if building is sucessful
				string result=BuildManager.BuildTowerDragNDrop(tower);
				//display why the building operation failed
				if(result!=""){
					DisplayMessage(result);
				}
			}
		}
		
		//if there's a tower being selected, clear it
		if(currentSelectedTower!=null){
			currentSelectedTower=null;
			OnTowerSelect();
		}
	}
	
	//function call to show tower tooltip when the build button is mouse-overed.
	void OnTowerTooltip(GameObject obj){
		//check which button has been pressed exactly
		//we can know from comparing to the buildButton list
		//from the position of the button in the list, we can know which towers is associated with the button
		int towerID=-1;
		for(int i=0; i<buildButtons.Length; i++){
			if(obj==buildButtons[i]){
				towerID=i;
				break;
			}
		}
		
		//if there's no matching button, deactivate the all tooltip object
		if(towerID==-1){
			if(tooltipTower.active) tooltipTower.SetActiveRecursively(false);
		}
		//if there's a matching button
		else{
		
			//get the tower
			UnitTower[] towerList=BuildManager.GetTowerList();
			UnitTower tower=towerList[towerID];
			
			//show the name
			tooltipTowerName.text=tower.unitName;
			
			//show the cost
			if(tooltipTowerCost!=null){
				//get the cost
				int[] cost=tower.GetCost();
				
				//make sure we dont show more than the number of label assigned
				int num=Mathf.Min(cost.Length, tooltipTowerCost.Length);
				
				for(int i=0; i<num; i++){
					if(tooltipTowerCost[i]) tooltipTowerCost[i].text=cost[i].ToString();
				}
			}
			
			//show the description
			tooltipTowerInfo.text=tower.GetDescription();
			
			//set the tooltip position, 
			//just offset the tooltip transform position from the button transform based on the tooltip to Button position offset
			tooltipTower.transform.position=buildButtons[towerID].transform.position+posOffsetFromButton;
			
			//activate the tooltip so it's visible
			if(!tooltipTower.active) tooltipTower.SetActiveRecursively(true);
			
			//if this is point and build mode, call function to show the sample tower
			if(buildMode==_BuildMode.PointNBuild && showBuildSample) BuildManager.ShowSampleTower(towerID); 
		}
	}
	
	//function call to clear tooltip, called when the mouse is moved out of a button
	void OnTowerClearTooltip(){
		if(tooltipTower.active){
			tooltipTower.SetActiveRecursively(false);
			if(buildMode==_BuildMode.PointNBuild && showBuildSample) BuildManager.ClearSampleTower();
		}
	}
	
	
	//called when the value of the slider ot towerTargetingDirection is chancged
	void OnTowerTargetingDirection(float val){
		if(currentSelectedTower==null) return;
		
		//make sure targetingPriority setting applies to the selected tower.
		if(currentSelectedTower.type==_TowerType.TurretTower || currentSelectedTower.type==_TowerType.DirectionalAOETower){
			if(currentSelectedTower.targetingArea!=_TargetingArea.AllAround){
				//calculate the direction and call the function to set it
				float direction=val*360;
				currentSelectedTower.SetTargetingDirection(direction);
			}
		}
	}
	
	//called when one of the option on targetPriority popup list is selected
	void OnTowerTargetingPriority(string type){
		if(currentSelectedTower==null) return;
		
		//make sure targetingPriority setting applies to the selected tower.
		if(currentSelectedTower.type==_TowerType.TurretTower || currentSelectedTower.type==_TowerType.DirectionalAOETower){
			if(currentSelectedTower.targetingArea!=_TargetingArea.StraightLine){
				//call the function to set the target priority based on the string passed
				if(type=="Nearest") currentSelectedTower.SetTargetPriority(0);
				else if(type=="Weakest") currentSelectedTower.SetTargetPriority(1);
				else if(type=="Toughest") currentSelectedTower.SetTargetPriority(2);
				else if(type=="Random") currentSelectedTower.SetTargetPriority(3);
			}
		}
	}
	
	//called when the towerTargetingPriority panel is being clicked
	//this is just to expend the collider of the GUI element so that when clicking outside the panel when the popup list expand,
	//the selected tower wont get unselected.
	void towerTargetingPriotityBoxClicked(){
		towerTargetingPriorityBox.size=new Vector3(1, 4, 1);
		StartCoroutine(ResizeBox());
	}
	//coroutine called when the towerTargetingPriority panel is being clicked
	//detect any input that could close the popup list, then resize the box back to normal
	IEnumerator ResizeBox(){
		while(true){
			bool input=false;
			input|=Input.GetMouseButton(0);
			input|=Input.GetMouseButton(1);
			input|=Input.GetKeyUp(KeyCode.Return);
			if(input) break;
			yield return null;
		}
		towerTargetingPriorityBox.size=new Vector3(1, 1, 1);
	}
	
	
	//called when a tower is selected, update the selected tower info panel
	void OnTowerSelect(){
		//if there's no tower being selected, deactivate all ui element
		if(currentSelectedTower==null){
			towerSelectedPanel.SetActiveRecursively(false);
		}
		else{
			//make sure all related ui element is active and visible
			towerSelectedPanel.SetActiveRecursively(true);
			
			//set up the level string, add as many I as the tower level
			string lvl="";
			for(int i=0; i<currentSelectedTower.GetLevel(); i++){
				lvl+="l";
			}
			//show the tower's name, follow by it's level
			towerLabelName.text=currentSelectedTower.unitName+" (lvl "+lvl+")";
			
			//get the sell value, make sure there's enough label assigned to show all the value's element before display it
			int[] sellValue=currentSelectedTower.GetTowerSellValue();
			int num=Mathf.Min(sellValue.Length, towerLabelSellCost.Length);
			for(int i=0; i<num; i++){
				if(towerLabelSellCost[i]) towerLabelSellCost[i].text=sellValue[i].ToString();
			}
			
			//upgrade button and cost
			//check if the tower has been updgrade to max level, only then we proceed to show the related ui element
			if(!currentSelectedTower.IsLevelCapped()){
				//get the cost value, make sure there's enough label assigned to show all the value's element before display it
				int[] cost=currentSelectedTower.GetCost();
				num=Mathf.Min(cost.Length, towerLabelUpgradeCost.Length);
				for(int i=0; i<num; i++){
					if(towerLabelUpgradeCost[i]) towerLabelUpgradeCost[i].text=cost[i].ToString();
				}
				//make sure all the upgrade related ui element is active and visible
				if(!towerUpgradeUI.active) towerUpgradeUI.SetActiveRecursively(true);
			}
			//if tower level has been capped, deactive all upgrade realted ui element so it's not visible
			else{
				if(towerUpgradeUI.active)	towerUpgradeUI.SetActiveRecursively(false);
			}
			
			
			//create an empty string, this will be added on with all the general stats information and description of the twoer
			string towerInfo="";
			
			//get the tower type, depend on the type, different information is displayed
			_TowerType type=currentSelectedTower.type;
			
			//for resource tower, show the resource info only
			if(type==_TowerType.ResourceTower){
				
				int[] incomes=currentSelectedTower.GetIncomes();
				string cd=currentSelectedTower.GetCooldown().ToString("f1");
				
				Resource[] resourceList=GameControl.GetResourceList();
				
				string rsc="";
				for(int i=0; i<incomes.Length; i++){
					rsc="Increase "+resourceList[i].name+" by "+incomes[i].ToString("0")+" for every "+cd+"sec\n";
				}
				
				towerInfo+=rsc;
				
			}
			//for support tower, show the buff info only
			else if(type==_TowerType.SupportTower){
				
				BuffStat buffInfo=currentSelectedTower.GetBuff();
				
				string buff="";
				//only show the buff if it carry value
				if(buffInfo.damageBuff!=0) buff+="Buff damage by "+(buffInfo.damageBuff*100).ToString("f1")+"%\n";
				if(buffInfo.rangeBuff!=0) buff+="Buff range by "+(buffInfo.rangeBuff*100).ToString("f1")+"%\n";
				if(buffInfo.cooldownBuff!=0) buff+="Reduce CD by "+(buffInfo.cooldownBuff*100).ToString("f1")+"%\n";
				if(buffInfo.regenHP!=0) buff+="Renegerate HP by "+(buffInfo.regenHP).ToString("f1")+" per seconds\n";
				
				towerInfo+=buff;
				
			}
			else if(type==_TowerType.Mine){
				//show the basic info for mine
				if(currentSelectedTower.GetDamage()>0)
					towerInfo+="Damage: "+currentSelectedTower.GetDamage().ToString("f1")+"\n";
				if(type==_TowerType.TurretTower && currentSelectedTower.GetAoeRadius()>0)
					towerInfo+="AOE Radius: "+currentSelectedTower.GetRange().ToString("f1")+"\n";
				if(currentSelectedTower.GetStunDuration()>0)
					towerInfo+="Stun target for "+currentSelectedTower.GetStunDuration().ToString("f1")+"sec\n";
				
				//if the mine have damage over time value, display it
				Dot dot=currentSelectedTower.GetDot();
				float totalDot=dot.damage*(dot.duration/dot.interval);
				if(totalDot>0){
					string dotInfo="Cause "+totalDot.ToString("f1")+" damage over the next "+dot.duration+" sec\n";
					
					towerInfo+=dotInfo;
				}
				
				//if the mine have slow value, display it
				Slow slow=currentSelectedTower.GetSlow();
				if(slow.duration>0){
					string slowInfo="Slow target by "+(slow.slowFactor*100).ToString("f1")+"% for "+slow.duration.ToString("f1")+"sec\n";
					towerInfo+=slowInfo;
				}
			}
			//for direct offensive tower, show the offensive stats
			else if(type==_TowerType.TurretTower || type==_TowerType.DirectionalAOETower || type==_TowerType.AOETower){
				
				if(currentSelectedTower.GetDamage()>0){
					towerInfo+="Damage: "+currentSelectedTower.GetDamage().ToString("f1")+"\n";
				}
				if(currentSelectedTower.GetCooldown()>0)
					towerInfo+="Cooldown: "+currentSelectedTower.GetCooldown().ToString("f1")+"sec\n";
				if(type==_TowerType.TurretTower && currentSelectedTower.GetAoeRadius()>0)
					towerInfo+="AOE Radius: "+currentSelectedTower.GetAoeRadius().ToString("f1")+"\n";
				if(currentSelectedTower.GetStunDuration()>0)
					towerInfo+="Stun target for "+currentSelectedTower.GetStunDuration().ToString("f1")+"sec\n";
				
				Dot dot=currentSelectedTower.GetDot();
				float totalDot=dot.damage*(dot.duration/dot.interval);
				if(totalDot>0){
					string dotInfo="Cause "+totalDot.ToString("f1")+" damage over the next "+dot.duration+" sec\n";
					towerInfo+=dotInfo;
				}
				
				Slow slow=currentSelectedTower.GetSlow();
				if(slow.duration>0){
					string slowInfo="Slow target by "+(slow.slowFactor*100).ToString("f1")+"% for "+slow.duration.ToString("f1")+"sec\n";
					towerInfo+=slowInfo;
				}
			}
			//note that block type tower doesnt carry any stats, so it's ignored
			
			
			towerInfo+="\n\n"+currentSelectedTower.description;
				
			towerLabelInfo.text=towerInfo;
			
			Debug.Log(currentSelectedTower.targetingDirection);
			if(enableTargetDirectionSwitch){
				if(currentSelectedTower.type==_TowerType.TurretTower || currentSelectedTower.type==_TowerType.DirectionalAOETower){
					if(currentSelectedTower.targetingArea!=_TargetingArea.AllAround){
						towerTargetingDirectionSlider.sliderValue=currentSelectedTower.targetingDirection/360f;
					}
					else towerTargetingDirection.SetActiveRecursively(false);
				}
				else towerTargetingDirection.SetActiveRecursively(false);
			}
			else towerTargetingDirection.SetActiveRecursively(false);
			
			
			if(enableTargetPrioritySwitch){
				if(currentSelectedTower.type==_TowerType.TurretTower || currentSelectedTower.type==_TowerType.DirectionalAOETower){
					if(currentSelectedTower.targetingArea!=_TargetingArea.StraightLine){
						if(currentSelectedTower.targetPriority==_TargetPriority.Nearest) towerTargetingPriorityList.textLabel.text="Nearest";
						else if(currentSelectedTower.targetPriority==_TargetPriority.Weakest) towerTargetingPriorityList.textLabel.text="Weakest";
						else if(currentSelectedTower.targetPriority==_TargetPriority.Toughest) towerTargetingPriorityList.textLabel.text="Toughest";
						else if(currentSelectedTower.targetPriority==_TargetPriority.Random) towerTargetingPriorityList.textLabel.text="Random";
					}
					else towerTargetingPriority.SetActiveRecursively(false);
				}
				else towerTargetingPriority.SetActiveRecursively(false);
			}
			else towerTargetingPriority.SetActiveRecursively(false);
			
			
		}
	}
	
	void OnTowerDestroyed(UnitTower tower){
		if(currentSelectedTower==tower){
			currentSelectedTower=null;
			OnTowerSelect();
		}
	}
	
	void OnTowerBuildComplete(UnitTower tower){
		if(currentSelectedTower==tower){
			OnTowerSelect();
		}
	}
	
	void OnTowerUpgrade(){
		//Debug.Log("upgrade");
		if(currentSelectedTower){
			if(!currentSelectedTower.Upgrade()) DisplayMessage("Insufficient Resource");
		}
	}
	
	void OnTowerSell(){
		if(currentSelectedTower) currentSelectedTower.Sell();
	}
	
	
	void DisplayMessage(string msg){
		GameObject obj=(GameObject)Instantiate(labelGameMessage);
		obj.transform.parent=labelGameMessage.transform.parent;
		obj.transform.localScale=labelGameMessage.transform.localScale;
		obj.GetComponent<UILabel>().text=msg;
		StartCoroutine(FadeMessage(obj));
	}
	
	IEnumerator FadeMessage(GameObject obj){
		TweenPosition.Begin(obj, 2f, obj.transform.position+new Vector3(0, 150, 0));
		yield return new WaitForSeconds(0.5f);
		TweenScale.Begin(obj, 0.5f, Vector3.zero);
		Destroy(obj, 2);
	}
	
	
	private int[] currentBuildList=new int[0];
	//called whevenever the a new build point is selected in PointNBuild mode
	//compute the number of tower that can be build in this build pointer
	//store the tower that can be build in an array of number that reference to the towerlist
	//this is so these dont need to be calculated in every frame in OnGUI()
	void UpdateBuildList(){
		
		//get the current buildinfo in buildmanager
		BuildableInfo currentBuildInfo=BuildManager.GetBuildInfo();
		
		//get the current tower list in buildmanager
		UnitTower[] towerList=BuildManager.GetTowerList();
		
		//construct a temporary interger array the length of the buildinfo
		int[] tempBuildList=new int[towerList.Length];
		//for(int i=0; i<currentBuildList.Length; i++) tempBuildList[i]=-1;
		
		//scan through the towerlist, if the tower matched the build type, 
		//put the tower ID in the towerlist into the interger array
		int count=0;	//a number to record how many towers that can be build
		for(int i=0; i<towerList.Length; i++){
			UnitTower tower=towerList[i];
				
			if(currentBuildInfo.specialBuildableID!=null && currentBuildInfo.specialBuildableID.Length>0){
				foreach(int specialBuildableID in currentBuildInfo.specialBuildableID){
					if(specialBuildableID==tower.specialID){
						count+=1;
						break;
					}
				}
			}
			else{
				if(tower.specialID<0){
					//check if this type of tower can be build on this platform
					foreach(_TowerType type in currentBuildInfo.buildableType){
						if(tower.type==type && tower.specialID<0){
							tempBuildList[count]=i;
							count+=1;
							break;
						}
					}
				}
			}
		}
		
		//for as long as the number that can be build, copy from the temp buildList to the real buildList
		currentBuildList=new int[count];
		for(int i=0; i<currentBuildList.Length; i++) currentBuildList[i]=tempBuildList[i];
		
		RearrangeBuildButtons();
	}
	
	
	//arrange the build button layout based on which button will be active and which will not
	//button that build tower that is not supported by the platform supported will not be active
	void RearrangeBuildButtons(){
		//DisableBuildButtons();
		
		//loop through all the buttons
		for(int i=0; i<buildButtons.Length; i++){
			//a flag to indicate if this button should be active
			bool matched=false;
			
			//integer indicate how many tower has been scan through
			int j=0;
			//loop through all the buildable tower ID list
			foreach(int towerID in currentBuildList){
				//if there's a match, the tower can be build
				if(i==towerID){
					//get the corresponding button and set it to buildbuttontemplate position so we can shift it properly 
					Transform button=buildButtons[towerID].transform;
					button.position=buildButtonTemplate.transform.position;
					
					//set the button position accordingly
					if(buttonOrientation==_ButtonOrientation.Right)
						button.localPosition+=new Vector3(j*buildButtonSpacing, 0, 0);
					else if(buttonOrientation==_ButtonOrientation.Left)
						button.localPosition+=new Vector3(j*-buildButtonSpacing, 0, 0);
					else if(buttonOrientation==_ButtonOrientation.Down)
						button.localPosition+=new Vector3(0, -j*buildButtonSpacing, 0);
					else if(buttonOrientation==_ButtonOrientation.Up)
						button.localPosition+=new Vector3(0, j*buildButtonSpacing, 0);
					
					//set the tweening position on the TweenPosition on the component, if any, to current position
					//so the button position wont get shift when mouse over
					TweenPosition tweenCom=(TweenPosition)button.GetComponent(typeof(TweenPosition));
					if(tweenCom!=null){
						tweenCom.to=button.localPosition;
						tweenCom.from=button.localPosition;
					}
					
					//activate the button
					if(buildButtons[towerID]) buildButtons[towerID].SetActiveRecursively(true);
					
					//set match flag to true, else the button will be deactivated
					matched=true;
					
					//break the loop since we have found a match
					break;
				}
				
				j+=1;
			}
			
			//if no match is found from the buildable list, disable the button
			if(!matched){
				if(buildButtons[i]) buildButtons[i].SetActiveRecursively(false);
			}
		}
	}
	
	

}
