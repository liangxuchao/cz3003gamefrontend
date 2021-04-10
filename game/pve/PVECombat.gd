extends Control
onready var charattackanimation = $character/charAttack/AnimationPlayer
onready var charAttack = $character/charAttack/Sprite
onready var bossattackanimation = $boss/bossAttack/AnimationPlayer
onready var bossAttack = $boss/bossAttack/Sprite

onready var httpNode = $HTTPRequest
onready var boss = $boss
onready var character = $character
onready var menupopup = $Popup
onready var startgameTimer = $Timer
onready var countdownlabel = $countdown/Label
onready var countdown = $countdown

onready var qTimer = $QuestionTimer
onready var questionBox = $QuestionBOX
onready var questionText = $QuestionBOX/Question

onready var questionAns1 = $QuestionBOX/Answer1
onready var questionAns2 = $QuestionBOX/Answer2
onready var questionAns3 = $QuestionBOX/Answer3
onready var questionAns4 = $QuestionBOX/Answer4

onready var questionAnsLabel1 = $QuestionBOX/Answer1/Label1
onready var questionAnsLabel2 = $QuestionBOX/Answer2/Label2
onready var questionAnsLabel3 = $QuestionBOX/Answer3/Label3
onready var questionAnsLabel4 = $QuestionBOX/Answer4/Label4

onready var win = $win
onready var winScore= $win/TextureRect/Score
onready var lose = $lose
onready var loseScore= $lose/TextureRect/Score


onready var RespondLabel = $QuestionBOX/RespondLabel

onready var questiontimerlabel = $QuestionTimerLabel

var s = 3
var QCount = 60;
var questions = []

var questionIndex = 0;
var questionCount = 1;

var currentscore = 0;
var correctAns = 0;
var failAns = 0;

var checkAnsValid = false;
# Called when the node enters the scene tree for the first time.
func _ready():
	#api call
	var authheader: PoolStringArray = ['Authorization: Bearer ' + Global.AccessToken ] 
	
	httpNode.connect("request_completed", self, "_on_request_completed_questionlist")
	#httpNode.request(Global.APIrooturl +  "/api/v1/question/" + str(Global.pvelvl.id),authheader,false,HTTPClient.METHOD_GET)
	httpNode.request(Global.APIrooturl +  "/api/v1/question/1",authheader,false,HTTPClient.METHOD_GET)
	
	#end 
	#print(Global.pvesection)
	
	var bossscence = load("res://game/interface/boss/" + Global.worldmapper[Global.pveworld.name] +"/section" + str(Global.pvesection.id)  + ".tscn").instance()
	bossAttack.texture = load("res://game/interface/boss/" + Global.worldmapper[Global.pveworld.name] +"/Attack/section" + str(Global.pvesection.id)  + ".png")
	
	boss.add_child(bossscence) # Replace with function body.
	
	var charascence = load("res://game/interface/character/character" + str(Global.character) + ".tscn").instance()
	charAttack.texture = load("res://game/interface/character/Attack/character" + str(Global.character) + ".png")
	character.add_child(charascence) # Replace with function body.
	
	# accttack
	charAttack.frame=1
	bossAttack.frame=1
	
	countdownlabel.text = "Ready?"
	countdown.popup()
	
	yield(httpNode, "request_completed")
	print(questions.size())
	$BossLifeBar/lifebar/TextureProgress.set_max(questions.size())
	
	$CharLifeBar/lifebar/TextureProgress.set_max(2)
	   
	$BossLifeBar/lifebar/TextureProgress.value = questions.size()
	
	$CharLifeBar/lifebar/TextureProgress.value  = 2
	
	
	get_tree().paused = true
	
	
	
func _on_MenuButton_pressed():
	menupopup.popup()
	pass # Replace with function body.



func _on_Answer_pressed(option):
	questiontimerlabel.visible = false
	questionAns1.visible = false
	questionAns2.visible = false
	questionAns3.visible = false
	questionAns4.visible = false
	
	var userinputAns = questions[questionIndex].answerOptions[option]
	var authheader: PoolStringArray = ['Authorization: Bearer ' + Global.AccessToken, 'Content-Type: application/json', ] 
	
	var body = '[{ "answerIds" : [' + str(userinputAns.id) +'],"levelId":1, "questionId": '+ str(userinputAns.questionId) +', "questionValue" : "'+ str(userinputAns.value) +'" }]'
	#check answer
	httpNode.connect("request_completed", self, "_on_request_completed_checkanswer")
	#httpNode.request(Global.APIrooturl +  "/api/v1/question/1",authheader,false,HTTPClient.METHOD_GET)
	httpNode.request(Global.APIrooturl +  "/api/v1/pve/answerLevel?levelId=1",authheader,false,HTTPClient.METHOD_POST,body)
	
	yield(httpNode, "request_completed")

	if checkAnsValid == true:
		currentscore += 1
		correctAns += 1
		# character animation
		charAttack.frame =0
		charattackanimation.play("charAttack")
		RespondLabel.text = "Correct!"
		RespondLabel.set("custom_colors/font_color", Color(0, 1, 0, 1))
		RespondLabel.visible = true
		yield(charattackanimation, "animation_finished")
		RespondLabel.visible = false
		
		
		
		$BossLifeBar/lifebar/TextureProgress.value=$BossLifeBar/lifebar/TextureProgress.value-1
	   
	else:
		failAns += 1
		# boss animation
		#charAttack.frame =0
		#charattackanimation.play("charAttack")
		#yield(charattackanimation, "animation_finished")
		bossAttack.frame = 0
		bossattackanimation.play("bossAttack")
		RespondLabel.text = "Wrong!"
		RespondLabel.set("custom_colors/font_color", Color(1,0,0,1))
		RespondLabel.visible = true
		yield(bossattackanimation, "animation_finished")
		$CharLifeBar/lifebar/TextureProgress.value=$CharLifeBar/lifebar/TextureProgress.value-1
		
		RespondLabel.visible = false
		if failAns == 2:
			#print("failed")
			loseScore.text = "Score " + str(currentscore)
			lose.popup()
			qTimer.stop()
			return
			
	questionIndex += 1
	if(questionIndex <= questions.size()-1):
		showQuestion()	
	else:
		
		winScore.text = "Score " + str(currentscore)
		win.popup()	
		qTimer.stop()
		return
	
	pass # Replace with function body.
	

func _on_Hit_Box_area_entered(area):
	charAttack.frame=1
	bossAttack.frame=1
	 

func _on_CloseButton_pressed():
	menupopup.visible =false

func _on_quit_pressed():
	get_tree().change_scene('res://game/gameselection/chooseSection/'+ Global.worldmapper[Global.pveworld.name] +'.tscn')

func _on_request_completed_checkanswer(result, response_code,headers, body):	
	var json = JSON.parse(body.get_string_from_utf8())
	if response_code == 200:
		if json.result[0].isAnswerCorrect == true:
			checkAnsValid = true
		else:
			checkAnsValid = false
	else: 
		checkAnsValid = false
	httpNode.disconnect("request_completed",self,"_on_request_completed_checkanswer")
	
func _on_request_completed_questionlist(result, response_code,headers, body):	
	var json = JSON.parse(body.get_string_from_utf8())

	if response_code == 200:
		questions = json.result
	httpNode.disconnect("request_completed",self,"_on_request_completed_questionlist")

func _on_Timer_timeout():
	if s == 0:
		startgameTimer.stop()
		countdown.visible = false
		
		get_tree().paused = false
		showQuestion()
		
	else:
		countdownlabel.text = str(s)
		s -= 1
	pass # Replace with function body.

func _on_QuestionTimer_timeout():
	if QCount == 0:
		qTimer.stop()
		failAns += 1
		questiontimerlabel.visible = false
		questionAns1.visible = false
		questionAns2.visible = false
		questionAns3.visible = false
		questionAns4.visible = false
		bossAttack.frame = 0
		bossattackanimation.play("bossAttack")
		RespondLabel.text = "Wrong!"
		RespondLabel.set("custom_colors/font_color", Color(1,0,0,1))
		RespondLabel.visible = true
		yield(bossattackanimation, "animation_finished")
		$CharLifeBar/lifebar/TextureProgress.value=$CharLifeBar/lifebar/TextureProgress.value-1
		
		RespondLabel.visible = false
		questionIndex += 1
		if failAns == 2:
			#print("failed")
			
			loseScore.text = "Score " + str(currentscore)
			lose.popup()
			return
			
		if(questionIndex <= questions.size()-1):
			showQuestion()	
		else:
			winScore.text = "Score " + str(currentscore)
			win.popup()	
	else:
		QCount -= 1
		questiontimerlabel.text = str(QCount)

func showQuestion():
	if(questionIndex <= questions.size()-1):
			if questions[questionIndex].active == true:
				
				questionText.text = "Q" + str(questionCount) + ": " + questions[questionIndex].value
				print(questions[questionIndex].answerOptions)
				
				if(0 <= questions[questionIndex].answerOptions.size()-1):
					questionAns1.visible = true
					questionAnsLabel1.text = questions[questionIndex].answerOptions[0].value
				else:
					questionAns1.visible = false
					questionAnsLabel1.text = ""
					
				if(1 <= questions[questionIndex].answerOptions.size()-1):
					questionAns2.visible = true
					questionAnsLabel2.text = questions[questionIndex].answerOptions[1].value
				else:
					questionAns2.visible = false
					questionAnsLabel2.text = ""
					
				if(2 <= questions[questionIndex].answerOptions.size()-1):
					questionAns3.visible = true
					questionAnsLabel3.text = questions[questionIndex].answerOptions[2].value
				else:
					questionAns3.visible = false
					questionAnsLabel3.text = ""
					
				if(3 <= questions[questionIndex].answerOptions.size()-1):
					questionAns4.visible = true
					questionAnsLabel4.text = questions[questionIndex].answerOptions[3].value
				else:
					questionAns4.visible = false
					questionAnsLabel4.text = ""
				
				qTimer.start()
				questionCount += 1
				QCount = 60
				questiontimerlabel.text = str(QCount)
				questiontimerlabel.visible = true
			else:
				questionIndex += 1
				showQuestion()




func _on_Back_pressed():
	get_tree().change_scene("res://game/gameselection/chooseSection/"+ Global.worldmapper[Global.pveworld.name] +".tscn")
	
func select_Boss_Attack(boss):
	pass



func _on_Next_Button_pressed():
	Global.pvelvl;
	Global.WorldsDetails;
	
	pass # Replace with function body.


func _on_retry_pressed():
	
	get_tree().reload_current_scene()
	pass # Replace with function body.


func _on_Try_Again_pressed():
	get_tree().reload_current_scene()
	pass # Replace with function body.
