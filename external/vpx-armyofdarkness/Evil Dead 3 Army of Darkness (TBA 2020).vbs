


'****************************************************  ******  ********************
'***************************************************  ********  *******************   
'    **                                               **    **                         
'    ** **  ** **   ** **  ** ** ** *** *****  ****   **          *** ******  ****
'    ** **  ** ***  ** ** **  **** **** ****** *****  **         **** ****** **  **     
'**  ** **  ** **** ** ****   *** ** ** **  ** **  ** **        ** **   **    ** 
'**  ** **  ** ** **** ****   ** **  ** *****  **  ** **    ** **  **   **     ***  
'****** ****** **  *** ** **  ** ****** ****** *****  ******** ******   **   *  ***  
'****** ****** **   ** **  ** ** **  ** **  ** ****    ******  **  **   **    ****  

'*************************  Created by Brendan Bailey  ****************************
'**************************   WWW.BRENDANBAILEY.NET   *****************************


' Thank you to all of the designers, artists, musicians, & programmers of real pinball  
' games who have inspired me to create this game!


' HUGE THANKS to Christopher Leathley for creating Future Pinball. 

' Please visit JUNKYARDCATS.NET for all your JUNKYARD CATS table updates, media files, and more! 


' *********************************************************************
' **                                                                 **
' **                        JUNKYARD CATS                            **
' **                                                                 **
' **                      Table Script v1.0                          **
' **                                                                 **
' **       (C) 2011, 2012 Brendan Bailey - BrendanBailey.net         **
' **                                                                 **
' *********************************************************************



Option Explicit				' Force explicit variable declaration
Randomize

Dim b2sstep
b2sstep = 0
Dim b2satm
Dim B2SOn		'True/False if want backglass

Sub startB2S(aB2S)
	b2sflash.enabled = 1
	b2satm = ab2s
End Sub



Sub b2sflash_timer
    If B2SOn Then
	b2sstep = b2sstep + 1
	Select Case b2sstep
		Case 0
		Controller.B2SSetData b2satm, 0
		Case 1
		Controller.B2SSetData b2satm, 1
		Case 2
		Controller.B2SSetData b2satm, 0
		Case 3
		Controller.B2SSetData b2satm, 1
		Case 4
		Controller.B2SSetData b2satm, 0
		Case 5
		Controller.B2SSetData b2satm, 1
		Case 6
		Controller.B2SSetData b2satm, 0
		Case 7
		Controller.B2SSetData b2satm, 1
		Case 8
		Controller.B2SSetData b2satm, 0
		b2sstep = 0
		b2sflash.enabled = 0
	End Select
    End If
End Sub



Sub startB2S2(aB2S2)
	b2sflash2.enabled = 1
	b2satm2 = ab2s2
End Sub

Dim b2sstep2
b2sstep2 = 0
Dim b2satm2
Sub b2sflash2_timer
 If B2SOn Then
 	b2sstep2 = b2sstep2 + 1
	Select Case b2sstep2
		Case 0
		Controller.B2SSetData b2satm2, 1

		Case 1
		Controller.B2SSetData b2satm2, 1 
		b2sflash2.enabled = 0
	End Select
    End If  
End Sub





Const BallSize = 43
Const BallMass = 1.1



ExecuteGlobal GetTextFile("FPVPX.vbs")
If Err Then MsgBox "you need the fpvpx.vbs for the proper functioning of the table"

' Load the core.vbs for supporting Subs and functions
LoadCoreFiles


Sub LoadCoreFiles
    On Error Resume Next
    ExecuteGlobal GetTextFile("core.vbs")
    If Err Then MsgBox "Can't open core.vbs"
    ExecuteGlobal GetTextFile("controller.vbs")
    If Err Then MsgBox "Can't open controller.vbs"
    On Error Goto 0
End Sub


if Table1.ShowDT Then
   hdisplay1.visible =1
   display1.visible = 1
   hdisplay2.visible = 1
  display2.visible = 1
 Else
   hdisplay1.visible = 0
   display1.visible = 0
   hdisplay2.visible = 0
  display2.visible = 0
End If

Const cGameName = "gatos"

' Define any Constants
Const TableName = "Junkyard Cats vpx"
Const myVersion = "1.07"
Const MaxPlayers = 1     ' from 1 to 4
Const BallSaverTime = 10 ' in seconds
Const MaxMultiplier = 5  ' limit to 5x in this game, both bonus multiplier and playfield multiplier
Const BallsPerGame = 3   ' usually 3 or 5
Const MaxMultiballs = 5  ' max number of balls during multiballs

' Define Global Variables
'Dim PlayersPlayingGame
'Dim CurrentPlayer
Dim Credits
Dim BonusPoints
Dim BonusHeldPoints(4)
'Dim BonusMultiplier(4)
Dim PlayfieldMultiplier(4)
Dim bBonusHeld
'Dim BallsRemaining(4)
'Dim ExtraBallsAwards(4)
Dim Score(4)
Dim HighScore(4)
Dim HighScoreName(4)
Dim specialhighscorename(4)
Dim specialhighscore(4)
Dim specialscore(4)
Dim Jackpot(4)
Dim SuperJackpot
Dim Tilt
Dim TiltSensitivity
Dim Tilted
Dim TotalGamesPlayed
Dim mBalls2Eject
Dim SkillshotValue(4)
Dim bAutoPlunger
Dim bInstantInfo
Dim bAttractMode

'Claw HighScore
dim ScoreChecker
dim CheckAllScores
Dim HighScoreReward
Dim SpecialHighScoreReward
dim sortscores(4)
dim sortplayers(4)
Dim TextStr, TextStr2
Dim debugscore
Dim InProgress

' Define Game Control Variables
'Dim LastSwitchHit
'Dim BallsOnPlayfield
'Dim BallsInLock(4)
Dim BallsInHole

' Define Game Flags
'Dim bFreePlay
Dim bGameInPlay
'Dim bOnTheFirstBall
'Dim bBallInPlungerLane
'Dim bBallSaverActive
Dim bBallSaverReady
'Dim bMultiBallMode
Dim bMusicOn
Dim bSkillshotReady
Dim bExtraBallWonThisBall
Dim bJustStarted
Dim bJackpot

' core.vbs variables
Dim plungerIM 'used mostly as an autofire plunger during multiballs

dim FastFlips





' Define any Constants 
Const constMaxPlayers 		= 1 		' Maximum number of players per game (between 1 and 4)
Const constBallSaverTime	= 10000	' Time in which a free ball is given if it lost very quickly
												' Set this to 0 if you don't want this feature
Const constMaxMultiplier	= 5		' Defines the maximum bonus multiplier level

' Define Global Variables
'
Dim PlayersPlayingGame		' number of players playing the current game
Dim CurrentPlayer				' current player (1-4) playing the game			
Dim BonusMultiplier(4)		' Bonus Multiplier for the current player
Dim BallsRemaining(4)		' Balls remaining to play (inclusive) for each player
Dim ExtraBallsAwards(4)		' number of EB's out-standing (for each player)

' Define Game Control Variables
Dim LastSwitchHit				' Id of last switch hit
Dim BallsOnPlayfield			' number of balls on playfield (multiball exclusive)
Dim BallsInDrain
Dim BallsInLock

' Define Game Flags
Dim bFreePlay					' Either in Free Play or Handling Credits
Dim bOnTheFirstBall			' First Ball (player one). Used for Adding New Players
Dim bBallInPlungerLane		' is there a ball in the plunger lane
Dim bBallSaverActive			' is the ball saver active 
Dim bMultiBallMode			' multiball mode active ?
Dim bEnteringAHighScore		' player is entering their name into the high score table


Dim nvR1, nvR2, nvR3, nvR4, nvR5
Dim highscoreOn
Dim LevelBall
Dim mLevelMagnet

PlaySound "Intro",-0






' *********************************************************************
' **                                                                 **
' **               Future Pinball Defined Script Events              **
' **                                                                 **
' *********************************************************************


' The Method Is Called Immediately the Game Engine is Ready to 
' Start Processing the Script.
'
Sub Table1_Init()
    LoadEM
    Dim i
    Randomize


    'Animation Ball Level 
    Set mLevelMagnet = New cvpmMagnet
    With mLevelMagnet
        .InitMagnet LevelMagnet, 5
		.GrabCenter = 0
        .CreateEvents "mLevelMagnet"
    End With
    mLevelMagnet.MagnetOn = 1

    Set LevelBall = BallLevel.Createsizedball(8):LevelBall.Image = "BolaAgua":BallLevel.Kick 0, 0

 
    'Impulse Plunger as autoplunger
    Const IMPowerSetting = 70 ' Plunger Power
    Const IMTime = 1.1        ' Time in seconds for Full Plunge
    Set plungerIM = New cvpmImpulseP
    With plungerIM
        .InitImpulseP swplunger, IMPowerSetting, IMTime
        .Random 1.5
        .InitExitSnd SoundFX("fx_kicker", DOFContactors), SoundFX("fx_solenoid", DOFContactors)
        .CreateEvents "plungerIM"
    End With

    'Boot Pinball
    BootE = True
    Boot.enabled = 1


	' kill the last switch hit (this this variable is very usefull for game control)
	LastSwitchHit = ""'DummyTrigger

	'HighScoreReward=1
    'load saved values, highscore, names, jackpot
    Loadhs

    'Reset HighScore
    'Reseths

    HighScoreReward = 0
    SpecialHighScoreReward = 0


    ' freeplay or coins
    bFreePlay = False 'we dont want coins

    ' initialse any other flags
    bOnTheFirstBall = False
    bBallInPlungerLane = False
    bBallSaverActive = False
    bBallSaverReady = False
    bMultiBallMode = False
    bGameInPlay = False
    bAutoPlunger = False
    bMusicOn = True
    bMusicOn = True
    bMusicOn = True
    BallsOnPlayfield = 0
    BallsInLock = 0
    BallsInHole = 0
    LastSwitchHit = ""
    Tilt = 0
    TiltSensitivity = 6
    Tilted = False
    bBonusHeld = False
    bJustStarted = True
    bInstantInfo = False
	BallsInDrain = 5
	matchon = false
    divertersafety


    'Replay
	replayscore = 7500000

    If Credits > 0 Then DOF 136, DOFOn

	EndOfGame()
    vpmtimer.addtimer 4000, "startattractmode '" 
	
End Sub

Dim LevelB
Sub LevelAnim()
    LevelB = True
 If LevelB = True Then
    mLevelMagnet.MagnetOn = 0
    vpmtimer.addtimer 500, "mLevelMagnet.MagnetOn = 1 '" 
 end If
End Sub

Sub BallLevelKick_Hit
    BallLevelKick.kick 0, 3
End Sub


Dim bootT
Dim BootE

Sub Boot_Timer
 bootT = bootT + 1 
 Select Case bootT
        Case 0: 
   hdisplay1.text = "EVIL DEAD ARMY OF DARKNESS"
   DisplayB2SText "EVIL DEAD ARMY OF DARKNESS"
   Playsound "fx_sys11_bootup"
        Case 1: 
   hdisplay1.text = "EVIL DEAD ARMY OF DARKNESS"
   DisplayB2SText "EVIL DEAD ARMY OF DARKNESS"
   Playsound "fx_sys11_bootup"
        Case 2: 
   hdisplay1.text = "EVIL DEAD ARMY OF DARKNESS"
   DisplayB2SText "EVIL DEAD ARMY OF DARKNESS"
   Playsound "fx_sys11_bootup"
        Case 3:
   bootT = 0
   BootE = False
   hdisplay1.text = " "
   DisplayB2SText " "
   boot.enabled = 0
   
End Select
End Sub


dim ballindrain

' The Played has Nudged the Table a little too hard/much and a Warning
' must be given to the player



sub killeverything()

	killatext()

	if jackpotshowon = true then

	killjackpotshow()

	end if

	if multiballon = true then

		multiballplayed = true
		multiballon = false
		lightjackpotlit = false
		jackpottimer.enabled = false

		endmultiballstrobes()
        StopAllSounds
		song = 2
        playsong2
		ward = false
		axel = false
		roy = false
		jenkins = false
		scarla = false
		resetlocklights()
		locklit = false
		ballinleftlock = false
		ballinrightlock = false
		multiballrestart = false
		ballslocked = ballslocked - ballslocked
		restartmultiballscored = false
		resetdiverters()

		if ((millionlit = true) or (twomillionlit = true)) then

		trashcantimer.interval = 1000
		trashcantimer.enabled = true

		millionlit = false
		twomillionlit = false

		hurryupshowtimer.enabled = false
		showinprogress = false
		hus = hus - hus

		end if

	end if

	if quickmultiballon = true then

		quickmultiballon = false
		quickmultiballlit = false

		nextquick = claw + 3

		endmultiballstrobes()

		resetdiverters()

		if locklitonhold = true then

			locklitonhold = false

			locklit = true
			song = 4

			rightdiverter.RotateToEnd
			leftdiverter.RotateToEnd
			leftdiverteropen = true
			rightdiverteropen = true

			wardlight.Set    Bulboff, "100000000011", 75
			axellight.Set    Bulboff, "010000000100", 75
			roylight.Set     Bulboff, "001000001000", 75
			jenkinslight.Set Bulboff, "000100010000", 75
			scarlalight.Set  Bulboff, "000011100000", 75

		end if

	end if

	if multiballrestart = true then

		multiballrestart = false
		leftdiverter.RotateToStart
		rightdiverter.RotateToStart
		leftdiverteropen = false
		rightdiverteropen = false
		restartmultiballtimer.enabled = false
		StopAllSounds
		song = 2
        playsong2
		ward = false
		axel = false
		roy = false
		jenkins = false
		scarla = false
       If B2SOn Then
         Controller.B2SSetData 9, 0
         Controller.B2SSetData 10, 0
         Controller.B2SSetData 11, 0
         Controller.B2SSetData 12, 0
         Controller.B2SSetData 13, 0
       End If
		resetlocklights()
		locklit = false
		ballinleftlock = false
		ballinrightlock = false
		multiballrestart = false
		ballslocked = ballslocked - ballslocked
		restartmultiballscored = false
		resetdiverters()

		timer.enabled = false
		time = 0

	end if

	showtimer.enabled = false
	showinprogress = false

	replayshowtimer.enabled = false
	replaydisplayshowtimer.enabled = false
	replayshowon = false
	rds = 0

	shooterspeechtimer.enabled = false
	statusspeechtimer.enabled = false

end sub

Sub leftstatustimer_Timer()

	statusreport()

end sub

Sub rightstatustimer_Timer()

	statusreport()

end sub


Sub leftstatustimer_Timer()

	statusreport()

end sub

Sub rightstatustimer_Timer()

	statusreport()

end sub

dim statusreporton
dim statusonhold

Sub statusreport()

if (blackout = false) and (tilted = false) then

	leftstatustimer.enabled=false
	rightstatustimer.enabled=false

	If ((multiballon = false) and (quickmultiballon = false) and (blackout = false) and (bonuson = false) and (ballsearchon = false) and (multiballrestart = false) and (bEnteringAHighScore = FALSE)) then

		if showinprogress = false then

			statustimer.enabled = true
			statusreporton = true
			status = status - status
			hdisplay1.text = " STATUS  REPORT "
			hdisplay2.text = "                "
			display1.text = " STATUS  REPORT "
			display2.text = "                "
			ballsearchtimer.enabled = false
			ballsearchon = false

		else

			statusonhold = true

		end if

	end if

end if

end sub

sub onholdstatus()

	statusonhold = false

	If ((multiballon = false) and (quickmultiballon = false) and (blackout = false) and (bonuson = false) and (ballsearchon = false) and (multiballrestart = false)) then

			statustimer.enabled = true
			statusreporton = true
			status = status - status
			hdisplay1.text = " STATUS  REPORT "
			hdisplay2.text = "                "
			display1.text = " STATUS  REPORT "
			display2.text = "                "
            DisplayB2SText2 " STATUS  REPORT " & "                "
			ballsearchtimer.enabled = false
			ballsearchon = false

	end if

end sub

dim status

sub statustimer_Timer()
    DMDUpdate.Enabled = 0
	status = status + 1
   Select Case status
	Case 0:

	if (extraballs = 0) or (extraballs > 1) then

		hdisplay1.text = "     BALL " & ball & "     "     
		hdisplay2.text = " " & extraballs & " EXTRA BALLS  "

		display1.text = "     BALL " & ball & "     "     
		display2.text = " " & extraballs & " EXTRA BALLS  "
        DisplayB2SText2 "     BALL " & ball & "     " & " " & extraballs & " EXTRA BALLS  "
	end if

	if (extraballs = 1) then

		hdisplay1.text = "     BALL " & ball & "     "     
		hdisplay2.text = " " & extraballs & " EXTRA BALL   "

		display1.text = "     BALL " & ball & "     "     
		display2.text = " " & extraballs & " EXTRA BALL   "
        DisplayB2SText2 "     BALL       " &ball   & " EXTRA BALL   "& extraballs
	end if




    Case 2: 

	hdisplay1.text = " BONUS = " & bonuspoints & "  "
	hdisplay2.text = " " & bonusx & "X MULTIPLIER  "

	display1.text = " BONUS = " & bonuspoints & "  "
	display2.text = " " & bonusx & "X MULTIPLIER  "
    DisplayB2SText2 " BONUS = " & bonuspoints & "  " & " " & bonusx & "X MULTIPLIER  "


	Case 3:

		If extraballslit > 0 then

			hdisplay1.text = "    " & jets & " BOOMSTICK   "	
			hdisplay2.text = "EXTRABALL IS LIT" 

			display1.text = "    " & jets & " BOOMSTICK   "	
			display2.text = "EXTRABALL IS LIT" 
            'DisplayB2SText2  "    " & jets & " BOOMSTICK   " & "EXTRABALL IS LIT"
            DisplayB2SText2 jets &"   < BOOMSTICK      " & "EXTRABALL IS LIT " & nextbumperaward
		else

			hdisplay1.text = "    " & jets & " BOOMSTICK   "	
			hdisplay2.text = " EX. BALL AT " & nextbumperaward 

			display1.text = "    " & jets & " BOOMSTICK   "	
			display2.text = " EX. BALL AT " & nextbumperaward 
            'DisplayB2SText2  "    " & jets & " BOOMSTICK   " & " EX. BALL AT " & nextbumperaward
            DisplayB2SText2 jets &"   < BOOMSTICK      " & " EXTRABALL AT  " & nextbumperaward
		end if



	Case 4:

		if claw = 1 then

			if quickmultiballlit = true then

				hdisplay1.text = "    1 BOOK      "     
				hdisplay2.text = "SHOOT LEFT RAMP "

				display1.text = "    1 BOOK      "     
				display2.text = "SHOOT LEFT RAMP "
                DisplayB2SText2 "   1 BOOK      " & "SHOOT LEFT RAMP "
			else

				hdisplay1.text = "    1 BOOK      "
				hdisplay2.text = "NEXT AWARD AT " & nextquick

				display1.text = "    1 BOOK      "
				display2.text = "NEXT AWARD AT " & nextquick
                DisplayB2SText2 "   1 BOOK      " & "  NEXT AWARD AT " & nextquick
			end if
		
		end if

		if (claw = 0) or (claw > 1) then

			if quickmultiballlit = true then

				hdisplay1.text = "    " & book & " BOOK    "
				hdisplay2.text = "SHOOT LEFT RAMP "

				display1.text = "    " & book & " BOOK    "
				display2.text = "SHOOT LEFT RAMP "
                DisplayB2SText2 claw & "  BOOK         " & "SHOOT LEFT RAMP "
			else

				hdisplay1.text = "    " & book & " BOOK    "
				hdisplay2.text = "NEXT AWARD AT " & nextquick

				display1.text = "    " & book & " BOOK    "
				display2.text = "NEXT AWARD AT " & nextquick
                DisplayB2SText2 claw & "  BOOK         " & "  NEXT AWARD AT " & nextquick
			end if

		end if


	Case 5:

	hdisplay1.text = "   RAMP VALUE   "
	display1.text = "   RAMP VALUE   "

		if ramp = 1 then

			hdisplay2.text = "     50000      "
			display2.text = "     50000      "
            DisplayB2SText2 "     50000      " & "                "
		end if

		if ramp = 2 then

			hdisplay2.text = "     75000      "
			display2.text = "     75000      "
            DisplayB2SText2 "     75000      " & "                "
		end if

		if ramp = 3 then

			hdisplay2.text = "     100000     "
			display2.text = "     100000     "
            DisplayB2SText2 "    100000      " & "                "
		end if

		if ramp = 4 then

			hdisplay2.text = "     125000     "
			display2.text = "     125000     "
            DisplayB2SText2 "    125000      " & "                "
		end if

		if ramp = 5 then

			hdisplay2.text = "     150000     "
			display2.text = "     150000     "
            DisplayB2SText2 "    150000      " & "                "
		end if



	Case 6: 


            DisplayB2SText2 "                " & "                "
  ' hdisplay1.flushqueue()
	'hdisplay2.flushqueue()

	'hdisplay1.slowblinkspeed = 30
	'hdisplay2.slowblinkspeed = 30

   'display1.flushqueue()
	'display2.flushqueue()

	'display1.slowblinkspeed = 30
	'display2.slowblinkspeed = 30

	if letters = 0 then

	hdisplay1.text = "B L A C K O U T "', sescrollupover, 50
	hdisplay2.text = "B L A C K O U T "', sescrollupover, 50
	hdisplay1.text = "B L A C K O U T "', seblinkmask, 2500
	hdisplay2.text = "B L A C K O U T "', seblinkmask, 2500

	display1.text = "B L A C K O U T "', sescrollupover, 50
	display2.text = "B L A C K O U T "', sescrollupover, 50
	display1.text = "B L A C K O U T "', seblinkmask, 2500
	display2.text = "B L A C K O U T "', seblinkmask, 2500
    DisplayB2SText2 "B L A C K O U T " & "B L A C K O U T "

	end if


	if letters = 1 then

	hdisplay1.text = "B L A C K O U T "', sescrollupover, 50
	hdisplay2.text = "B L A C K O U T "', sescrollupover, 50
	hdisplay1.text = "  L A C K O U T "', seblinkmask, 2500
	hdisplay2.text = "  L A C K O U T "', seblinkmask, 2500

	display1.text = "B L A C K O U T "', sescrollupover, 50
	display2.text = "B L A C K O U T "', sescrollupover, 50
	display1.text = "  L A C K O U T "', seblinkmask, 2500
	display2.text = "  L A C K O U T "', seblinkmask, 2500
    DisplayB2SText2 "B L A C K O U T " & "  L A C K O U T "
	end if

	if letters = 2 then

	hdisplay1.text = "B L A C K O U T "', sescrollupover, 50
	hdisplay2.text = "B L A C K O U T "', sescrollupover, 50
	hdisplay1.text = "    A C K O U T "', seblinkmask, 2500
	hdisplay2.text = "    A C K O U T "', seblinkmask, 2500

	display1.text = "B L A C K O U T "', sescrollupover, 50
	display2.text = "B L A C K O U T "', sescrollupover, 50
	display1.text = "    A C K O U T "', seblinkmask, 2500
	display2.text = "    A C K O U T "', seblinkmask, 2500
    DisplayB2SText2 "B L A C K O U T " & "    A C K O U T "
	end if

	if letters = 3 then

	hdisplay1.text = "B L A C K O U T "', sescrollupover, 50
	hdisplay2.text = "B L A C K O U T "', sescrollupover, 50
	hdisplay1.text = "      C K O U T "', seblinkmask, 2500
	hdisplay2.text = "      C K O U T "', seblinkmask, 2500

	display1.text = "B L A C K O U T "', sescrollupover, 50
	display2.text = "B L A C K O U T "', sescrollupover, 50
	display1.text = "      C K O U T "', seblinkmask, 2500
	display2.text = "      C K O U T "', seblinkmask, 2500
    DisplayB2SText2 "B L A C K O U T " & "      C K O U T "
	end if

	if letters = 4 then

	hdisplay1.text = "B L A C K O U T "', sescrollupover, 50
	hdisplay2.text = "B L A C K O U T "', sescrollupover, 50
	hdisplay1.text = "        K O U T "', seblinkmask, 2500
	hdisplay2.text = "        K O U T "', seblinkmask, 2500

	display1.text = "B L A C K O U T "', sescrollupover, 50
	display2.text = "B L A C K O U T "', sescrollupover, 50
	display1.text = "        K O U T "', seblinkmask, 2500
	display2.text = "        K O U T "', seblinkmask, 2500
    DisplayB2SText2 "B L A C K O U T " & "        K O U T "
	end if

	if letters = 5 then

	hdisplay1.text = "B L A C K O U T "', sescrollupover, 50
	hdisplay2.text = "B L A C K O U T "', sescrollupover, 50
	hdisplay1.text = "          O U T "', seblinkmask, 2500
	hdisplay2.text = "          O U T "', seblinkmask, 2500

	display1.text = "B L A C K O U T "', sescrollupover, 50
	display2.text = "B L A C K O U T "', sescrollupover, 50
	display1.text = "          O U T "', seblinkmask, 2500
	display2.text = "          O U T "', seblinkmask, 2500
    DisplayB2SText2 "B L A C K O U T " & "          O U T "
	end if

	if letters = 6 then

	hdisplay1.text = "B L A C K O U T "', sescrollupover, 50
	hdisplay2.text = "B L A C K O U T "', sescrollupover, 50
	hdisplay1.text = "            U T "', seblinkmask, 2500
	hdisplay2.text = "            U T "', seblinkmask, 2500

	display1.text = "B L A C K O U T "', sescrollupover, 50
	display2.text = "B L A C K O U T "', sescrollupover, 50
	display1.text = "            U T "', seblinkmask, 2500
	display2.text = "            U T "', seblinkmask, 2500
    DisplayB2SText2 "B L A C K O U T " & "            U T"
	end if

	if letters = 7 then

	hdisplay1.text = "B L A C K O U T "', sescrollupover, 50
	hdisplay2.text = "B L A C K O U T "', sescrollupover, 50
	hdisplay1.text = "              T "', seblinkmask, 2500
	hdisplay2.text = "              T "', seblinkmask, 2500

	display1.text = "B L A C K O U T "', sescrollupover, 50
	display2.text = "B L A C K O U T "', sescrollupover, 50
	display1.text = "              T "', seblinkmask, 2500
	display2.text = "              T "', seblinkmask, 2500
    DisplayB2SText2 "B L A C K O U T " & "              T "
	end if

	if letters > 7 then

	hdisplay1.text = "B L A C K O U T "', sescrollupover, 50
	hdisplay2.text = "B L A C K O U T "', sescrollupover, 50
	hdisplay1.text = "B L A C K O U T "', seblinkmask, 2500
	hdisplay2.text = "B L A C K O U T "', seblinkmask, 2500

	display1.text = "B L A C K O U T "', sescrollupover, 50
	display2.text = "B L A C K O U T "', sescrollupover, 50
	display1.text = "B L A C K O U T "', seblinkmask, 2500
	display2.text = "B L A C K O U T "', seblinkmask, 2500
    DisplayB2SText2 "B L A C K O U T " & "B L A C K O U T "

	end if




	Case 7:

 '  hdisplay1.flushqueue()
'	hdisplay2.flushqueue()

	hdisplay1.text = "  * TOP ASH *  "
	hdisplay2.text = "                "

 '  display1.flushqueue()
'	display2.flushqueue()

	display1.text = "  * TOP ASH *  "
	display2.text = "                "

    DisplayB2SText2 "  * TOP ASH *  " & "               "

	Case 8:

	hdisplay1.text = "THE BOOK MASTER"& " 1> " & SpecialHighScoreName(0) & ":" & SpecialHighScore(0)
	hdisplay2.text = " "' & nvHighScore2name & "  " & nvHighScore2

	'display1.text = " 1> " & nvHighScore1name & "  " & nvHighScore1
	'display2.text = " 2> " & nvHighScore2name & "  " & nvHighScore2

   ' DisplayB2SText " 1> " & nvHighScore1name & "  " & nvHighScore1 & " 2> " & nvHighScore2name & "  " & nvHighScore2
    DisplayB2SText2 "THE BOOK MASTER"& " 1> " & SpecialHighScoreName(0) & ":" & SpecialHighScore(0)' & "
	Case 9:

	hdisplay1.text = "THE BOOK MASTER"& " 2> " & SpecialHighScoreName(1) & ":" & SpecialHighScore(1)
	hdisplay2.text = " " 

	'display1.text = " 3> " & nvHighScore3name & "  " & nvHighScore3
	'display2.text = " 4> " & nvHighScore4name & "  " & nvHighScore4

    'DisplayB2SText " 3> " & nvHighScore3name & "  " & nvHighScore3 & " 4> " & nvHighScore4name & "  " & nvHighScore4
    DisplayB2SText2 "THE BOOK MASTER"& " 2> " & SpecialHighScoreName(1) & ":" & SpecialHighScore(1)' & "
	Case 10:

	hdisplay1.text = "THE BOOK MASTER"& " 3> " & SpecialHighScoreName(2) & ":" & SpecialHighScore(2)
	hdisplay2.text = " " '& (specialhighscorename) & " - " & (specialhighscore) & " BOOK "

	'display1.text = "THE BOOK MASTER "
	'display2.text = " " & (specialhighscorename) & " - " & (specialhighscore) & " BOOK "
    DisplayB2SText2 "THE BOOK MASTER"& " 3> " & SpecialHighScoreName(2) & ":" & SpecialHighScore(2)' & "


	Case 11:

	hdisplay1.text = "THE BOOK MASTER"& " 4> " & SpecialHighScoreName(3) & ":" & SpecialHighScore(3)
	hdisplay2.text = " "
    DisplayB2SText2 "THE BOOK MASTER"& " 4> " & SpecialHighScoreName(3) & ":" & SpecialHighScore(3)

	Case 12

	endstatusreport()
    status = 0
  End Select

end sub

sub endstatusreport()

	statustimer.enabled = false
	rightstatustimer.enabled=false
	leftstatustimer.enabled=false
	status = status - status
	statusreporton = false

	if bonuson = false then

		addscore(0)

	end if

end sub

' A Music Channel has finished Playing. 
'
' Channel is set to the channel number that has finished.
'
Sub FuturePinball_MusicFinished(ByVal Channel)

	if (channel = 1) then

		if multiballon = true then

			song = 5
			playsong2()

		end if

	end if

End Sub




' *********************************************************************
' **                                                                 **
' **                     User Defined Script Events                  **
' **                                                                 **
' *********************************************************************

' Initialise the Table for a new Game

dim gamestartshow
'
Sub ResetForNewGame()
	Dim	i


    GameOverAnimTimer.Enabled = False


    bGameInPLay = True

	'AddDebugText "ResetForNewGame"

	' get Future Pinball to zero out the nvScore (and nvSpecialScore) Variables
	' aswell and ensure the camera is looking in the right direction.
	' this also Sets the fpGameInPlay flag
	'BeginGame()
	Alllightsoff()	
	startgametimer.interval = 2000
	startgametimer.enabled = true
    
    StopAllSounds

	gamestartshow = true

	'lookatbackbox()

    LeftSlingshotRubber.Disabled = 0
    RightSlingshotRubber.Disabled = 0
    Bumper1.Force = 7
    Bumper2.Force = 7
    Bumper3.Force = 7


    SolLFlipper 1
    SolRFlipper 1

    LeftFlipper.RotateToStart
    RightFlipper.RotateToStart
    Upperflipper.RotateToStart

    Kickback.enabled = 1
    scoop.enabled = 1

	randomspeechstart = INT(RND(1)*2)+1

	'randomspeechstart = randomspeechstart + 1

	if randomspeechstart = 1 then

		start1 = true
		playsong "spchbustinout"', false, 0.8

	end if

	if randomspeechstart = 2 then

		playsong "spchwelcometonowhere"', false, 1.0
		start2 = true

		'randomspeechstart = randomspeechstart - randomspeechstart

	end if

	atexttimer.enabled = true

	Tablereset()

	'stopmusic 1
	'stopmusic 2

	' increment the total number of games played
   TotalGamesPlayed = TotalGamesPlayed + 1

	' Start with player 1
	CurrentPlayer = 1

	' Single player (for now, more can be added in later)
	PlayersPlayingGame = 1

	' We are on the First Ball (for Player One)
	bOnTheFirstBall = TRUE

	song = 1

	' initialise all the variables which are used for the duration of the game
	' (do all players incase any new ones start a game)
	For i = 1 To constMaxPlayers
		' Bonus Points for the current player
        Score(i) = 0
        claw = 0
        BonusPoints = 0
        BonusHeldPoints(i) = 0		
		' Initial Bonus Multiplier
		BonusMultiplier(i) = 1
		' Balls Per Game
		BallsRemaining(i) = BallsPerGame 
		' Number of EB's out-standing
		ExtraBallsAwards(i) = 0
	Next

	' initialise any other flags
	bMultiBallMode = FALSE

	' you may wish to start some music, play a sound, do whatever at this point

	' set up the start delay to handle any Start of Game Attract Sequence

End Sub

dim bonusx

sub alllightsoff()

	endattractmode()
  If B2SOn Then
    Controller.B2SSetData 9, 0
:   Controller.B2SSetData 10, 0
    Controller.B2SSetData 11, 0
    Controller.B2SSetData 12, 0
    Controller.B2SSetData 13, 0
  End If
	wardlight.state = 0
	axellight.state = 0
	roylight.state = 0
	jenkinslight.state = 0
	scarlalight.state = 0
	wardshotlight.state = 0
	royshotlight.state = 0
	axelshotlight.state = 0
	jenkinsshotlight.state = 0
	scarlashotlight.state = 0
	lock1light.state = 0
	lock2light.state = 0
	twoxlight.state = 0
	threexlight.state = 0
	fourxlight.state = 0
	fivexlight.state = 0
	clanelight.state = 0
	alanelight.state = 0
	tlanelight.state = 0
	clawlight1.state = 0
	clawlight2.state = 0
	clawlight3.state = 0
	clawlight4.state = 0
	quickmultiballlight.state = 0

	jlight.State = 0
	ulight.State = 0
	nlight.State = 0
	klight.State = 0

	ylight.State = 0
	alight.State = 0
	rlight.State = 0
	dlight.State = 0

	kickbacklight.State = 0
	shootagainlight.State = 0
	diverterlight.State = 0
	jackpot2light.State = 0
	randomawardlight.State = 0
	extraballlight.State = 0
	lightjackpotlight.State = 0
	jackpot1light.State = 0
	lightkickbacklight.State = 0	

	value1.state = bulboff
	value2.state = bulboff
	value3.state = bulboff
	value4.state = bulboff
	value5.state = bulboff

	bo1.state = bulboff
	bo2.state = bulboff
	bo3.state = bulboff
	bo4.state = bulboff
	bo5.state = bulboff
	bo6.state = bulboff
	bo7.state = bulboff
	bo8.state = bulboff
   If B2SOn Then
   Controller.B2SSetData 1, 0
   Controller.B2SSetData 2, 0
   Controller.B2SSetData 3, 0
   Controller.B2SSetData 4, 0
   Controller.B2SSetData 5, 0
   Controller.B2SSetData 6, 0
   Controller.B2SSetData 7, 0
   Controller.B2SSetData 8, 0
   End If

	TurnGIoff()

end sub

sub TurnGIoff()

gi1.state = 0
'gi2.state = bulboff
'gi3.state = bulboff
gi4.state = 0
gi5.state = 0
gi6.state = 0
gi7.state = 0
gi8.state = 0
gi9.state = 0
gi10.state = 0
gi11.state = 0
gi12.state = 0
gi13.state = 0
gi14.state = 0
gi15.state = 0
gi16.state = 0
gi17.state = 0
gi18.state = 0
gi19.state = 0
gi20.state = 0
gi21.state = 0
gi22.state = 0
'gi23.state = bulboff
gi24.state = 0
'gi25.state = bulboff
'gi26.state = bulboff
'gi27.state = bulboff
'gi28.state = bulboff
'gi29.state = bulboff
'gi30.state = bulboff
'gi31.state = bulboff
'gi32.state = bulboff
'gi33.state = bulboff
'gi34.state = bulboff
'gi35.state = bulboff
'gi36.state = bulboff
'gi37.state = bulboff
'gi38.state = bulboff
'gi39.state = bulboff
'gi40.state = bulboff
'gi41.state = bulboff
'gi42.state = bulboff
gi43.state = 0
gi44.state = 0
gi45.state = 0
gi46.state = 0
gi47.state = 0

Bumper1L.state = 0
bumper2L.state = 0
bumper3L.state = 0

end sub

sub TurnGIon()

gi1.state = Bulbon', "10", 150
'gi2.state = Bulbon', "10", 150
'gi3.state = Bulbon', "10", 150
gi4.state = Bulbon', "10", 150
gi5.state = Bulbon', "10", 150
gi6.state = Bulbon', "10", 150
gi7.state = Bulbon', "10", 150
gi8.state = Bulbon', "10", 150
gi9.state = Bulbon', "10", 150
gi10.state = Bulbon', "10", 150
gi11.state = Bulbon', "10", 150
gi12.state = Bulbon', "10", 150
gi13.state = Bulbon', "10", 150
gi14.state = Bulbon', "10", 150
gi15.state = Bulbon', "10", 150
gi16.state = Bulbon', "10", 150
gi17.state = Bulbon', "10", 150
gi18.state = Bulbon', "10", 150
gi19.state = Bulbon', "10", 150
gi20.state = Bulbon', "10", 150
gi21.state = Bulbon', "10", 150
gi22.state = Bulbon', "10", 150
'gi23.state = Bulbon', "10", 150
gi24.state = Bulbon', "10", 150
'gi25.set Bulbon, "10", 150
'gi26.set Bulbon, "10", 150
'gi27.set Bulbon, "10", 150
'gi28.set Bulbon, "10", 150
'gi29.set Bulbon, "10", 150
'gi30.set Bulbon, "10", 150
'gi31.set Bulbon, "10", 150
'gi32.set Bulbon, "10", 150
'gi33.set Bulbon, "10", 150
'gi34.set Bulbon, "10", 150
'gi35.set Bulbon, "10", 150
'gi36.set Bulbon, "10", 150
'gi37.set Bulbon, "10", 150
'gi38.set Bulbon, "10", 150
'gi39.set Bulbon, "10", 150
'gi40.set Bulbon, "10", 150
'gi41.set Bulbon, "10", 150
'gi42.set Bulbon, "10", 150
gi43.state = Bulbon', "10", 150
gi44.state = Bulbon', "10", 150
gi45.state = Bulbon', "10", 150
gi46.state = Bulbon', "10", 150
gi47.state = Bulbon
resetjetlights()

end sub

sub endattractmode()
    StopAttractMode
	attractmode = false
	attractphase = attractphase - attractphase
	'attracttimer.enabled = false
	Mainseq.stopplay()
	message = message - message
	attractmessagetimer.enabled = false
	'hdisplay1.flushqueue
	'hdisplay2.flushqueue
	
	hdisplay1.text = "                "
	hdisplay2.text = "                "

	'display1.flushqueue
	'display2.flushqueue
	
	display1.text = "                "
	display2.text = "                "

    DisplayB2SText "               " & "               "

end sub

dim leftdiverteropen
dim rightdiverteropen
dim ballsearchon

Sub Tablereset()
 If B2SOn Then
 Controller.B2SSetData 9, 0
 Controller.B2SSetData 10, 0
 Controller.B2SSetData 11, 0
 Controller.B2SSetData 12, 0
 Controller.B2SSetData 13, 0
 End If

	noswitchhit = true
	ward = false
	axel = false
	roy = false
	jenkins = false
	scarla = false
	leftloop = false
	rightloop = false
	royloop = false
	locklit = false
	resettargets()
	autolaunch = false
	ballinleftlock = false
	ballinrightlock = false
	ballslocked = ballslocked - ballslocked
	leftlock.destroyball
	rightlock.destroyball

  If  leftdiverter.RotatetoEnd or rightdiverter.RotatetoEnd Then
    Playsound "DiverterOff"
  End If

	leftdiverter.RotatetoStart
	rightdiverter.RotatetoStart

	leftdiverteropen = false
	rightdiverteropen = false
	multiballon = false
	multiballrestart = false
	multiballsaver = false
	multiballplayed = false
	jackpotscored = false
	lightkickback()
	bonusx = 1
	bonuspoints = 0
	displaybonus = 0
	displayscore = 0
	claw = 0
	banks = 0
	nextquick = 1
	nextrandomaward = 0
	quickmultiballlit = false
	quickmultiballon = false
	locklitonhold = false
	lighttrashcan()
	millionlit = false
	twomillionlit = false
    lightjackpotlit = false
	ballintrashcan = false
	extraballs = false
	nextbumperaward = 200
	jets = 0
	displayinterrupt = false
	showinprogress = false
	extraballslit = extraballslit - extraballslit
	ball = ball - ball
	ballsearchon = false
	outlanes = outlanes - outlanes
	highscoreOn = false
	speechstatusblinking = false
	match = 0
	blackout = false
	blackoutlit = false
	checkblackout()
	turnoffblackout()
	blackoutdrain = false
	replayscored = false
    congrats = false
    extraballsscored = 0
	extraballs = 0
	twinklesides = false
	multiballstrobes = false
	ballsaveoutlanesafety = false
	balljustsaved = false
	specialscore(currentplayer) = 0
	lockballonhold = false
	blackoutjackpotscored = false
	multiballshowon = false
	randomawardshowon = false
	extraballshowon = false
	ballindrain = true

	if letters > 7 then

	letters = 7

	checkblackout()

	end if

end sub

dim randomspeechstart

sub startgametimer_Timer()

	startgametimer.enabled = false
	resetlights()

	ResetForNewPlayerBall()

	CreateNewBall()

end sub

sub resetlights()

	if locklit = true then

		wardshotlight.State =    1', "10", 200
		royshotlight.State =     1', "10", 200
		axelshotlight.State =    1', "10", 200
		jenkinsshotlight.State = 1', "10", 200
		scarlashotlight.State =  1', "10", 200

		wardlight.State =    2', "100000000011", 75
		axellight.State =    2', "010000000100", 75
		roylight.State =     2', "001000001000", 75
		jenkinslight.State = 2', "000100010000", 75
		scarlalight.State =  2', "000011100000", 75

		if ballinleftlock = true then

			lock1light.State = 1', "10", 150

		else

			lock1light.State = 2', "10", 150

		end if

		if ballinrightlock = true then

			lock2light.State = 1', "10", 150

		else

			lock2light.State = 2', "10", 150

		end if

	else

		if ward = true then

			wardshotlight.State =    1', "10", 200
			wardlight.State = 1', "10", 150
           If B2SOn Then
            startB2S (9)
            Controller.B2SSetData 9, 1
           End If
		else

			wardshotlight.State =    2', "10", 200
			wardlight.State = 0', "10", 150
           If B2SOn Then
            Controller.B2SSetData 9, 0
           End If
		end if

		if axel = true then

			axelshotlight.State =    1', "10", 200
			axellight.State = 1', "10", 150
           If B2SOn Then
            startB2S (10)
            Controller.B2SSetData 10, 1
           End If
		else

			axelshotlight.State =    2', "10", 200
			axellight.State = 0', "10", 150
           If B2SOn Then
            Controller.B2SSetData 10, 0
           End If
		end if

		if roy = true then

			royshotlight.State =    1', "10", 200
			roylight.State = 1', "10", 150
           If B2SOn Then
            startB2S (11)
            Controller.B2SSetData 11, 1
           End If
		else

			royshotlight.State =    2', "10", 200
			roylight.State = 0', "10", 150
           If B2SOn Then
            Controller.B2SSetData 11, 0
           End If
		end if

		if jenkins = true then

			jenkinsshotlight.State =    1', "10", 200
			jenkinslight.State = 1', "10", 150
           If B2SOn Then
            startB2S (12)
            Controller.B2SSetData 12, 1
           End If
		else

			jenkinsshotlight.State =    2', "10", 200
			jenkinslight.State = 0', "10", 150
           If B2SOn Then
            Controller.B2SSetData 12, 0
           End If
		end if

		if scarla = true then

			scarlashotlight.State =    1', "10", 200
			scarlalight.State = 1', "10", 150
           If B2SOn Then
            startB2S (13)
            Controller.B2SSetData 13, 1
           End If
		else

			scarlashotlight.State =    2', "10", 200
			scarlalight.State = 0', "10", 150
           If B2SOn Then
            Controller.B2SSetData 13, 0
           End If
		end if

		lock1light.State = 0', "10", 150
		lock2light.State = 0', "10", 150

	end if

	if bonusx = 1 then

	twoxlight.State = 0', "10", 150
	threexlight.State = 0', "10", 150
	fourxlight.State = 0', "10", 150
	fivexlight.State = 0', "10", 150

	end if

	if bonusx = 2 then

	twoxlight.State = 1', "10", 150
	threexlight.State = 0', "10", 150
	fourxlight.State = 0', "10", 150
	fivexlight.State = 0', "10", 150

	end if

	if bonusx = 3 then

	twoxlight.State = 1', "10", 150
	threexlight.State = 1', "10", 150
	fourxlight.State = 0', "10", 150
	fivexlight.State = 0', "10", 150

	end if

	if bonusx = 4 then

	twoxlight.State = 1', "10", 150
	threexlight.State = 1', "10", 150
	fourxlight.State = 1', "10", 150
	fivexlight.State = 0', "10", 150

	end if

	if bonusx = 5 then

	twoxlight.State = 1', "10", 150
	threexlight.State = 1', "10", 150
	fourxlight.State = 1', "10", 150
	fivexlight.State = 1', "10", 150

	end if

	clanelight.State = 0', "10", 150
	alanelight.State = 0', "10", 150
	tlanelight.State = 0', "10", 150
	clawlight1.State = 0', "10", 150
	clawlight2.State = 0',' "10", 150
	clawlight3.State = 0',' "10", 150
	clawlight4.State = 0', "10", 150

	if quickmultiballlit = true then

		quickmultiballlight.State = 2', "10", 150

	else

		quickmultiballlight.State = 0', "10", 150

	end if

	if jtarget.Isdropped = true then

		jlight.State = 1', "10", 150

	else

		jlight.State = 0', "10", 150

	end if

	if utarget.Isdropped = true then

		ulight.State = 1', "10", 150

	else

		ulight.State = 0', "10", 150

	end if

	if ntarget.Isdropped = true then

		nlight.State = 1', "10", 150

	else

		nlight.State = 0', "10", 150

	end if

	if ktarget.Isdropped = true then

		klight.State = 1', "10", 150

	else

		klight.State = 0', "10", 150

	end if

	if ytarget.Isdropped = true then

		ylight.State = 1', "10", 150

	else

		ylight.State = 0', "10", 150

	end if

	if atarget.Isdropped = true then

		alight.State = 1', "10", 150

	else

		alight.State = 0', "10", 150

	end if

	if rtarget.Isdropped = true then

		rlight.State = 1', "10", 150

	else

		rlight.State = 0', "10", 150

	end if

	if dtarget.Isdropped = true then

		dlight.State = 1', "10", 150

	else

		dlight.State = 0', "10", 150

	end if

	if kickbacklit = true then

		kickbacklight.State = 1', "10", 150
		lightkickbacklight.State = 0', "10", 150

	else

		kickbacklight.State = 0', "10", 150
		lightkickbacklight.State = 1', "10", 150

	end if

	if extraballs > 0 then

		shootagainlight.State = 1', "10", 150

	end if

	if extraballs = 0 then

		shootagainlight.State = 0', "10", 150

	end if

	if extraballslit > 0 then

		extraballlight.State = 1', "10", 150

	else

		extraballlight.State = 0', "10", 150

	end if

	if trashcanlit = true then

		randomawardlight.State = 1', "10", 150

	else

		randomawardlight.State = 0', "10", 150

	end if

	lightjackpotlight.State = 0', "10", 150
	jackpot1light.State = 0', "10", 150
	diverterlight.State = 0', "10", 150
	jackpot2light.State = 0', "10", 150

	resetvaluelights()

	TurnGIon()

end sub


' This Timer is used to delay the start of a game to allow any attract sequence to 
' complete.  When it expires it creates a ball for the player to start playing with
'
Sub FirstBallDelayTimer_Timer()
	' stop the timer
	FirstBallDelayTimer.Enabled = FALSE

	' reset the table for a new ball
	ResetForNewPlayerBall()



	' create a new ball in the shooters lane
	CreateNewBall()
End Sub


' (Re-)Initialise the Table for a new ball (either a new ball after the player has 
' lost one or we have moved onto the next player (if multiple are playing))
'
Sub ResetForNewPlayerBall()
	' make sure the correct display is upto date
	AddScore(0)
    addclaw(0)
	' set the current players bonus multiplier back down to 1X
	SetBonusMultiplier(1)




	' reset any drop targets, lights, game modes etc..
	ShootAgainLight.State = 2
	ballsave = true

	resettargets()

	musicstarted = false
	noswitchhit = true
	lightkickback()

	resetvaluelights()

	twoxlight.state = 0
	threexlight.state = 0
	fourxlight.state = 0
	fivexlight.state = 0

	clanelight.state = 0', "10", 150
	alanelight.state = 0', "10", 150
	tlanelight.state = 0', "10", 150	

	bonusx = 1
	bonuspoints = 10000

	if superjets = true then

		endsuperjets()

	end if

	if extraballs = 0 then

		ball = ball + 1
		addscore(0)
        addclaw(0)
		if ball = 3 then

			showhighscore()

		end if

	else 

	extraballs = extraballs - 1 
	shootagainshow()

	end if

	if ((locklit = true) and (ballinrightlock = false)) then

	rightdiverter.RotateToStart
	rightdiverteropen = false

	end if

	playsound "jycsfx10"', false, 0.8

	'lookatplayfield()

	If locklit = false then
	song = 1
	playsong2()
	end if

	If locklit = true then
	song = 3
	playsong2()
	end if

	shooterspeechtimer.enabled = true

	if gamestartshow = true then

	gamestartshow = false

	end if

End Sub

sub showhighscore()

	shootagainshowtimer.enabled = true
	showinprogress = true

	'hdisplay1.flushqueue()
	'hdisplay2.flushqueue()

	'hdisplay1.slowblinkspeed = 30
	'hdisplay2.slowblinkspeed = 30

	'display1.flushqueue()
	''display2.flushqueue()

	'display1.slowblinkspeed = 30
	'display2.slowblinkspeed = 30

	if replayscored = true then

	hdisplay1.text = " HIGHEST SCORE  "', seBlink, 3000
	'hdisplay2.text = "   " & nvHighScore1 & "     "', seBlink, 3000

	display1.text = " HIGHEST SCORE  "', seBlink, 3000
	'display2.text = "   " & nvHighScore1 & "     "', seBlink, 3000

    DisplayB2SText2 " HIGHEST SCORE  " & "               "

	else

	hdisplay1.text = " EXTRA BALL AT  "', seBlink, 3000
	hdisplay2.text = "    " & replayscore & "     "', seBlink, 3000

	display1.text = " EXTRA BALL AT  "', seBlink, 3000
	display2.text = "    " & replayscore & "     "', seBlink, 3000

    DisplayB2SText2 " EXTRA BALL AT  " & "    " & replayscore & "     "

	end if

end sub

sub shooterspeechtimer_Timer()

	playsound "spchenoughletsgo"', false, 0.8
	fademusic()

	shooterspeechtimer.enabled = false

end sub

sub shootagainshow()

	shootagainshowtimer.enabled = true
	showinprogress = true

	playsound "spchshootagain"', false, 1.0
	fademusic()

	'hdisplay1.slowblinkspeed = 30
	'hdisplay2.slowblinkspeed = 30
	hdisplay1.text = "  SHOOT  AGAIN  "', seBlink, 3000
	'hdisplay2.queuetext "                ", seBlink, 3000

	'display1.slowblinkspeed = 30
	'display2.slowblinkspeed = 30
	display1.text = "  SHOOT  AGAIN  "', seBlink, 3000
	display2.text = "                "', seBlink, 3000

    DisplayB2SText2 "  SHOOT  AGAIN  " & "                "

end sub

sub shootagainshowtimer_Timer()

	shootagainshowtimer.enabled = false
	showinprogress = false
	'hdisplay1.flushqueue
	'hdisplay2.flushqueue
	'display1.flushqueue
	'display2.flushqueue
	addscore(0)
    addclaw(0)
end sub


' Create a new ball on the Playfield
'
Sub CreateNewBall()
	' create a ball in the plunger lane kicker.
	PlungerKicker.CreateBall

	' There is a (or another) ball on the playfield
	BallsOnPlayfield = BallsOnPlayfield + 1
	Ballsindrain = Ballsindrain - 1

	ballindrain = false

	' kick it out..
	PlungerKicker.kick 90, 8
    'Playsound "BallRelease"
    PlaySound SoundFXDOF("fx_Ballrel",122,DOFPulse,DOFContactors), 0, 1, 0.1, 0.1

End Sub





' The Player has lost his ball (there are no more balls on the playfield).
' Handle any bonus points awarded

Dim BonusDelayTime
'
Sub EndOfBall()

	ballsearchtimer.enabled = false
	ballsearchon = false

	if statusreporton = true then

	endstatusreport()

	end if

	bOnTheFirstBall = FALSE

	If (Tilted = FALSE) Then

		Dim AwardPoints

		displaybonus = bonuspoints
		displayscore = score(currentplayer)

		if musicstarted = false then

			bonusshowtimer.interval = 750
			bonusshowtimer.enabled = true

		else

			delaybonustimer.enabled = true
            StopAllSounds

		end if

	else

		Bonusdelaytime = 1000
	
		EndOfBallTimer.Interval = BonusDelayTime
		EndOfBallTimer.Enabled = TRUE

	End If

End Sub

sub delaybonustimer_Timer()

	 delaybonustimer.enabled = false
	 bonusshowtimer.interval = 750
	 bonusshowtimer.enabled = true

end sub

'dim bonuspoints
dim bonusshow
dim bonuson

sub bonusshowtimer_Timer()
    DMDUpdate.Enabled = 0
    StopAllSounds
 If B2SOn Then
	Controller.B2SSetData 14, 0
    Controller.B2SSetData 15, 0
    Controller.B2SSetData 16, 0
    Controller.B2SSetData 17, 0
    Controller.B2SSetData 18, 0
	Controller.B2SSetData 19, 0
	Controller.B2SSetData 20, 0
	Controller.B2SSetData 21, 0
	Controller.B2SSetData 22, 0
	Controller.B2SSetData 23, 0
	Controller.B2SSetData 24, 0
 End If

	bonusshow = bonusshow + 1

	select case bonusshow

	case 1:

	if bonuspoints = 99000 then

	playSound "jycsfx61"', false, 0.9

	else

	playSound "jycsfx1"', false, 0.7

	end if

	'lookatbackbox()
	bonuson = true

	hdisplay1.text = "  BONUS " & displaybonus', seScrollRightOver
	hdisplay2.text = "                "', seScrollRightOver

	display1.text = "  BONUS " & displaybonus', seScrollRightOver
	display2.text = "                "', seScrollRightOver

    DisplayB2SText " BONUS "&displaybonus & "         "& displayscore & "   "

	case 2:

	playSound "jycsfx14"', false, 0.7

	hdisplay2.text = "        " & displayscore', senone
	display2.text = "        " & displayscore', senone
    DisplayB2SText " BONUS " &displayscore & "             "


	case 3:

	Bonus()
	bonusshowtimer.interval = 100

	case 23:

	if bonusfinishedcounting = false then

		displayscore = displayscore + displaybonus
		hdisplay2.text = "        " & displayscore

		display2.text = "        " & displayscore
    DisplayB2SText " BONUS "&displaybonus & "         "& displayscore & "   "


	end if

	bonuscounter.enabled = false
	'hdisplay2.flushqueue
	'display2.flushqueue

	if bonusx = 1 then

	hdisplay1.text = "1X"', seBonusTrailIn
	display1.text = "1X"', seBonusTrailIn
    DisplayB2SText "       1X       "  & "     "& displayscore
	end if

	if bonusx = 2 then

	hdisplay1.text = "1X"', seBonusTrailIn, 300
	hdisplay1.text = "2X"', seBonusTrailIn, 300
	display1.text = "1X"', seBonusTrailIn, 300
	display1.text = "2X"', seBonusTrailIn, 300
    DisplayB2SText "       2X       "  & "     "& displayscore
	end if

	if bonusx = 3 then

	hdisplay1.text = "1X"', seBonusTrailIn, 300
	hdisplay1.text = "2X"', seBonusTrailIn, 300 
	hdisplay1.text = "3X"', seBonusTrailIn, 300 
	display1.text = "1X"', seBonusTrailIn, 300
	display1.text = "2X"', seBonusTrailIn, 300 
	display1.text = "3X"', seBonusTrailIn, 300 
    DisplayB2SText "       3X       "  & "     "& displayscore
	end if

	if bonusx = 4 then

	hdisplay1.text = "1X"', seBonusTrailIn, 300
	hdisplay1.text = "2X"', seBonusTrailIn, 300
	hdisplay1.text = "3X"', seBonusTrailIn, 300 
	hdisplay1.text = "4X"', seBonusTrailIn, 300  
	display1.text = "1X"', seBonusTrailIn, 300
	display1.text = "2X"', seBonusTrailIn, 300
	display1.text = "3X"', seBonusTrailIn, 300 
	display1.text = "4X"', seBonusTrailIn, 300  
    DisplayB2SText "       4X       " & "     "& displayscore
	end if

	if bonusx = 5 then

	hdisplay1.text = "1X"', seBonusTrailIn, 300
	hdisplay1.text = "2X"', seBonusTrailIn, 300 
	hdisplay1.text = "3X"', seBonusTrailIn, 300 
	hdisplay1.text = "4X"', seBonusTrailIn, 300 
	hdisplay1.text = "5X"', seBonusTrailIn, 300 

	'hdisplay1.slowblinkspeed = 30
	'hdisplay2.slowblinkspeed = 30

	hdisplay1.text = "       5X       "', seBlinkMask, 4000

	display1.text = "1X"', seBonusTrailIn, 300
	display1.text = "2X"', seBonusTrailIn, 300 
	display1.text = "3X"', seBonusTrailIn, 300 
	display1.text = "4X"', seBonusTrailIn, 300 
	display1.text = "5X"', seBonusTrailIn, 300 
	'display1.slowblinkspeed = 30
	'display2.slowblinkspeed = 30

	display1.text = "       5X       "', seBlinkMask, 4000
    DisplayB2SText "       5X       " & "     "& displayscore

	end if

	case 28:

	if bonusx > 1 then

	displayscore = displayscore + bonuspoints
	'hdisplay2.flushqueue
	hdisplay2.text = "        " & displayscore', seWipeBarUp

	'display2.flushqueue
	display2.text = "        " & displayscore', seWipeBarUp
    DisplayB2SText "       2X       "  & "     "& displayscore

	checkreplay()

	end if

	case 34:

	if bonusx > 2 then

	displayscore = displayscore + bonuspoints
	'hdisplay2.flushqueue
	hdisplay2.text = "        " & displayscore', seWipeBarUp

	'display2.flushqueue
	display2.text = "        " & displayscore', seWipeBarUp
    DisplayB2SText "       3X       "  & "     "& displayscore
	checkreplay()

	end if

	case 40:

	if bonusx > 3 then

	displayscore = displayscore + bonuspoints
	'hdisplay2.flushqueue
	hdisplay2.text = "        " & displayscore', seWipeBarUp

	'display2.flushqueue
	display2.text = "        " & displayscore', seWipeBarUp
    DisplayB2SText "       4X       "  & "     "& displayscore
	checkreplay()

	end if

	case 46:

	if bonusx > 4 then

	displayscore = displayscore + bonuspoints
	'hdisplay2.flushqueue
	hdisplay2.text = "        " & displayscore', seWipeBarUp

	'display2.flushqueue
	display2.text = "        " & displayscore', seWipeBarUp
    DisplayB2SText "       5X       "  & "     "& displayscore
	checkreplay()

	end if

	case 47:

	bonusshowtimer.enabled = false
	bonusshow = bonusshow - bonusshow

	end select

end sub

sub checkreplay()

		if (displayscore > replayscore) and (replayscored = false) then

			playsound "fx_knocker"
			scorereplay()

		end if

end sub

dim displaybonus
dim displayscore

sub Bonus()

	select case bonusx

	case 1:

	Bonusdelaytime = 5000
	Playsound "jycbonus1x"', false, 0.8

	case 2:

	Bonusdelaytime = 6000
	Playsound "jycbonus2x"', false, 0.8

	case 3:

	Bonusdelaytime = 7000
	Playsound "jycbonus3x"', false, 0.8
'
	case 4:

	Bonusdelaytime = 8000
	Playsound "jycbonus4x"', false, 0.8

	case 5:

	Bonusdelaytime = 9000
	Playsound "jycbonus5x"', false, 0.8

	end select

	countbonus()

	EndOfBallTimer.Interval = BonusDelayTime
	EndOfBallTimer.Enabled = TRUE

end sub

sub countbonus()

	bonuscounter.enabled = true

end sub

dim bonusfinishedcounting

sub bonuscounter_Timer()

	if displaybonus <> 0 then

		bonusfinishedcounting = false

		if displaybonus > 20001 then

		displaybonus = displaybonus - 700
		displayscore = displayscore + 700
	
		end if

		if (displaybonus > 10001) and (displaybonus < 20001) then

		displaybonus = displaybonus - 350
		displayscore = displayscore + 350
	
		end if

		if (displaybonus < 10001) and (displaybonus > 1001) then

		displaybonus = displaybonus - 100
		displayscore = displayscore + 100

		end if

		if (displaybonus < 1001) then

		displaybonus = displaybonus - 50
		displayscore = displayscore + 50

		end if

		checkreplay()

	else
	
	bonuscounter.enabled = false
	bonusfinishedcounting = true

	end if

	hdisplay1.text = "  BONUS " & displaybonus
	hdisplay2.text = "        " & displayscore

	display1.text = "  BONUS " & displaybonus
	display2.text = "        " & displayscore
    DisplayB2SText " BONUS "&displaybonus & "         "& displayscore & "   "
end sub

sub skipbonus()

	bonuscounter.enabled = false
	bonusfinishedcounting = true

	'hdisplay1.flushqueue
	'hdisplay2.flushqueue

	'display1.flushqueue
	'display2.flushqueue

	bonusshowtimer.enabled = false
	bonusshow = bonusshow - bonusshow
    StopAllSounds
	'stopmusic 1

	bonuspoints = bonuspoints * bonusx
	endofballt()

end sub


' The Timer which delays the machine to allow any bonus points to be added up
' has expired.  Check to see if there are any extra balls for this player.
' if not, then check to see if this was the last ball (of the currentplayer)
'
Sub EndOfBallTimer_Timer()
	bonuspoints = bonuspoints * bonusx
	endofballt()
End Sub

sub endofballt()
' disable the timer
	EndOfBallTimer.Enabled = FALSE
	bonuson = false
	
	addscore(bonuspoints)

	

	' if were tilted, reset the internal tilted flag (this will also 
	' set fpTiltWarnings back to zero) which is useful if we are changing player LOL
	Tilted = FALSE

	' has the player won an extra-ball ? (might be multiple outstanding)
	If (ExtraBallsAwards(CurrentPlayer) <> 0) Then

		'AddDebugText "Extra Ball"

		' yep got to give it to them
		ExtraBallsAwards(CurrentPlayer) = ExtraBallsAwards(CurrentPlayer) - 1

		' if no more EB's then turn off any shoot again light
		If (ExtraBallsAwards(CurrentPlayer) = 0) Then
			ShootAgainLight.State = 0
		End If

		' You may wish to do a bit of a song and dance at this point

		' Create a new ball in the shooters lane
		CreateNewBall()
		


	Else	' no extra balls

		BallsRemaining(CurrentPlayer) = BallsRemaining(CurrentPlayer) - 1

		' was that the last ball ?
		If ((ball = 3) and (extraballs = 0)) Then

			'AddDebugText "No More Balls, High Score Entry"

			' Submit the currentplayers score to the High Score system built into Future Pinball
			' if they have gotten a high score then it will ask them for their initials.  If not
			' it will call the FuturePinball_NameEntryComplete right away
           If B2SOn Then
            Controller.B2SSetData 9, 0
            Controller.B2SSetData 10, 0
            Controller.B2SSetData 11, 0
            Controller.B2SSetData 12, 0
            Controller.B2SSetData 13, 0
           End If

			addscore(0)
            addclaw(0)
            letters = 0
            
            CheckHighscore



	'	if (score(currentplayer)) > (highscore(4)) or (specialscore(currentplayer)) > (specialhighscore(4)) then

			'song = 10
			'playsong2()
     '       PlaySong  "mu_jychighscore"
	'		highscoreOn = true
			'playSOUND "spchnicework"', false, 0.8, 100
			'fademusic()

			'credits = credits + 1
			'playsound "fx_knocker"

	'	end if
			' you may wish to play some music at this point

		 Else


            
			' not the last ball (for that player)
			' if multiple players are playing then move onto the next one
			EndOfBallComplete()

		End If
	End If
end sub

'dim highscore


' This function is called when the end of bonus display
' (or high score entry finished) and it either end the game or
' move onto the next player (or the next ball of the same player)
'
Sub EndOfBallComplete()
  Dim NextPlayer

      
	'AddDebugText "EndOfBall - Complete"

	' are there multiple players playing this game ?
	If (PlayersPlayingGame > 1) Then
		' then move to the next player
		NextPlayer = CurrentPlayer + 1
		' are we going from the last player back to the first
		' (ie say from player 4 back to player 1)
		If (NextPlayer > PlayersPlayingGame) Then
			NextPlayer = 1
		End If
	Else
		NextPlayer = CurrentPlayer
	End If

	'AddDebugText "Next Player = " & NextPlayer

   ' is it the end of the game ? (all balls been lost for all players)
	If ((ball = 3) and (extraballs = 0)) Then
        
		' you may wish to do some sort of Point Match free game award here
		' generally only done when not in free play mode

		' set the machine into game over mode
      EndOfGame()
	  
	  vpmtimer.AddTimer 500, "Gameover() '"
	  vpmtimer.AddTimer 800, "Playmatch() '" 

		' you may wish to put a Game Over message on the 

	Else
		' set the next player
		CurrentPlayer = NextPlayer

		' make sure the correct display is upto date
		AddScore(0)
        addclaw(0)
		' reset the playfield for the new player (or new ball)
		ResetForNewPlayerBall()

		' and create a new ball
		CreateNewBall()

	End If
End Sub

'dim leftflipperon
'dim rightflipperon

' This frunction is called at the End of the Game, it should reset all
' Drop targets, and eject any 'held' balls, start any attract sequences etc..
Sub EndOfGame()
	'AddDebugText "End Of Game"

	' let Future Pinball know that the game has finished.  
	' This also clear the fpGameInPlay flag.
	'EndGame()

    bGameInPLay = False

	' ensure that the flippers are down
    SollFlipper 0
    SolrFlipper 0


	if statusreporton = true then
	
	endstatusreport()

	end if

	' set any lights for the attract mode

	' you may wish to light any Game Over Light you may have
End Sub

Dim Lol
Sub GameOverAnimTimer_Timer
 If B2SOn Then
  Lol = Lol + 1
  Select Case Lol
         case 1
         vpmtimer.addtimer 100, "Controller.B2SSetData 36, 1 '"

         case 2
         vpmtimer.addtimer 100, "Controller.B2SSetData 36, 0 '"
           Lol = 0
  End Select
 End If
End Sub


dim matchon
dim displaymatch

sub playmatch()
    DMDUpdate.Enabled = 0
	matchon = true
	matchtimer.enabled = true
	'lookatbackbox()

	alllightsoff()

	matchplayer.interval = 10
	matchplayer.enabled = true

	PlaySong "mu_jycmatch"', false, 0.8

	if match = 0 then

	displaymatch = 00

	end if

	if match = 1 then

	displaymatch = 10

	end if

	if match = 2 then

	displaymatch = 20

	end if

	if match = 3 then

	displaymatch = 30

	end if

	if match = 4 then

	displaymatch = 40

	end if

	if match = 5 then

	displaymatch = 50

	end if

	if match = 6 then

	displaymatch = 60

	end if

	if match = 7 then

	displaymatch = 70

	end if

	if match = 8 then

	displaymatch = 80

	end if

	if match = 9 then

	displaymatch = 90

	end if

	if match = 0 Then

	hdisplay1.text =  " MATCH 00       "', seblink, 1000
	hdisplay2.text = "                "
     DisplayB2SText "    MATCH 00    " & "                "


	display1.text =  " MATCH 00       "', seblink, 1000
	display2.text = "                "

	else

	hdisplay1.text = " MATCH " & displaymatch & "       "', seblink, 1000
	hdisplay2.text = "                "
     DisplayB2SText "    MATCH            " & "           "& displaymatch

	display1.text = " MATCH " & displaymatch & "       "', seblink, 1000
	display2.text = "                "

	end if

end sub

dim matchplay
dim actualmatch
dim displayactualmatch

sub Matchplayer_Timer()

	matchplay = matchplay + 1

	If matchplay = 100 then

			hdisplay2.text = "   :?  70  #$   "', seNone 
			display2.text = "   :?  70  #$   "', seNone
            DisplayB2SText "   :?  70  #$   " & "                "
	end if

	If matchplay = 101 then

			hdisplay2.text = "   @?  10  #%   "', seNone 
			display2.text = "   @?  10  #%   "', seNone 
            DisplayB2SText "   @?  10  #%   " & "                "
	end if

	If matchplay = 102 then

			hdisplay2.text = "   :?  30  #$   "', seNone 
			display2.text =  "   :?  30  #$   "', seNone 
            DisplayB2SText "   :?  30  #$   " & "                "
	end if

	If matchplay = 103 then

			hdisplay2.text = "   @?  90  #%   "', seNone 
			display2.text =  "   @?  90  #%   "', seNone 
            DisplayB2SText "   @?  90  #%   " & "                "
	end if

	If matchplay = 104 then

			hdisplay2.text = "   :?  00  #$   "', seNone
			display2.text =  "   :?  00  #$   "', seNone
            DisplayB2SText "   :?  00  #$   " & "                "
			matchplayer.interval = 30

	end if

	If matchplay = 105 then

			hdisplay2.text = "   @?  20  #%   "', seNone 
			display2.text =  "   @?  20  #%   "', seNone 
            DisplayB2SText "   @?  20  #%   " & "                "
	end if

	If matchplay = 106 then

			hdisplay2.text =  "   :?  40  #$   "', seNone 
			display2.text =  "   :?  40  #$   "', seNone 
            DisplayB2SText "   :?  40  #$   " & "                "
	end if

	If matchplay = 107 then

			hdisplay2.text = "   @?  60  #%   "', seNone 
			display2.text =  "   @?  60  #%   "', seNone 
            DisplayB2SText "   @?  60  #%   " & "                "
	end if

	If matchplay = 108 then

			hdisplay2.text =  "   :?  80  #$   "', seNone 
			display2.text =  "   :?  80  #$   "', seNone 
            DisplayB2SText "   :?  80  #$   " & "                "
			matchplayer.interval = 50

	end if

	If matchplay = 109 then

			hdisplay2.text = "   @?  50  #%   "', seNone 
			display2.text = "   @?  50  #%   "', seNone 
            DisplayB2SText "   @?  50  #%   " & "                "
	end if

	If matchplay = 110 then

			hdisplay2.text =  "   :?  70  #$   "', seNone 
			display2.text =  "   :?  70  #$   "', seNone
            DisplayB2SText "   :?  70  #$   " & "                " 

	end if

	If matchplay = 111 then

			hdisplay2.text =  "   @?  10  #%   "', seNone 
			display2.text =  "   @?  10  #%   "', seNone 
            DisplayB2SText "   :?  10  #$   " & "                " 

	end if

	If matchplay = 112 then

			hdisplay2.text =  "   :?  30  #$   "', seNone 
			display2.text =  "   :?  30  #$   "', seNone 
            DisplayB2SText "   :?  30  #$   " & "                " 
			matchplayer.interval = 70

	end if

	If matchplay = 113 then

			hdisplay2.text = "   @?  90  #%   "', seNone 
			display2.text =  "   @?  90  #%   "', seNone 
            DisplayB2SText "   :?  90  #$   " & "                " 

	end if

	If matchplay = 114 then

			hdisplay2.text = "   :?  00  #$   "', seNone
			display2.text =  "   :?  00  #$   "', seNone
            DisplayB2SText "   :?  00  #$   " & "                " 

	end if

	If matchplay = 115 then

			hdisplay2.text =  "   @?  20  #%   "', seNone
			display2.text =  "   @?  20  #%   "', seNone 
            DisplayB2SText "   :?  20  #$   " & "                " 

	end if

	If matchplay = 116 then

			hdisplay2.text =  "   :?  40  #$   "', seNone
			display2.text =  "   @?  40  #%   "', seNone
            DisplayB2SText "   :?  40  #$   " & "                " 
			matchplayer.interval = 90

	end if

	If matchplay = 117 then

			hdisplay2.text =  "   @?  60  #%   "', seNone 
			display2.text =  "   @?  60  #%   "', seNone 
            DisplayB2SText "   :?  60  #$   " & "                " 

	end if

	If matchplay = 118 then

			hdisplay2.text =  "   :?  80  #$   "', seNone 
			display2.text =  "   :?  80  #$   "', seNone 
            DisplayB2SText "   :?  80  #$   " & "                " 

	end if

	If matchplay = 119 then

			hdisplay2.text =  "   @?  50  #%   "', seNone 
			display2.text =  "   @?  50  #%   "', seNone 
            DisplayB2SText "   :?  50  #$   " & "                 "

	end if

	If matchplay = 120 then

			hdisplay2.text = "   :?  70  #$   "', seNone
			display2.text =  "   :?  70  #$   "', seNone
            DisplayB2SText "   :?  70  #$   " & "                " 
			matchplayer.interval = 110

	end if

	If matchplay = 121 then

			hdisplay2.text =  "   @?  10  #%   "', seNone 
			display2.text =  "   @?  10  #%   "', seNone
            DisplayB2SText "   :?  10  #$   " & "                " 

	end if

	If matchplay = 122 then

			hdisplay2.text =  "   :?  30  #$   "', seNone 
			display2.text =  "   :?  30  #$   "', seNone 
            DisplayB2SText "   :?  30  #$   " & "                " 

	end if

	If matchplay = 123 then

			hdisplay2.text = "   @?  90  #%   "', seNone 
			display2.text =  "   @?  90  #%   "', seNone 
            DisplayB2SText "   :?  90  #$   " & "                " 

	end if

	If matchplay = 124 then

			hdisplay2.text =  "   :?  00  #$   "', seNone
			display2.text =  "   :?  00  #$   "', seNone
            DisplayB2SText "   :?  00  #$   " & "                " 
			matchplayer.interval = 130

	end if

	If matchplay = 125 then

			hdisplay2.text =  "   @?  20  #%   "', seNone 
			display2.text =  "   @?  20  #%   "', seNone 
            DisplayB2SText "   :?  20  #$   " & "                " 

	end if

	If matchplay = 126 then

			hdisplay2.text =  "   :?  40  #$   "', seNone 
			display2.text =  "   :?  40  #$   "', seNone 
            DisplayB2SText "   :?  40  #$   " & "                 "

	end if

	If matchplay = 127 then

			hdisplay2.text =  "   @?  60  #%   "', seNone 
			display2.text =  "   @?  60  #%   "', seNone 
            DisplayB2SText "   :?  60  #$   " & "                " 

	end if

	If matchplay = 128 then

			hdisplay2.text =  "   :?  80  #$   "', seNone 
			display2.text =  "   :?  80  #$   "', seNone 
            DisplayB2SText "   :?  80  #$   " & "                " 
			matchplayer.interval = 150

	end if

	If matchplay = 129 then

			hdisplay2.text =  "   @?  50  #%   "', seNone 
			display2.text =  "   @?  50  #%   "', seNone 
            DisplayB2SText "   :?  50  #$   " & "                " 

	end if

	If matchplay = 130 then

			hdisplay2.text = "   :?  70  #$   "', seNone
			display2.text =  "   :?  70  #$   "', seNone 
            DisplayB2SText "   :?  70  #$   " & "                "  

	end if

	If matchplay = 131 then

			hdisplay2.text =  "   @?  10  #%   "', seNone
			display2.text =  "   @?  10  #%   "', seNone 
            DisplayB2SText "   :?  10  #$   " & "                " 

	end if

	If matchplay = 132 then

			hdisplay2.text =  "   :?  30  #$   "', seNone 
			display2.text =  "   :?  30  #$   "', seNone 
            DisplayB2SText "   :?  30  #$   " & "                " 
			matchplayer.interval = 170

	end if

	If matchplay = 133 then

			hdisplay2.text =  "   @?  90  #%   "', seNone
			display2.text =  "   @?  90  #%   "', seNone 
            DisplayB2SText "   :?  90  #$   " & "                "  

	end if

	If matchplay = 134 then

			hdisplay2.text =  "   :?  00  #$   "', seNone
			display2.text = "   :?  00  #$   "', seNone
            DisplayB2SText "   :?  00  #$   " & "                " 

	end if

	If matchplay = 135 then

			hdisplay2.text = "   @?  20  #%   "', seNone 
			display2.text = "   @?  20  #%   "', seNone
            DisplayB2SText "   :?  20  #$   " & "                " 

	end if

	If matchplay = 136 then

			hdisplay2.text = "   :?  40  #$   "', seNone
			display2.text = "   :?  40  #$   "', seNone
            DisplayB2SText "   :?  40  #$   " & "                " 
			matchplayer.interval = 190

	end if

	If matchplay = 137 then

			hdisplay2.text = "   @?  60  #%   "', seNone
			display2.text = "   @?  60  #%   "', seNone  
            DisplayB2SText "   :?  60  #$   " & "                " 

	end if

	If matchplay = 138 then

			hdisplay2.text = "   :?  80  #$   "', seNone
			display2.text = "   :?  80  #$   "', seNone 
            DisplayB2SText "   :?  80  #$   " & "                " 

	end if

	If matchplay = 139 then

			hdisplay2.text = "   @?  50  #%   "', seNone 
			display2.text = "   @?  50  #%   "', seNone 
            DisplayB2SText "   :?  50  #$   " & "                " 

	end if

	If matchplay = 140 then

			hdisplay2.text = "   :?  70  #$   "', seNone 
			display2.text = "   :?  70  #$   "', seNone 
            DisplayB2SText "   :?  70  #$   " & "                " 
			matchplayer.interval = 210

	end if

	If matchplay = 141 then

			hdisplay2.text = "   @?  10  #%   "', seNone 
			display2.text = "   @?  10  #%   "', seNone 
            DisplayB2SText "   :?  10  #$   " & "                " 

	end if

	If matchplay = 142 then

			hdisplay2.text = "   :?  30  #$   "', seNone
			display2.text = "   :?  30  #$   "', seNone
            DisplayB2SText "   :?  30  #$   " & "                "  

	end if

	If matchplay = 143 then

			hdisplay2.text = "   @?  90  #%   "', seNone 
			display2.text = "   @?  90  #%   "', seNone
            DisplayB2SText "   :?  90  #$   " & "                "  

	end if

	If matchplay = 144 then

			hdisplay2.text = "   :?  00  #$   "', seNone
			display2.text = "   :?  00  #$   "', seNone
            DisplayB2SText "   :?  00  #$   " & "                " 
			matchplayer.interval = 230

	end if

	If matchplay = 145 then

			hdisplay2.text = "   @?  20  #%   "', seNone 
			display2.text = "   @?  20  #%   "', seNone
            DisplayB2SText "   :?  20  #$   " & "                "  

	end if

	If matchplay = 146 then

			hdisplay2.text = "   :?  40  #$   "', seNone
			display2.text = "   :?  40  #$   "', seNone 
            DisplayB2SText "   :?  40  #$   " & "                " 

	end if

	If matchplay = 147 then

			hdisplay2.text = "   @?  60  #%   "', seNone 
			display2.text = "   @?  60  #%   "', seNone 
            DisplayB2SText "   :?  60  #$   " & "                " 

	end if

	If matchplay = 148 then

			hdisplay2.text = "   :?  80  #$   "', seNone
			display2.text = "   :?  80  #$   "', seNone 
            DisplayB2SText "   :?  80  #$   " & "                "  
			matchplayer.interval = 250

	end if

	If matchplay = 149 then

			hdisplay2.text = "   @?  50  #%   "', seNone 
			display2.text = "   @?  50  #%   "', seNone 
            DisplayB2SText "   :?  50  #$   " & "                " 

	end if

	If matchplay = 150 then

			hdisplay2.text = "   :?  70  #$   "', seNone 
			display2.text = "   :?  70  #$   "', seNone
            DisplayB2SText "   :?  70  #$   " & "                " 

	end if

	If matchplay = 151 then

			hdisplay2.text = "   @?  10  #%   "', seNone
			display2.text = "   @?  10  #%   "', seNone
            DisplayB2SText "   :?  10  #$   " & "                " 
			calculatematch()

	end if

	If matchplay = 152 then

			if actualmatch = 10 then

			hdisplay2.text = "   @?  00  #%   "', seNone
			display2.text = "   @?  00  #%   "', seNone
            DisplayB2SText "   :?  00  #$   " & "                "

				if match = 0 then

				   vpmtimer.addtimer 1000, "winmatch() '"

				end if

			else
			hdisplay2.text = "   @?  " & actualmatch*10  & "  #%   "', seNone 
			display2.text = "   @?  " & actualmatch*10  & "  #%   "', seNone 
            DisplayB2SText " MATCH " & displaymatch & "       "&"        ->"& actualmatch*10 & "<-  "               
            DMDUpdate.Enabled = 0
				if actualmatch = match then

				   vpmtimer.addtimer 1000, "winmatch() '"

				end if

			end if

	end if

	If matchplay = 154 then

			matchplayer.enabled = false
			matchplay = 0

	end if
        StopAllSounds
end sub



sub calculatematch()

	actualmatch = INT(RND(1)*10)+1

end sub

sub winmatch()
	playsound "fx_knocker"
	playsound "jycwinmatch"', false, 0.9
	playsound "spchmeow"', false, 0.8, 2100

	if credits < 9 then

		Credits = Credits + 1

	end if

	if actualmatch = 10 then

		hdisplay2.text = "   @?  00  #%   "', seblink, 2000
		display2.text = "   @?  00  #%   "', seblink, 2000
         DisplayB2SText "     00     " & "           "
	else
	    
		hdisplay2.text = "   @?  " & actualmatch*10  & "  #%   "', seblink, 2000
		display2.text = "   @?  " & actualmatch*10  & "  #%   "', seblink, 2000
        DisplayB2SText "     ->"& actualmatch*10 & "<-                      "
        DisplayB2SText " MATCH " & displaymatch & "       "&"        ->"& actualmatch*10 & "<-  "
	end if


end sub



dim gameovermusic

sub matchtimer_Timer()

	matchon = false
	matchtimer.enabled = false
    startattractmode()
    resettargets
   ' GameOverAnimTimer.Interval = 1000	
    GameOverAnimTimer.Enabled = True
	

	if highscoreOn = False then

		gameovermusic = gameovermusic + 1

		if gameovermusic = 1 then

			playsound "jycgameover"', false, 0.8

		end if

		if gameovermusic = 2 then

			playsound "jycgameover2"', false, 0.8
			gameovermusic = gameovermusic - gameovermusic

		end if

	else

	'song = 10
	'playsong2()
    PlaySong  "mu_jychighscore"
	end if

end sub

sub gameover()
 If B2SOn Then
    Controller.B2SSetData 1, 0
    Controller.B2SSetData 2, 0
    Controller.B2SSetData 3, 0
    Controller.B2SSetData 4, 0
    Controller.B2SSetData 5, 0
    Controller.B2SSetData 6, 0
    Controller.B2SSetData 7, 0
    Controller.B2SSetData 8, 0
  End If    

	endsuperjets()

	shooterspeechtimer.enabled = false
	statusspeechtimer.enabled = false
	
	if ballinleftlock = true then

	leftlocksolenoidpulse
	ballslocked = ballslocked - 1

	end if

	if ballinrightlock = true then

	rightlock.destroyball
	ballsinscoop = ballsinscoop + 1
	scooptimer.enabled = true
	ballslocked = ballslocked - 1

	end if
    StopAllSounds
end sub

dim attractmode
dim attractphase


sub showcredits()

	message = 2
	attractmessagetimer.enabled = true

	'hdisplay1.slowblinkspeed = 150
	'hdisplay2.slowblinkspeed = 150

	'hdisplay1.flushqueue
	'hdisplay2.flushqueue

	hdisplay1.text = "   CREDITS " & (Credits) & "    "
	hdisplay2.text = "  PRESS START   " 

'DMDUpdate.Interval = 2000
'DMDUpdate.enabled = 1


	'hdisplay2.QueueText "  PRESS START   ", seBlinkMask, 3000

	'display1.slowblinkspeed = 150
	'display2.slowblinkspeed = 150

	'display1.flushqueue
	'display2.flushqueue
'DMDUpdate.Interval = 2000
'DMDUpdate.enabled = 1


	display1.text = "   CREDITS " & (Credits) & "    "
	display2.text = "  PRESS START   "

  '  DisplayB2SText "    CREDITS  " & (Credits) & "                 "
    DisplayB2SText2 "    CREDITS     " & (Credits) & "   PRESS START  "

	'display2.QueueText "  PRESS START   ", seBlinkMask, 3000

	attractmessagetimer.interval = 3000

end sub

dim message

sub attractmessage()
on error Resume Next
	attractmessagetimer.interval = 3000

	hdisplay1.slowblinkspeed = 30
	hdisplay2.slowblinkspeed = 30

	hdisplay1.SetCharShape 35, &H0080 or &H1000 or &H2000 or &H0004 or &H0100 or &H0200 or &H0008 or &H0010 ' # cat head facing left
	hdisplay1.SetCharShape 36, &H0100 or &H8000 or &H0010 or &H0020 or &H0400 ' $ cat tail facing left straight
	hdisplay1.SetCharShape 37, &H0100 or &H8000 or &H0010 or &H0020 or &H2000 ' % cat tail facing left diagnol

	hdisplay2.SetCharShape 35, &H0080 or &H1000 or &H2000 or &H0004 or &H0100 or &H0200 or &H0008 or &H0010 ' #cat head facing left
	hdisplay2.SetCharShape 36, &H0100 or &H8000 or &H0010 or &H0020 or &H0400 ' $ cat tail facing left straight
	hdisplay2.SetCharShape 37, &H0100 or &H8000 or &H0010 or &H0020 or &H2000 ' % cat tail facing left diagnol

	hdisplay1.SetCharShape 64, &H0200 or &H4000 or &H0010 or &H0020 or &H1000 ' @ cat tail facing right diagnol
	hdisplay1.SetCharShape 63, &H0080 or &H1000 or &H2000 or &H0004 or &H0100 or &H0200 or &H0040 or &H0010 ' ?

	hdisplay2.SetCharShape 64, &H0200 or &H4000 or &H0010 or &H0020 or &H1000 ' @ cat tail facing right diagnol
	hdisplay2.SetCharShape 58, &H0200 or &H4000 or &H0010 or &H0020 or &H0400 ' : cat tail facing right straight 
	hdisplay2.SetCharShape 63, &H0080 or &H1000 or &H2000 or &H0004 or &H0100 or &H0200 or &H0040 or &H0010 ' ? cat head facing right
	
	hdisplay1.text = "   GAME  OVER   "
	hdisplay2.text = "                "

	display1.slowblinkspeed = 30
	display2.slowblinkspeed = 30

	display1.SetCharShape 35, &H0080 or &H1000 or &H2000 or &H0004 or &H0100 or &H0200 or &H0008 or &H0010 ' # cat head facing left
	display1.SetCharShape 36, &H0100 or &H8000 or &H0010 or &H0020 or &H0400 ' $ cat tail facing left straight
	display1.SetCharShape 37, &H0100 or &H8000 or &H0010 or &H0020 or &H2000 ' % cat tail facing left diagnol

	display2.SetCharShape 35, &H0080 or &H1000 or &H2000 or &H0004 or &H0100 or &H0200 or &H0008 or &H0010 ' #cat head facing left
	display2.SetCharShape 36, &H0100 or &H8000 or &H0010 or &H0020 or &H0400 ' $ cat tail facing left straight
	display2.SetCharShape 37, &H0100 or &H8000 or &H0010 or &H0020 or &H2000 ' % cat tail facing left diagnol

	display1.SetCharShape 64, &H0200 or &H4000 or &H0010 or &H0020 or &H1000 ' @ cat tail facing right diagnol
	display1.SetCharShape 63, &H0080 or &H1000 or &H2000 or &H0004 or &H0100 or &H0200 or &H0040 or &H0010 ' ?

	display2.SetCharShape 64, &H0200 or &H4000 or &H0010 or &H0020 or &H1000 ' @ cat tail facing right diagnol
	display2.SetCharShape 58, &H0200 or &H4000 or &H0010 or &H0020 or &H0400 ' : cat tail facing right straight 
	display2.SetCharShape 63, &H0080 or &H1000 or &H2000 or &H0004 or &H0100 or &H0200 or &H0040 or &H0010 ' ? cat head facing right
	
	display1.text = "   GAME  OVER   "
	display2.text = "                "

    DisplayB2SText2 "   GAME  OVER   " & "                "


    DMDUpdate.Interval = 3000
    DMDUpdate.enabled = 1

	attractmessagetimer.enabled = true

	'# - cat head facing left
	'$ - cat tail facing left straight
	'% - cat tail facing left diagnol

	'@ - cat tail facing right diagnol
	': - cat tail facing right straight
	'? - cat head facing right

	'use "#%" to draw a cat facing left with diagnol tail
	'use "@?" to draw a cat facing right with diagnol tail

	'use "#$" to draw a cat facing left with a straight tail
	'use ":?" to draw a cat facing right with a straight tail

end sub

sub attractmessagetimer_Timer()
    DMDUpdate.enabled = 0
	message = message + 1
    Select Case message
    Case 1:


	hdisplay1.text = "   GAME  OVER   "
	hdisplay2.text = "                "


	display1.text = "   GAME  OVER   "
	display2.text = "                "

    DisplayB2SText2 "   GAME  OVER   " & "               "


	
	showscore()


    Case 2:


'	hdisplay1.slowblinkspeed = 150
'	hdisplay2.slowblinkspeed = 150

'	display1.slowblinkspeed = 150
'	display2.slowblinkspeed = 150

		if Credits = 0 then

			hdisplay1.text = "   CREDITS " & (Credits) & "    "
			hdisplay2.text = "  INSERT COIN   "
			hdisplay2.text = "  INSERT COIN   "', seBlinkMask, 3000

          ' DisplayB2SText2 "     CREDITS   " & "   " & (Credits) & "    " 
           'DisplayB2SText "  INSERT COIN   " & "               "


			display1.text = "   CREDITS " & (Credits) & "    "
			display2.text = "  INSERT COIN   "
			display2.text = "  INSERT COIN   "', seBlinkMask, 3000

            DisplayB2SText2 "   CREDITS " &credits &"      INSERT COIN "

		else

			hdisplay1.text = "   CREDITS " & (Credits) & "    "
			hdisplay2.text = "  PRESS START   "
			hdisplay2.text = "  PRESS START   "', seBlinkMask, 3000

         '  DisplayB2SText "    CREDITS  " & (Credits) & "                 "


          ' DisplayB2SText "  PRESS START   "& "               "

			display1.text = "   CREDITS " & (Credits) & "    "
			display2.text = "  PRESS START   "
			display2.text = "  PRESS START   "', seBlinkMask, 3000

           DisplayB2SText2 "     CREDITS" & "  "&(Credits) &"  " & "   PRESS START  "

		end if


    Case 3:

	
	showscore()


    Case 4:


	attractmessagetimer.interval = 2000

	'hdisplay1.slowblinkspeed = 30
	'hdisplay2.slowblinkspeed = 30

	'hdisplay1.flushqueue
	'hdisplay2.flushqueue

	hdisplay1.text = "  * TOP ASH WILLIAMS *  "', seScrollRightOver
	hdisplay2.text = "                "', seScrollRightOver

    DisplayB2SText "  * TOP ASH WILLIAMS *  " & "                "
 '   DisplayB2SText "                "

	'display1.slowblinkspeed = 30
	'display2.slowblinkspeed = 30

	'display1.flushqueue
	'display2.flushqueue

	display1.text = "  * TOP ASH WILLIAMS *  "', seScrollRightOver
	display2.text = "                "', 'seScrollRightOver

    DisplayB2SText2 "  * TOP ASH WILLIAMS *  " & "                "
   ' DisplayB2SText "                " & "                "


    Case 5:


	attractmessagetimer.interval = 3000

	'hdisplay1.flushqueue
	'hdisplay2.flushqueue




	hdisplay1.text = " 1> " & HighScoreName(0) & "  " & HighScore(0)', seScrollRightOver
	hdisplay2.text = " 2> " & HighScoreName(1) & "  " & HighScore(1)', seScrollRightOver, , 20

    DisplayB2SText2 "    HIGHSCORES   "& "1> " & HighScoreName(0) & ":" & HighScore(0)' & " 

    Case 6:               

    DisplayB2SText2 "    HIGHSCORES   "& "2> " & HighScoreName(1) & ":" & HighScore(1)' & "                "

	display1.text = " 1> " & HighScoreName(0) & "  " & HighScore(0)', seScrollRightOver
	display2.text = " 2> " & HighScoreName(1) & "  " & HighScore(1)', seScrollRightOver, , 20


    Case 7:


	hdisplay1.text = " 3> " & HighScoreName(2) & "  " & HighScore(2)', seScrollRightOver
	hdisplay2.text = " 4> " & HighScoreName(3) & "  " & HighScore(3)', seScrollRightOver, , 20

    DisplayB2SText2 "    HIGHSCORES   "& "3> " & HighScoreName(2) & ":" & HighScore(2)' & "                "

    Case 8:

    DisplayB2SText2 "    HIGHSCORES   "& "4> " & HighScoreName(3) & ":" & HighScore(3)' & "                "

	display1.text = " 3> " & HighScoreName(2) & "  " & HighScore(2)', seScrollRightOver
	display2.text = " 4> " & HighScoreName(3) & "  " & HighScore(3)', seScrollRightOver, , 20


   Case 9:


	attractmessagetimer.interval = 3000

	hdisplay1.text = "THE BOOK MASTER"& " 1> " & SpecialHighScoreName(0) & " :" & SpecialHighScore(0)

    DisplayB2SText2 "THE BOOK MASTER"& " 1> " & SpecialHighScoreName(0) & ": " & SpecialHighScore(0)               



    Case 10:


	attractmessagetimer.interval = 3000

	hdisplay1.text = "THE BOOK MASTER"& " 2> " & SpecialHighScoreName(1) & " :" & SpecialHighScore(1)

    DisplayB2SText2 "THE BOOK MASTER"& " 2> " & SpecialHighScoreName(1) & ": " & SpecialHighScore(1)



    Case 11:


	attractmessagetimer.interval = 3000

	hdisplay1.text = "THE BOOK MASTER"& " 3> " & SpecialHighScoreName(2) & ": " & SpecialHighScore(2)

    DisplayB2SText2 "THE BOOK MASTER"& " 3> " & SpecialHighScoreName(2) & ": " & SpecialHighScore(2)


    Case 12:


	attractmessagetimer.interval = 3000

	hdisplay1.text = "THE BOOK MASTER"& " 4> " & SpecialHighScoreName(3) & ": " & SpecialHighScore(3)

    DisplayB2SText2 "THE BOOK MASTER"& " 4> " & SpecialHighScoreName(3) & ": " & SpecialHighScore(3)


    Case 13:

	
	showscore()

    Case 14:


	hdisplay1.text = "HAIL TO THE KING"', seScrollRightOver
	hdisplay2.text = "    BABY     "', seScrollLeftOver, , 20
   hdisplay2.text = "    BABY     "', seBlinkMask, 3000

    DisplayB2SText2 "HAIL TO THE KING" & "    BABY     "


	display1.text = "HAIL TO THE KING"', seScrollRightOver
	display2.text = "    BABY     "', seScrollLeftOver, , 20
   display2.text = "    BABY     "', seBlinkMask, 3000

  '  DisplayB2SText "HAIL TO THE KING" & "    BABY     "


    Case 15:


	'hdisplay1.flushqueue
	'hdisplay2.flushqueue

	hdisplay1.text = "  LET'S NOT BE  "', seScrollRightOver
	hdisplay2.text = "     QUIET      "', seScrollLeftOver, , 20
   hdisplay2.text = "     QUIET      "', seBlinkMask, 3000

 '   DisplayB2SText "  LET'S NOT BE  " & "     QUIET      "


	'display1.flushqueue
	'display2.flushqueue

	display1.text = "  TRAPPED IN TIME  "', seScrollRightOver
	display2.text = "     GROOVY      "', seScrollLeftOver, , 20
   display2.text = "     GROOVY      "', seBlinkMask, 3000

    DisplayB2SText2 "   TRAPPED IN TIME  " & "     GROOVY      "


    Case 16:


	'hdisplay1.flushqueue
	'hdisplay2.flushqueue

	hdisplay1.text = "GIMME SOME SUGAR"', seScrollRightOver
	hdisplay2.text = "     BABY     "', seScrollLeftOver, , 20
   hdisplay2.text = "     BABY     "', seBlinkMask, 3000

   ' DisplayB2SText "GIMME SOME SUGAR" & "     BABY     "

	'display1.flushqueue
	'display2.flushqueue

	display1.text = "GIMME SOME SUGAR"', seScrollRightOver
	display2.text = "     BABY     "', seScrollLeftOver, , 20
   display2.text = "     BABY     "', seBlinkMask, 3000

    DisplayB2SText2 "GIMME SOME SUGAR" & "     BABY     "


    Case 17:


	'hdisplay1.flushqueue
	'hdisplay2.flushqueue

	hdisplay1.text = "  AND START A   "', seScrollRightOver
	hdisplay2.text = "      MISSION      "', seScrollLeftOver, , 20
   hdisplay2.text = "      MISSION      "', seBlinkMask, 3000

 '   DisplayB2SText "  AND START A   " & "      MISSION      "

	'display1.flushqueue
	'display2.flushqueue

	display1.text = "  AND START A   "', seScrollRightOver
	display2.text = "      MISSION      "', seScrollLeftOver, , 20
   display2.text = "      MISSION      "', seBlinkMask, 3000

    DisplayB2SText2 "  AND START A   " & "      MISSION      "


    Case 18:


'	attractmessagetimer.interval = 5000

	'hdisplay1.flushqueue
	'hdisplay2.flushqueue

	hdisplay1.text = "    EVIL DEAD ARMY OF    "', seWipeBarUp
	hdisplay2.text = " @?   DARKNESS   #% "', seWipeBarUp, 400
	hdisplay2.text = " :?   DARKNESS   #$ "', seNone, 400, 0, False
	hdisplay2.text = " @?   DARKNESS   #% "', seNone, 400, 0, False
	hdisplay2.text = " :?   DARKNESS   #$ "', seNone, 400, 0, False
	hdisplay2.text = " @?   DARKNESS   #% "', seNone, 400, 0, False
	hdisplay2.text = " :?   DARKNESS   #$ "', seNone, 400, 0, False
	hdisplay2.text = " @?   DARKNESS   #% "', seNone, 400, 0, False
	hdisplay2.text = " :?   DARKNESS   #$ "', seNone, 400, 0, False
	hdisplay2.text = " @?   DARKNESS   #% "', seNone, 400, 0, False
	hdisplay2.text = " :?   DARKNESS   #$ "', seNone, 400, 0, False
	hdisplay2.text = " @?   DARKNESS   #% "', seNone, 400, 0, False


    DisplayB2SText "    EVIL DEAD    " & " @?   ARMY OF DARKNESS   #% "
    'DMDUpdate.Interval = 200: DMDUpdate.enabled = 1
    DisplayB2SText "    EVIL DEAD    " & " :?   ARMY OF DARKNESS   #$ "
    'DMDUpdate.Interval = 200: DMDUpdate.enabled = 1
    DisplayB2SText "    EVIL DEAD    " & " @?   ARMY OF DARKNESS   #% "
    'DMDUpdate.Interval = 200: DMDUpdate.enabled = 1
    DisplayB2SText "    EVIL DEAD    " & " :?   ARMY OF DARKNESS   #$ "
    'DMDUpdate.Interval = 200: DMDUpdate.enabled = 1
    DisplayB2SText "    EVIL DEAD    " & " @?   ARMY OF DARKNESS   #% "
    'DMDUpdate.Interval = 200: DMDUpdate.enabled = 1
    DisplayB2SText "    EVIL DEAD    " & " :?   ARMY OF DARKNESS   #$ "
    'DMDUpdate.Interval = 200: DMDUpdate.enabled = 1
    DisplayB2SText "    EVIL DEAD    " & " @?   ARMY OF DARKNESS   #% "
    'DMDUpdate.Interval = 200: DMDUpdate.enabled = 1
    DisplayB2SText "    EVIL DEAD    " & " :?   ARMY OF DARKNESS   #$ "
    'DMDUpdate.Interval = 200: DMDUpdate.enabled = 1
    DisplayB2SText "    EVIL DEAD    " & " @?   ARMY OF DARKNESS   #% "
    'DMDUpdate.Interval = 200: DMDUpdate.enabled = 1
    DisplayB2SText "    EVIL DEAD    " & " :?   ARMY OF DARKNESS   #$ "
   ' DMDUpdate.Interval = 200: DMDUpdate.enabled = 1
    DisplayB2SText "    EVIL DEAD    " & " @?   ARMY OF DARKNESS   #% "
    'DMDUpdate.Interval = 200: DMDUpdate.enabled = 1

	'display1.flushqueue
	'display2.flushqueue

	display1.text = "    EVIL DEAD    "', seWipeBarUp
	display2.text = " @?   ARMY OF DARKNESS   #% "', seWipeBarUp, 400
	display2.text = " :?   ARMY OF DARKNESS   #$ "', seNone, 400, 0, False
	display2.text = " @?   ARMY OF DARKNESS   #% "', seNone, 400, 0, False
	display2.text = " :?   ARMY OF DARKNESS   #$ "', seNone, 400, 0, False
	display2.text = " @?   ARMY OF DARKNESS   #% "', seNone, 400, 0, False
	display2.text = " :?   ARMY OF DARKNESS   #$ "', seNone, 400, 0, False
	display2.text = " @?   ARMY OF DARKNESS   #% "', seNone, 400, 0, False
	display2.text = " :?   ARMY OF DARKNESS   #$ "', seNone, 400, 0, False
	display2.text = " @?   ARMY OF DARKNESS   #% "', seNone, 400, 0, False
	display2.text = " :?   ARMY OF DARKNESS   #$ "', seNone, 400, 0, False
	display2.text = " @?   ARMY OF DARKNESS   #% "',' seNone, 400, 0, False


    DisplayB2SText "    EVIL DEAD    " & " @?   ARMY OF DARKNESS   #% "
    DisplayB2SText "    EVIL DEAD    " & " :?   ARMY OF DARKNESS   #$ "
    DisplayB2SText "    EVIL DEAD    " & " @?   ARMY OF DARKNESS   #% "
    DisplayB2SText "    EVIL DEAD    " & " :?   ARMY OF DARKNESS   #$ "
    DisplayB2SText "    EVIL DEAD    " & " @?   ARMY OF DARKNESS   #% "
    DisplayB2SText "    EVIL DEAD    " & " :?   ARMY OF DARKNESS   #$ "
    DisplayB2SText "    EVIL DEAD    " & " @?   ARMY OF DARKNESS   #% "
    DisplayB2SText "    EVIL DEAD    " & " :?   ARMY OF DARKNESS   #$ "
    DisplayB2SText "    EVIL DEAD    " & " @?   ARMY OF DARKNESS   #% "
    DisplayB2SText "    EVIL DEAD    " & " :?   ARMY OF DARKNESS   #$ "
    DisplayB2SText2 "    EVIL DEAD    " & " @?   ARMY OF DARKNESS   #% "


	'# - cat head facing left
	'$ - cat tail facing left straight
	'% - cat tail facing left diagnol

	'@ - cat tail facing right diagnol
	': - cat tail facing right straight
	'? - cat head facing right

	'use "#%" to draw a cat facing left with diagnol tail
	'use "@?" to draw a cat facing right with diagnol tail

	'use "#$" to draw a cat facing left with a straight tail
	'use ":?" to draw a cat facing right with a straight tail


    Case 19:


	attractmessagetimer.interval = 3000
	
	showscore()

    Case 20:

	hdisplay1.text = "   CREATED BY   "', seScrollRightOver
	hdisplay2.text = " IVANTBA "', seScrollLeftOver, , 20
   hdisplay2.text = " IVANTBA "', seBlinkMask, 3000

  '  DisplayB2SText "   CREATED BY   " & " IVANTBA "


	display1.text = "   CREATED BY   "', seScrollRightOver
	display2.text = " IVANTBA "', seScrollLeftOver, , 20
   display2.text = " IVANTBA "', seBlinkMask, 3000

  '  DisplayB2SText "   CREATED BY   " & " IVANTBA "
    DisplayB2SText2 "   CREATED BY   " & " IVANTBA "

    Case 21:


	'hdisplay1.flushqueue
	'hdisplay2.flushqueue

	hdisplay1.text = "   GAME  OVER   "
	hdisplay2.text = "                "

    DisplayB2SText2 "   GAME  OVER   " & "                "
 '   DisplayB2SText "                " & "                "

	'display1.flushqueue
	'display2.flushqueue

	display1.text = "   GAME  OVER   "
	display2.text = "                "

  '  DisplayB2SText "   GAME  OVER   " & "                "
  '  DisplayB2SText "                " & "                "


    Case 22:


	'hdisplay1.slowblinkspeed = 30
	'hdisplay2.slowblinkspeed = 30

	hdisplay1.text = " WINNERS DON'T  "', senone
	hdisplay2.text = "   USE DRUGS    "', senone
   'hdisplay1.text = "         DON'T  "', seBlinkMask, 3000

 '   DisplayB2SText " WINNERS DON'T  " & "   USE DRUGS    "


	'display1.slowblinkspeed = 30
	'display2.slowblinkspeed = 30

	display1.text = " WINNERS DON'T  "', senone
	display2.text = "   USE DRUGS    "', senone
  ' display1.text = "         DON'T  "', seBlinkMask, 3000

    DisplayB2SText2 " WINNERS DON'T  " & "   USE DRUGS    "


    Case 23:


	showscore()


    Case 24:

	hdisplay1.text = "   REPLAY AT    "', seScrollRightOver
	hdisplay2.text = "    " & replayscore & "     "', seScrollLeftOver

  '  DisplayB2SText "   REPLAY AT    " & "        " & replayscore 


	display1.text = "   REPLAY AT    "', seScrollRightOver
	display2.text = "    " & replayscore & "     "', seScrollLeftOver
    DisplayB2SText2 "   REPLAY AT    " & "    " & replayscore 

     message = 0

	End Select


end sub

sub showscore()

			if Score(CurrentPlayer) = 0 then
				
				hdisplay1.text = "     OO         "
				display1.text = "     OO         "
                DisplayB2SText2 ">-*-*-*--*-*-*-<" & ">-*-*-*--*-*-*-<"

			end if
			
			if ((Score(CurrentPlayer) > 0) and (Score(CurrentPlayer) < 99)) then

					hdisplay1.text = "     " & Score(CurrentPlayer) 
					display1.text = "     " & Score(CurrentPlayer)
                    '    DisplayB2SText "     " & Score(CurrentPlayer)
                    DMDScore
			end if 

			if ((Score(CurrentPlayer) > 99) and (Score(CurrentPlayer)) < 999)  then

					hdisplay1.text = "    " & Score(CurrentPlayer) 
					display1.text = "    " & Score(CurrentPlayer)
                    DMDScore
			end if

			if ((Score(CurrentPlayer) > 999) and (Score(CurrentPlayer)) < 9999)  then

					hdisplay1.text = "   " & Score(CurrentPlayer) 
					display1.text = "   " & Score(CurrentPlayer)
                    DMDScore
			end if  

			if ((Score(CurrentPlayer) > 9999) and (Score(CurrentPlayer)) < 99999)  then

					hdisplay1.text = "  " & Score(CurrentPlayer) 
					display1.text = "  " & Score(CurrentPlayer)
                    DMDScore
			end if 

			if ((Score(CurrentPlayer) > 99999) and (Score(CurrentPlayer)) < 999999)  then

					hdisplay1.text = " " & Score(CurrentPlayer) 
					display1.text = " " & Score(CurrentPlayer) 
                    DMDScore
			end if 

			if (Score(CurrentPlayer) > 999999) then

					hdisplay1.text = Score(CurrentPlayer)
					display1.text = Score(CurrentPlayer) 
                    DMDScore
			end if

	hdisplay2.text = "                "
	display2.text = "                "

end sub

sub attract1()

	

	TurnGIon()

	jlight.State = BulbBlink', "1000", 150
	ulight.State = BulbBlink', "0100", 150
	nlight.State = BulbBlink', "0010", 150
	klight.State = BulbBlink', "0001", 150

	ylight.State = BulbBlink', "0001", 150
	alight.State = BulbBlink', "0010", 150
	rlight.State = BulbBlink', "0100", 150
	dlight.State = BulbBlink', "1000", 150

	kickbacklight.State =   BulbBlink', "100000000", 100

	clawlight1.State =      BulbBlink', "100001000", 100
	clawlight2.State =      BulbBlink', "010000100", 100
	wardlight.State =       BulbBlink', "001000010", 100
	axellight.State =       BulbBlink', "000100001", 100
	roylight.State =        BulbBlink', "100010000", 100
	jenkinslight.State =    BulbBlink', "010001000", 100
	scarlalight.State =     BulbBlink', "001000100", 100
	clawlight3.State =      BulbBlink', "000100010", 100
	clawlight4.State =      BulbBlink', "000010001", 100

	twoxlight.State =    BulbBlink', "100000", 125
	threexlight.State =  BulbBlink', "010001", 125
	fourxlight.State =   BulbBlink', "001010", 125
	fivexlight.State =   BulbBlink', "000100", 125

	shootagainlight.State =  2', "100100", 150

	diverterlight.State =   2', "1000", 150
	scarlashotlight.State = BulbBlink', "0100", 150
	lock2light.State =      BulbBlink', "0010", 150

	axelshotlight.State =       BulbBlink', "1000", 150
	quickmultiballlight.State = BulbBlink', "0100", 150
	jackpot2light.State =       BulbBlink', "0010", 150

	randomawardlight.State =  BulbBlink', "1000", 150
	extraballlight.State =    BulbBlink', "0100", 150
	lightjackpotlight.State = BulbBlink', "0010", 150

   jenkinsshotlight.State =  BulbBlink', "10", 200
	jackpot1light.State =     BulbBlink', "01", 200

   wardshotlight.State =  BulbBlink', "10", 200
	lock1light.State =     BulbBlink', "01", 200

   clanelight.State =  BulbBlink', "1000", 150
   alanelight.State =  BulbBlink', "0101", 150
   tlanelight.State =  BulbBlink', "0010", 150

	lightkickbacklight.State =  BulbBlink', "1000", 200
	royshotlight.State =        BulbBlink', "0010", 200

	value1.State = BulbBlink', "10000", 100
	value2.State = BulbBlink', "01000", 100
	value3.State = BulbBlink', "00100", 100
	value4.State = BulbBlink', "00010", 100
	value5.State = BulbBlink', "00001", 100


end sub

sub attract2()

	jlight.State = BulbBlink', "0001111", 150
	ulight.State = BulbBlink', "0011110", 150
	nlight.State = BulbBlink', "0111100", 150
	klight.State = BulbBlink', "1111000", 150

	ylight.State = BulbBlink', "1000111", 150
	alight.State = BulbBlink', "1100011", 150
	rlight.State = BulbBlink', "1110001", 150
	dlight.State = BulbBlink', "1111000", 150

	kickbacklight.State =   BulbBlink', "000010001", 100

	clawlight1.State =      BulbBlink', "000011111", 100
	clawlight2.State =      BulbBlink', "000111110", 100
	wardlight.State =       BulbBlink', "001111100", 100
	axellight.State =       BulbBlink', "011111000", 100
	roylight.State =        BulbBlink', "111110000", 100
	jenkinslight.State =    BulbBlink', "111100001", 100
	scarlalight.State =     BulbBlink', "111000011", 100
	clawlight3.State =      BulbBlink', "110000111", 100
	clawlight4.State =      BulbBlink', "100001111", 100

	twoxlight.State =    BulbBlink', "11110000", 125
	threexlight.State =  BulbBlink', "01111000", 125
	fourxlight.State =   BulbBlink', "00111100", 125
	fivexlight.State =   BulbBlink', "00011110", 125

	shootagainlight.State =  2', "100100", 150

	diverterlight.State =   2', "10011", 150
	scarlashotlight.State = BulbBlink', "11001", 150
	lock2light.State =      BulbBlink', "11100", 150

	axelshotlight.State =       BulbBlink', "10011", 150
	quickmultiballlight.State = BulbBlink', "11001", 150
	jackpot2light.State =       BulbBlink', "11100", 150

	randomawardlight.State =  BulbBlink', "10011", 150
	extraballlight.State =    BulbBlink', "11001", 150
	lightjackpotlight.State = BulbBlink', "11100", 150

   jenkinsshotlight.State =  BulbBlink', "10", 200
	jackpot1light.State =     BulbBlink', "01", 200

   wardshotlight.State =  BulbBlink', "10", 200
	lock1light.State =     BulbBlink', "01", 200

   clanelight.State =  BulbBlink', "0010", 150
   alanelight.State =  BulbBlink', "0101", 150
   tlanelight.State =  BulbBlink', "1000", 150

	lightkickbacklight.State =  BulbBlink', "1000", 200
	royshotlight.State =        BulbBlink', "0010", 200

	value1.State = BulbBlink', "111110000", 100
	value2.State = BulbBlink', "011111000", 100
	value3.State = BulbBlink', "001111100", 100
	value4.State = BulbBlink', "000111110", 100
	value5.State = BulbBlink', "000011111", 100

end sub

sub attracttimer_Timer()

	attractphase = attractphase + 1

	if attractphase = 1 then

	attract2()

	end if

	if attractphase = 2 then

	TurnGIoff()

	'attracttimer.enabled = false	
	MainSeq.updateinterval = 15
	MainSeq.Play SeqUpOn, 75, 3
	value1.state = bulboff
	value2.state = bulboff
	value3.state = bulboff
	value4.state = bulboff
	value5.state = bulboff

	end if

end sub

sub mainseq_empty()

	if attractmode = true then

	'attracttimer.enabled = true
	attractphase = attractphase - attractphase
	attract1()

	end if

end sub



' The tilt recovery timer waits for all the balls to drain before continuing on 
' as per normal
'
Sub TiltRecoveryTimer_Timer()
	' disable the timer
	TiltRecoveryTimer.Enabled	= FALSE
	' if all the balls have been drained then..
	If (BallsOnPlayfield = 0) or ((ballslocked = 1) and (ballsonplayfield = 1)) Then
		' do the normal end of ball thing (this dosn't give a bonus if the table is tilted)
		EndOfBall()
		ballindrain = true

		tiltkilltimer.enabled = false
		resetlights()

	Else
		' else retry (checks again in another second)
		TiltRecoveryTimer.Interval = 1000
		TiltRecoveryTimer.Enabled = TRUE
	End If
End Sub


' Set any lights for the Attract Mode.
'
Sub SetAllLightsForAttractMode()

End Sub


Dim song

sub playsong2()

	If song = 1 then
    PlaySong "mu_end"
    playsong  "mu_jycmainshooter"', True, 0.7
	End if
	If song = 2 then
    PlaySong "mu_end"
    playsong  "mu_jycmaintheme"', True, 0.7

	End if
	If song = 3 then
    PlaySong "mu_end"
    playsong  "mu_jyclocklitshooter"', True, 0.7

	End if
	If song = 4 then
    PlaySong "mu_end"
    playsong  "mu_jyclocklit"', True, 0.7

	End if
	If song = 5 then
    PlaySong "mu_end"
    playsong  "mu_jycmultiball"', True, 0.7

	End if
	If song = 6 then
    PlaySong "mu_end"
    playsong  "mu_jycrestartmultiball"', True, 0.7, 1500

	End if
	If song = 7 then
    PlaySong "mu_end"
    playsong  "mu_jycquickmultiball"', True, 0.7

	End if
	If song = 8 then
    PlaySong "mu_end"
    playsong  "mu_jycblackoutshooter"', True, 0.7

	End if
	If song = 9 then
    StopSound Song:Song = ""
    PlaySong "mu_end"
    playsong  "mu_jycblackoutmusic"', True, 0.9
	End if
	'If song = 10 then
    'PlaySong "mu_end"
    'PlaySong  "mu_jychighscore"', False, 0.8

	'End if
	'If song = 11 then
    'PlaySong "mu_end"
    'playsong  "mu_jychurryup"', True, 0.8, 500

	'End if
end sub 


Sub StopAllSounds
    song = 0
    PlaySong "mu_end"
    StopSound SongMS:SongMS = ""
    Stopsound "mu_jycmainshooter"
    Stopsound "mu_jycmaintheme"
    Stopsound "mu_jyclocklitshooter"
    Stopsound "mu_jyclocklit"
    Stopsound "mu_jycmultiball"
    Stopsound "mu_jycrestartmultiball"
    Stopsound "mu_jycquickmultiball"
    Stopsound "mu_jycblackoutshooter"
    Stopsound "mu_jycblackoutmusic"
    Stopsound "mu_jychighscore"
    Stopsound "mu_jychurryup"
    Stopsound "jycmultiballstart"    
End Sub

' *********************************************************************
' **                                                                 **
' **                   Drain / Plunger Functions                     **
' **                                                                 **
' *********************************************************************

' lost a ball ;-( check to see how many balls are on the playfield.
' if only one then decrement the remaining count and test for End of game
' if more than 1 ball (multi-ball) then kill of the ball but don't create
' a new one

'

dim balljustsaved

Sub Drain_Hit()

	Drain.DestroyBall

	BallsOnPlayfield = BallsOnPlayfield - 1

	ballsindrain = ballsindrain + 1

	PlaySound "fx_drain"
	DOF 123, DOFPulse

	If (bGameInPlay = TRUE) And (Tilted = FALSE) Then

		If blackout = false then

			If ((ballsave = TRUE) or (kickbacksave = true)) Then

				statusspeechtimer.enabled = false

				ballsaveoutlanesafety = false

				autolaunchball()
				endballsave()
				kickbacksave = false
				'hdisplay1.flushqueue()
				'hdisplay2.flushqueue()

				balljustsaved = true
				balljustsavedtimer.enabled = true
	
				hdisplay1.text = "   BALL SAVED   "', seScrollRightOver
				hdisplay2.text = "                "', seScrollRightOver

				'hdisplay1.slowblinkspeed = 30
				'hdisplay2.slowblinkspeed = 30
				hdisplay1.text = "   BALL SAVED   "', seBlink, 3000
				'hdisplay2.queuetext "                ", seBlink, 3000

				'display1.flushqueue()
				'display2.flushqueue()
	
				display1.text = "   BALL SAVED   "', seScrollRightOver
				display2.text = "                "', seScrollRightOver

				''display1.slowblinkspeed = 30
				''display2.slowblinkspeed = 30
				display1.text = "   BALL SAVED   "', seBlink, 3000
				display2.text = "                "', seBlink, 3000
                DisplayB2SText "   BALL SAVED   " & "                "
				Playsound "jycsfx42"', false, 0.7

					if locklit = true then

						Playsound "spchwhateverittakes"', false, 0.9, 500

					else

						Playsound "spchnotoveryet"', false, 0.9, 500

					end if

				fadedelay.interval = 500
				fadedelay.enabled = true

				if rightdiverteropen = true then

					rightdiverter.RotatetoStart
					rightdiverteropen = false
					rightdivertersafetytimer.enabled = true

				end if

			Else

				If ((BallsOnPlayfield = 1)  and (multiballon = True)) Then
                        StopAllSounds
						Endmultiball()
	
				End If

				If ((BallsOnPlayfield = 1)  and (quickmultiballon = True)) or ((BallsOnPlayfield = 2)  and (quickmultiballon = True) and (ballslocked = 1)) Then
                        StopAllSounds
						Endquickmultiball()

				End If

				If (BallsOnPlayfield = 0) or ((ballsonplayfield = 1) and (ballslocked = 1)) Then

					If blackoutlit = false then
                        StopAllSounds
						showinprogress = false
						showtimer.enabled = false
						'hdisplay1.flushqueue()
						'hdisplay2.flushqueue()
						'display1.flushqueue()
						'display2.flushqueue()
						addscore(0)
                        addclaw(0)
						EndOfBall()
						ballindrain = true

						if jackpotshowon = true then

						killjackpotshow()

						end if

						If musicstarted = true then

							musicstarted = false

							If locklit = false then

								if score(currentplayer) > 1000000 then
								Playsound "jycmainballlost"', False, 0.7
								else
								Playsound "jycmainballlost2"', False, 0.7								
								end if

							end if

							if ((locklit = true) and (multiballrestart = false)) then
								Playsound "jyclocklitballlost"', False, 0.7
							end if

							if ((locklit = true) and (multiballrestart = true)) then
								playsound "jycrestartmultiballballlost"', False, 0.7
							end if

						end if

					else

						StartBlackout()

						If musicstarted = true then

							musicstarted = false

							If locklit = false then
								if score(currentplayer) > 1000000 then
								playsound "jycmainballlost"', False, 0.7
								else
								playsound "jycmainballlost2"', False, 0.7								
								end if
							end if

							if ((locklit = true) and (multiballrestart = false)) then
								playsound "jyclocklitballlost"', False, 0.7
							end if
	
							if ((locklit = true) and (multiballrestart = true)) then
								playsound "jycrestartmultiballballlost"', False, 0.7
							end if

						end if
	
					end if

					If multiballrestart = true then
                        StopAllSounds
						endrestartmultiball()
					end if

				End If

			End If

		Else
            StopAllSounds
			Endblackoutdrain()

		end if

	End If

End Sub

sub balljustsavedtimer_Timer()

	balljustsaved = false
	balljustsavedtimer.enabled = false

end sub

dim ballsave
dim kickbacksave
dim autolaunch

sub startblackout()

	Blackout = true

	blackoutmain = false
	blackoutvturn = false
	blackoutjackpot = false

	blackoutdrain = false

	boshowtimer.enabled = true
	showtimer.enabled = false
	showinprogress = false

	leftdiverter.RotateToStart
	rightdiverter.RotateToStart

	noswitchhit = true
	resetdiverters()

	ballsearchtimer.enabled = false
	ballsearchon = false

	statusspeechtimer.enabled = false

	if statusreporton = true then

	endstatusreport()

	end if

end sub

dim boshow

sub boshowtimer_Timer()

	boshow = boshow + 1

	if boshow = 3 then

		blackoutseq.play Seqrandom, 10, , 4000
		playsound "jycsfx58"', false, 1.0

		'hdisplay1.flushqueue()
		'hdisplay2.flushqueue()

		'hdisplay1.slowblinkspeed = 30
		'hdisplay2.slowblinkspeed = 30

		hdisplay1.Text = "      POWER     "', seblink, 4000
		hdisplay2.Text = "     FAILURE    "', seblink, 4000


		'display1.flushqueue()
		'display2.flushqueue()

		'display1.slowblinkspeed = 30
		'display2.slowblinkspeed = 30

		display1.Text = "      POWER     "', seblink, 4000
		display2.Text = "     FAILURE    "', seblink, 4000		
        DisplayB2SText2 "      POWER     " & "     FAILURE    "
	end if

	if boshow = 11 then

		alllightsoff()

	end if

	if boshow = 13 then

		'hdisplay1.flushqueue()
		'hdisplay2.flushqueue()

		'hdisplay1.text = "                "
		'hdisplay2.text = "                "

		'display1.flushqueue()
		'display2.flushqueue()

		display1.text = "                "
		display2.text = "                "
        DisplayB2SText2 "      POWER     " & "     FAILURE    "
		playsound "spchturnedoutthelights"', false, 1.0

	end if

	if boshow = 23 then

		CreateNewBall()
		playsound "jycsfx10"', false, 0.8

		musicstarted = false
		playsound "jycblackoutshooter"', True, 0.7

		song = 9

	end if

	if boshow = 24 then

	boshowtimer.enabled = false
	boshow = boshow - boshow
	
	end if


end sub

dim eboshow
dim blackoutdrain

sub endblackoutdrain()

	ballindrain = true

	If noswitchhit = true then

		noswitchhit = false

	end if

	if blackoutjackpot = true then
        StopAllSounds
		'stopmusic 4
		playsound "jychurryuplost"', False, 0.7
		blackoutjackpottimer.enabled = false

		jackpot2light.state = bulboff       
		axelshotlight.state = bulboff
		quickmultiballlight.state = bulboff

		jackpot1light.state = bulboff
		jenkinsshotlight.state = bulboff
		jackpot2light.state = bulboff
		axelshotlight.state = bulboff
		quickmultiballlight.state = bulboff

		'hdisplay1.flushqueue()
		'hdisplay2.flushqueue()

		'hdisplay1.slowblinkspeed = 30
		'hdisplay2.slowblinkspeed = 30

		hdisplay1.Text = "   MISSED OUR   "', seblink, 2000
		hdisplay2.Text = "     CHANCE     "', seblink, 2000

		'display1.flushqueue()
		'display2.flushqueue()

		'display1.slowblinkspeed = 30
		'display2.slowblinkspeed = 30

		display1.Text = "   MISSED OUR   "', seblink, 2000
		display2.Text = "     CHANCE     "', seblink, 2000
        DisplayB2SText2 "   MISSED OUR   " & "     CHANCE     "

		hus = hus - hus
		hurryupshowtimer.enabled = false

		letters = 0
		nvR1 = 0

	else

		playsound "jycblackoutballlost"', False, 0.7

		letters = 4
		nvR1 = 4

	end if



	turnoffblackout()
	blackoutdrain = true
	endblackoutlightstimer.enabled = true
	resetdiverters()

end sub

sub endblackoutmiss()

	turnoffblackout()

	playsound "jychurryuplost"', False, 0.7
	endblackoutlightstimer.enabled = true

	letters = 0
	nvR1 = 0

	hus = hus - hus
	hurryupshowtimer.enabled = false

	'hdisplay1.flushqueue()
	''hdisplay2.flushqueue()

	'hdisplay1.slowblinkspeed = 30
	'hdisplay2.slowblinkspeed = 30

	hdisplay1.Text = "   MISSED OUR   "', seblink, 2000
	hdisplay2.Text = "     CHANCE     "', seblink, 2000

	'display1.flushqueue()
	'display2.flushqueue()

	'display1.slowblinkspeed = 30
	'display2.slowblinkspeed = 30

	display1.Text = "   MISSED OUR   "', seblink, 2000
	display2.Text = "     CHANCE     "', seblink, 2000
        DisplayB2SText2 "   MISSED OUR   " & "     CHANCE     "
	resetdiverters()

end sub

sub endblackoutwin()

	turnoffblackout()
	resetlights()
	resettargets()

	hus = hus - hus
	hurryupshowtimer.enabled = false

	letters = 0
	nvR1 = 0
	checkblackout()

	addscore(3000000)

	resetdiverters()

end sub

sub turnoffblackout()

	blackout = false
	blackoutlit = false
	blackoutmain = false
	blackoutvturn = false
	blackoutjackpot = false

end sub

sub endblackoutlightstimer_Timer()

	eboshow = eboshow + 1

	if eboshow = 3 then

	resetlights()
	resettargets()
	playsound "jycsfx11"', false, 1.0
	checkblackout()

	'hdisplay1.flushqueue()
	'hdisplay2.flushqueue()

	hdisplay1.Text = "     SYSTEM     "', seblink, 4000, true
	hdisplay2.Text = "     ONLINE     "', seblink, 4000, true

	'display1.flushqueue()
	'display2.flushqueue()

	display1.Text = "     SYSTEM     "', seblink, 4000, true
	display2.Text = "     ONLINE     "', seblink, 4000, true
        DisplayB2SText2 "     SYSTEM     " & "     ONLINE     "

	end if

	if eboshow = 5 then

	playsound "spchbacktothedrawingboard"', false, 0.8

	end if

	if eboshow = 7 then

		if blackoutdrain = true then

			'hdisplay1.flushqueue()
			'hdisplay2.flushqueue()

			hdisplay1.text = "                "
			hdisplay2.text = "                "

			'display1.flushqueue()
			'display2.flushqueue()

			display1.text = "                "
			display2.text = "                "
        DisplayB2SText2 "                " & "                "
			EndOfBall()

			showinprogress = false
            addclaw(0)
			addscore(0)

		else

		showinprogress = false
        addclaw(0)
		addscore(0)

			if ((ballsonplayfield > 0) and (ballslocked = 0)) or ((ballsonplayfield > 1) and (ballslocked = 1)) then

				if ballslocked < 2 then

					if quickmultiballon = false then

						if locklit = false then
                            StopAllSounds
							song = 2
							playsong2()
							musicstarted = true
						end if

						if locklit = true then
                            StopAllSounds
							song = 4
							playsong2()
							musicstarted = true
						end if

					else
                            StopAllSounds 
							song = 7
							playsong2()
							musicstarted = true			

					end if

				end if

			end if

		end if

	end if

	if eboshow = 8 then

		blackoutdrain = false
		endblackoutlightstimer.enabled = false
		eboshow = eboshow - eboshow

	end if

end sub

Sub PlungerLaneTrigger_Hit()

	bBallInPlungerLane = TRUE

	set LastSwitchHit = PlungerLaneTrigger

	if noswitchhit = false then

	PlungerIM.AutoFire
	end if

End Sub

Sub PlungerLaneTrigger_unhit()
	bBallInPlungerLane = FALSE
	DOF 205, DOFPulse
	DOF 131, DOFPulse
	DOF 125, DOFPulse
End Sub

Sub Trigger2_Hit()
    BackglassLightsTimer.Interval = 1000
    BackglassLightsTimer.Enabled = 1
End Sub

Dim BAnim
Sub BackglassLightsTimer_Timer
	BackglassLightsShotTimer.Enabled = 0
 If B2SOn Then
  If BAnim = False Then
    BackglassLightsTimer.Enabled = 0
   	Controller.B2SSetData 14, 1
   	Controller.B2SSetData 15, 1
   	Controller.B2SSetData 16, 1
   	Controller.B2SSetData 17, 1
   	Controller.B2SSetData 18, 1
	Controller.B2SSetData 19, 1
	Controller.B2SSetData 20, 1
	Controller.B2SSetData 21, 1
	Controller.B2SSetData 22, 1
	Controller.B2SSetData 23, 1 
   Else
    BackglassLightsTimer.Interval = 2000
    BackglassLightsTimer.Enabled = 1
   	Controller.B2SSetData 14, 1
    BAnim = False
  End If 
 End If     
End Sub


Sub BackglassLightsShotTimer_Timer
    startB2S (31)    
End Sub


' A Ball may of rolled into the Plunger Lane Kicker, if so then kick it 
' back out again
'
Sub PlungerKicker_Hit()
	PlungerKicker.kick 90, 8
End Sub

Sub PlungerKicker_UnHit
    BAnim = True
    BackglassLightsShotTimer.Enabled = 1
End Sub

' The Ball has rolled out of the Plunger Lane.  Check to see if a ball saver machanisim
' is needed and if so fire it up.
'
Sub PlungerLaneGate_Hit()
	' if there is a need for a ball saver, then start off a timer
	' only start if it is currently not running, else it will reset the time period
	If (constBallSaverTime <> 0) And (bBallSaverActive <> TRUE) Then
		' and only if the last trigger hit was the plunger wire. 
		' (ball in the shooters lane)
		If (LastSwitchHit.Name = "PlungerLaneTrigger") Then
			' set our game flag
			bBallSaverActive = TRUE
			' start the timer
			BallSaverTimer.Enabled = FALSE
			BallSaverTimer.Interval = constBallSaverTime
			BallSaverTimer.Enabled = TRUE
			' if you have a ball saver light you might want to turn it on at this 
			' point (or make it flash)
		End If
	End If
End Sub


' The ball saver timer has expired.  Turn it off and reset the game flag
'
Sub BallSaverTimer_Timer()
	' stop the timer from repeating
	BallSaverTimer.Enabled = FALSE
	' clear the flag
	bBallSaverActive = FALSE
	' if you have a ball saver light then turn it off at this point
End Sub



' *********************************************************************
' **                                                                 **
' **                   Supporting Score Functions                    **
' **                                                                 **
' *********************************************************************

' Add points to the score and update the score board

dim displayint
dim ball
dim balljustlocked
dim replayscore
dim replayscored
dim replayshowon

sub replayshow()

	playsound "jycspecial"', false, 0.9
	playsound "spchmeow"', false, 0.8, 4000

	'hdisplay1.flushqueue()
	'hdisplay2.flushqueue()

	'display1.flushqueue()
	'display2.flushqueue()

	showinprogress = true

	rds = 0

	replaydisplayshowtimer.enabled = true
	replayshowtimer.enabled = true

	twinklesides = false
	twinkle = 0
	twinkletimer.enabled = true

end sub

sub replayshowtimer_Timer()

	replayshowtimer.enabled = false
	replaydisplayshowtimer.enabled = false
	replayshowon = false
	showinprogress = false
		
	if musicstarted = true then

		playsong2()

	end if

end sub

dim rds

sub replaydisplayshowtimer_Timer()

	rds = rds + 1

	if (rds = 1) or (rds = 3) or (rds = 5) or (rds = 7) or (rds = 9) or (rds = 11) or (rds = 13) or (rds = 15) or (rds = 17) or (rds = 19) or (rds = 21) or (rds = 23) or (rds = 25) or (rds = 27) or (rds = 29) then

	hdisplay1.text = "SPECIAL         "
	hdisplay2.text = "         SPECIAL"

	display1.text = "SPECIAL         "
	display2.text = "         SPECIAL"
        DisplayB2SText "SPECIAL         " & "         SPECIAL"
	end if

	if (rds = 2) or (rds = 4) or (rds = 6) or (rds = 8) or (rds = 10) or (rds = 12) or (rds = 14) or (rds = 16) or (rds = 18) or (rds = 20) or (rds = 22) or (rds = 24) or (rds = 26) or (rds = 28) then

	hdisplay1.text = "         SPECIAL"
	hdisplay2.text = "SPECIAL         "

	display1.text = "         SPECIAL"
	display2.text = "SPECIAL         "
        DisplayB2SText "         SPECIAL" & "SPECIAL         "
	end if

	if rds = 30 then

	'hdisplay1.slowblinkspeed = 30
	
	hdisplay1.text = "   EXTRA BALL   "', seblink, 1490
	hdisplay2.text = "                "', senone, 1490

	display1.text = "   EXTRA BALL   "', seblink, 1490
	display2.text = "                "', senone, 1490
        DisplayB2SText "   EXTRA BALL   " & "                "
	end if

	if rds = 31 then

	twinkletimer.enabled = false

	replaydisplayshowtimer.enabled = false
	rds = 0

	end if

end sub

sub scorereplay()

	playsound "fx_knocker"
	replayscored = true
	extraballs = extraballs + 1
	shootagainlight.state = 1

	extraballsscored = extraballsscored + 1

end sub
'
Sub AddScore(points)

if blackout = false then

	If (Tilted = FALSE) and (matchon = false) Then
		' add the points to the current players score variable
		Score(CurrentPlayer) = Score(CurrentPlayer) + points

		if (score(currentplayer) > replayscore) and (replayscored = false) then

			if ((jackpotshowon = false) and (bonuson = false)) then
			
			replayshowon = true
			replayshow()

			end if

			scorereplay()

		end if

		if ((multiballon = false) and (quickmultiballon = false)) then

		if ((displayinterrupt = false) and (showinprogress = false) and (replayshowon = false)) or (balljustlocked = true) then

			if Score(CurrentPlayer) = 0 then

				'hdisplay1.slowblinkspeed = 100
				hdisplay1.text = "     OO         "', seBlink, 100000000

				'display1.slowblinkspeed = 100
				display1.text = "     OO         "', seBlink, 100000000
                DisplayB2SText2 "*-*-*-*-*-*-*-*-*" & "*-*-*-*-*-*-*-*-*"
			end if


			
			if ((Score(CurrentPlayer) > 0) and (Score(CurrentPlayer) < 99)) then

				if (noswitchhit = true) then
             display1.text = Score(CurrentPlayer) &"                "                   
             display2.text = "           BALL " & Ball
                    DMDScore

					'display1.flushqueue()

					'display1.slowblinkspeed = 100
					'display1.text = "     " & Score(CurrentPlayer)', seBlink, 100000000

				else

             display1.text = Score(CurrentPlayer) &"                "                   
             display2.text = "           BALL " & Ball 
                    DMDScore
				end if

			end if 



			if ((Score(CurrentPlayer) > 99) and (Score(CurrentPlayer)) < 999)  then

				if (noswitchhit = true) then

             display1.text = Score(CurrentPlayer) &"                "                   
             display2.text = "           BALL " & Ball
                    DMDScore
					'display1.flushqueue()

				'	display1.slowblinkspeed = 100
					'display1.text = "    " & Score(CurrentPlayer)', seBlink, 100000000

				else

             display1.text = Score(CurrentPlayer) &"                "                   
             display2.text = "           BALL " & Ball
                    DMDScore
				end if

			end if



			if ((Score(CurrentPlayer) > 999) and (Score(CurrentPlayer)) < 9999)  then

				if (noswitchhit = true) then

             display1.text = Score(CurrentPlayer) &"                "                   
             display2.text = "           BALL " & Ball
                    DMDScore
					'display1.flushqueue()

					'display1.slowblinkspeed = 100
					'display1.text = "   " & Score(CurrentPlayer) ', seBlink, 100000000

				else

             display1.text = Score(CurrentPlayer) &"                "                   
             display2.text = "           BALL " & Ball 
                    DMDScore
				end if

			end if  



			if ((Score(CurrentPlayer) > 9999) and (Score(CurrentPlayer)) < 99999)  then

				if (noswitchhit = true) then

             display1.text = Score(CurrentPlayer) &"                "                   
             display2.text = "           BALL " & Ball
                    DMDScore
					'display1.flushqueue()

					'display1.slowblinkspeed = 100
					'display1.text = "  " & Score(CurrentPlayer) ', seBlink, 100000000

				else

             display1.text = Score(CurrentPlayer) &"                "                   
             display2.text = "           BALL " & Ball 
                    DMDScore
				end if

			end if 



			if ((Score(CurrentPlayer) > 99999) and (Score(CurrentPlayer)) < 999999)  then

				if (noswitchhit = true) then

             display1.text = Score(CurrentPlayer) &"                "                   
             display2.text = "           BALL " & Ball
                    DMDScore
					'display1.flushqueue()

					'display1.slowblinkspeed = 100
					'display1.text = " " & Score(CurrentPlayer) ', seBlink, 100000000

				else

             display1.text = Score(CurrentPlayer) &"                "                   
             display2.text = "           BALL " & Ball
                    DMDScore
				end if

			end if 



			if (Score(CurrentPlayer) > 999999) then

				if (noswitchhit = true) then

					'hdisplay1.flushqueue()

					'hdisplay1.slowblinkspeed = 100
					'hdisplay1.text = Score(CurrentPlayer)', seBlink, 100000000
             display1.text = Score(CurrentPlayer) &"                "                   
             display2.text = "           BALL " & Ball
                    DMDScore
					'display1.flushqueue()

					'display1.slowblinkspeed = 100
					'display1.text = Score(CurrentPlayer)', seBlink, 100000000

				else

             display1.text = Score(CurrentPlayer) &"                "                   
             display2.text = "           BALL " & Ball
                    DMDScore
				end if

			end if 
             display1.text = Score(CurrentPlayer) &"                "                   
             display2.text = "           BALL " & Ball
			'hdisplay2.text = "         BALL " & ball & " "
			'display2.text = "         BALL " & ball & " "
            DMDScore
		end if

		else

		if ((displayinterrupt = false) and (showinprogress = false) and (replayshowon = false)) then

			if ((multiballon = false) and (quickmultiballon = true)) then

				'hdisplay1.flushqueue()
				'hdisplay2.flushqueue()

				'hdisplay1.slowblinkspeed = 100
				'hdisplay2.slowblinkspeed = 100

				hdisplay1.text = "SHOOT BOTH RAMPS"', seblink, 1000000

				'display1.flushqueue()
				'display2.flushqueue()

				'display1.slowblinkspeed = 100
				'display2.slowblinkspeed = 100

				display1.text = "SHOOT BOTH RAMPS"', seblink, 1000000
                DisplayB2SText2 "SHOOT BOTH RAMPS" & "                "

					if (Score(CurrentPlayer) > 99) then

						hdisplay2.text = "      " & Score(CurrentPlayer)
						display2.text = "      " & Score(CurrentPlayer)
                        DMDScore
					end if

					if (Score(CurrentPlayer) > 999) then

						hdisplay2.text = "      " & Score(CurrentPlayer)
						display2.text = "      " & Score(CurrentPlayer)
                        DMDScore
					end if

					if (Score(CurrentPlayer) > 9999) then

						hdisplay2.text = "     " & Score(CurrentPlayer)
						display2.text = "     " & Score(CurrentPlayer)
                         DMDScore
					end if

					if (Score(CurrentPlayer) > 99999) then

						hdisplay2.text = "     " & Score(CurrentPlayer)
						display2.text = "     " & Score(CurrentPlayer)
                         DMDScore
					end if

					if (Score(CurrentPlayer) > 999999) then

						hdisplay2.text = "    " & Score(CurrentPlayer)
						display2.text = "    " & Score(CurrentPlayer)
                        DMDScore
					end if

					if (Score(CurrentPlayer) > 9999999) then

						hdisplay2.text = "    " & Score(CurrentPlayer)
						display2.text = "    " & Score(CurrentPlayer)
                        DMDScore
					end if

			end if

				if ((multiballon = true) and (quickmultiballon = false)) then

					If (twomillionlit = false) and (jackpotshowon = false) then

						if lightjackpotlit = true then

						'hdisplay1.flushqueue()
						'hdisplay2.flushqueue()

					'	hdisplay1.slowblinkspeed = 100
					'	hdisplay2.slowblinkspeed = 100

						hdisplay1.text = " SHOOT CHAINSHAW AREA "', seblink, 1000000

						'display1.flushqueue()
						'display2.flushqueue()

					'	display1.slowblinkspeed = 100
					'	display2.slowblinkspeed = 100

						display1.text = " SHOOT CHAINSHAW AREA "', seblink, 1000000
	                    DisplayB2SText2 " SHOOT CHAINSHAW AREA " & "                "

							if (Score(CurrentPlayer) > 99) then

								hdisplay2.text = "      " & Score(CurrentPlayer)
								display2.text = "      " & Score(CurrentPlayer)
                                DMDScore
							end if

							if (Score(CurrentPlayer) > 999) then
	
								hdisplay2.text = "      " & Score(CurrentPlayer)
								display2.text = "      " & Score(CurrentPlayer)
                                DMDScore
							end if

							if (Score(CurrentPlayer) > 9999) then

								hdisplay2.text = "     " & Score(CurrentPlayer)
								display2.text = "     " & Score(CurrentPlayer)
                                DMDScore
							end if

							if (Score(CurrentPlayer) > 99999) then

								hdisplay2.text = "     " & Score(CurrentPlayer)
								display2.text = "     " & Score(CurrentPlayer)
                                DMDScore
							end if

							if (Score(CurrentPlayer) > 999999) then

								hdisplay2.text = "    " & Score(CurrentPlayer)
								display2.text = "    " & Score(CurrentPlayer)
                                DMDScore
							end if

							if (Score(CurrentPlayer) > 9999999) then

								hdisplay2.text = "    " & Score(CurrentPlayer)
								display2.text = "    " & Score(CurrentPlayer)
                                DMDScore
							end if

						else

					'	hdisplay1.flushqueue()
					'	hdisplay2.flushqueue()

					'	hdisplay1.slowblinkspeed = 100
					'	hdisplay2.slowblinkspeed = 100

						hdisplay1.text = "SHOOT BOTH RAMPS"', seblink, 1000000

					'	display1.flushqueue()
						'display2.flushqueue()

					'	display1.slowblinkspeed = 100
					'	display2.slowblinkspeed = 100

						display1.text = "SHOOT BOTH RAMPS"', seblink, 1000000
                        DisplayB2SText2 " SHOOT BOTH RAMPS" & "                "

							if (Score(CurrentPlayer) > 99) then

								hdisplay2.text = "      " & Score(CurrentPlayer)
								display2.text = "      " & Score(CurrentPlayer)
                                DMDScore
							end if

							if (Score(CurrentPlayer) > 999) then

								hdisplay2.text = "      " & Score(CurrentPlayer)
								display2.text = "      " & Score(CurrentPlayer)
                                DMDScore
							end if

							if (Score(CurrentPlayer) > 9999) then

								hdisplay2.text = "     " & Score(CurrentPlayer)
								display2.text = "     " & Score(CurrentPlayer)
                                DMDScore
							end if

							if (Score(CurrentPlayer) > 99999) then

								hdisplay2.text = "     " & Score(CurrentPlayer)
								display2.text = "     " & Score(CurrentPlayer)
                                DMDScore
							end if

							if (Score(CurrentPlayer) > 999999) then

								hdisplay2.text = "    " & Score(CurrentPlayer)
								display2.text = "    " & Score(CurrentPlayer)
                                DMDScore
							end if

							if (Score(CurrentPlayer) > 9999999) then

								hdisplay2.text = "    " & Score(CurrentPlayer)
								display2.text = "    " & Score(CurrentPlayer)
                                DMDScore
							end if

						end if

					end if

				end if

			end if

		end if

	End if

	if buzzer > 8 then

		buzztimer.enabled = false
		buzzer = buzzer - buzzer

	end if

end if

	' you may wish to check to see if the player has gotten a replay
End Sub

Sub Addbonuspoints(points)

if blackout = false then

	If (Tilted = FALSE) and (matchon = false) Then
		
		bonuspoints = bonuspoints + points

		if bonuspoints > 99000 then

			bonuspoints = 99000

		end if

	end if

end if

end sub

' Add some points to the current Jackpot.
'
Dim nvJackpot
Sub AddJackpot(points)
	' Jackpots only generally increment in multiball mode and not tilted
	' but this dosn't have to tbe the case
	If (Tilted = False) Then

		If (bMultiBallMode = TRUE) Then
			nvJackpot = nvJackpot + points
            DOF 133, DOFPulse
			' you may wish to limit the jackpot to a upper limit, ie..
			'	If (nvJackpot >= 6000) Then
			'		nvJackpot = 6000
			' 	End if
		End if
	End if
End Sub


' Will increment the Bonus Multiplier to the next level
'
Sub IncrementBonusMultiplier()
	Dim NewBonusLevel

	' if not at the maximum bonus level
	if (BonusMultiplier(CurrentPlayer) < constMaxMultiplier) then
		' then set it the next next one and set the lights
		NewBonusLevel = BonusMultiplier(CurrentPlayer) + 1
		SetBonusMultiplier(NewBonusLevel)
   End if
End Sub


' Set the Bonus Multiplier to the specified level and set any lights accordingly
'
Sub SetBonusMultiplier(Level)
	' Set the multiplier to the specified level
	BonusMultiplier(CurrentPlayer) = Level

	' If the multiplier is 1 then turn off all the bonus lights
	If (BonusMultiplier(CurrentPlayer) = 1) Then
		' insert your own code here
	Else
		' there is a bonus, turn on all the lights upto the current level
		If (BonusMultiplier(CurrentPlayer) >= 2) Then
			' insert your own code here
		End If
		' etc..
	End If
End Sub

sub giblink()

if (blackout = false) and (tilted = false) then

flashforms gi1, 1000, 100, bulbon
flashforms gi4, 1000, 100, bulbon
flashforms gi4, 1000, 100, bulbon
flashforms gi5, 1000, 100, bulbon
flashforms gi6, 1000, 100, bulbon
flashforms gi7, 1000, 100, bulbon
flashforms gi8, 1000, 100, bulbon
flashforms gi9, 1000, 100, bulbon
flashforms gi10, 1000, 100, bulbon
flashforms gi11, 1000, 100, bulbon
flashforms gi12, 1000, 100, bulbon
flashforms gi13, 1000, 100, bulbon
flashforms gi14, 1000, 100, bulbon
flashforms gi15, 1000, 100, bulbon
flashforms gi16, 1000, 100, bulbon
flashforms gi17, 1000, 100, bulbon
flashforms gi18, 1000, 100, bulbon
flashforms gi19, 1000, 100, bulbon
flashforms gi20, 1000, 100, bulbon
flashforms gi21, 1000, 100, bulbon
flashforms gi43, 1000, 100, bulbon
flashforms gi44, 1000, 100, bulbon
flashforms gi45, 1000, 100, bulbon
flashforms gi46, 1000, 100, bulbon
flashforms gi47, 1000, 100, bulbon

	if superjets = false then

	flashforms bumper1L, 1000, 100, bulbon
	flashforms bumper2L, 1000, 100, bulbon
	flashforms bumper3L, 1000, 100, bulbon

	else

	resetjetlights()

	end if

end if

End sub



sub giquickflicker()

if (blackout = false) and (tilted = false) then

flashforms gi1, 1000, 40, bulbon
flashforms gi4, 1000, 40, bulbon
flashforms gi4, 1000, 40, bulbon
flashforms gi5, 1000, 40, bulbon
flashforms gi6, 1000, 40, bulbon
flashforms gi7, 1000, 40, bulbon
flashforms gi8, 1000, 40, bulbon
flashforms gi9, 1000, 40, bulbon
flashforms gi10, 1000, 40, bulbon
flashforms gi11, 1000, 40, bulbon
flashforms gi12, 1000, 40, bulbon
flashforms gi13, 1000, 40, bulbon
flashforms gi14, 1000, 40, bulbon
flashforms gi15, 1000, 40, bulbon
flashforms gi16, 1000, 40, bulbon
flashforms gi17, 1000, 40, bulbon
flashforms gi18, 1000, 40, bulbon
flashforms gi19, 1000, 40, bulbon
flashforms gi20, 1000, 40, bulbon
flashforms gi21, 1000, 40, bulbon
flashforms gi43, 1000, 40, bulbon
flashforms gi44, 1000, 40, bulbon
flashforms gi45, 1000, 40, bulbon
flashforms gi46, 1000, 40, bulbon
flashforms gi47, 1000, 40, bulbon

'BGGI.play seqblinking, , 20, 20

	if superjets = false then

	flashforms bumper1L, 1000, 40, bulbon
	flashforms bumper2L, 1000, 40, bulbon
	flashforms bumper3L, 1000, 40, bulbon

	else

	resetjetlights()

	end if

end if

End sub

sub giflicker()

if (blackout = false) and (tilted = false) then

gi1.State = Bulbblink', "10", 40
'gi2.State = Bulbblink', "10", 40
'gi3.State = Bulbblink', "10", 40
gi4.State = Bulbblink', "10", 40
gi5.State = Bulbblink', "10", 40
gi6.State = Bulbblink', "10", 40
gi7.State = Bulbblink', "10", 40
gi8.State = Bulbblink', "10", 40
gi9.State = Bulbblink',' "10", 40
gi10.State = Bulbblink', "10", 40
gi11.State = Bulbblink', "10", 40
gi12.State = Bulbblink', "10", 40
gi13.State = Bulbblink', "10", 40
gi14.State = Bulbblink', "10", 40
gi15.State = Bulbblink', "10", 40
gi16.State = Bulbblink', "10", 40
gi17.State = Bulbblink', "10", 40
gi18.State = Bulbblink', "10", 40
gi19.State = Bulbblink', "10", 40
gi20.State = Bulbblink', "10", 40
gi21.State = Bulbblink', "10", 40
gi22.State = Bulbblink', "10", 40
'gi23.State = Bulbblink', "10", 40
gi24.State = Bulbblink', "10", 40
'gi25.set Bulbblink, "10", 40
'gi26.set Bulbblink, "10", 40
'gi27.set Bulbblink, "10", 40
'gi28.set Bulbblink, "10", 40
'gi29.set Bulbblink, "10", 40
'gi30.set Bulbblink, "10", 40
'gi31.set Bulbblink, "10", 40
'gi32.set Bulbblink, "10", 40
'gi33.set Bulbblink, "10", 40
'gi34.set Bulbblink, "10", 40
'gi35.set Bulbblink, "10", 40
'gi36.set Bulbblink, "10", 40
'gi37.set Bulbblink, "10", 40
'gi38.set Bulbblink, "10", 40
'gi39.set Bulbblink, "10", 40
'gi40.set Bulbblink, "10", 40
'gi41.set Bulbblink, "10", 40
'gi42.set Bulbblink, "10", 40
gi43.State = Bulbblink', "10", 40
gi44.State = Bulbblink', "10", 40
gi45.State = Bulbblink', "10", 40
gi46.State = Bulbblink', "10", 40
gi47.State = Bulbblink


'BGGI.play seqblinking, , 200, 20

	if superjets = false then

	bumper1l.State = Bulbblink', "10", 40
	bumper2l.State = Bulbblink', "10", 40
	bumper3l.State = Bulbblink', "10", 40

	else

	resetjetlights()

	end if

end if

end sub

sub resetjetlights()

	if superjets = false then

		bumper1l.State = Bulbon', "10", 150
		Bumper2L.State = Bulbon', "10", 150
		Bumper3L.State = Bulbon', "10", 150

	else

		bumper1l.State = Bulbblink', "10", 150
		Bumper2L.State = Bulbblink', "10", 150
		Bumper3L.State = Bulbblink', "10", 150

	end if

end sub

dim match

' *********************************************************************
' **                                                                 **
' **                     Table Object Script Events                  **
' **                                                                 **
' *********************************************************************

' The Left Slingshot has been Hit, Add Some Points and Flash the Slingshot Lights
'
Dim LStep, RStep
Sub addmatch()

	match = match + 1

	if match = 10 then
	match = 0
	end if

end sub

Sub LeftSlingshotRubber_Slingshot()
  
	Switch()
    PlaySound "LeftSlingShot"
if (blackout = false) and (tilted = false) then

	If Tilted Then Exit Sub	' Ignore this _Hit() event if the table is tilted.
    PlaySound SoundFXDOF("JYCSFX39", 103, DOFPulse, DOFContactors), 0, 1, -0.05, 0.05
    LeftSling4.Visible = 1
    Lemk.RotX = 26
    LStep = 0
    LeftSlingshotRubber.TimerEnabled = True
	DOF 140, DOFPulse

	
	' add some points
	AddScore(110)	
	addmatch()
	' flash the lights around the slingshot
	FlashForMs LeftSlingshotBulb1, 100, 50, BulbOff
	FlashForMs LeftSlingshotBulb2, 100, 50, BulbOff

	flashforms strobe1, 500, 100, 0

	if faded = false then

	Playsound "JYCSFX39"', FALSE, 0.7

	end if

end if

End Sub

Sub LeftSlingshotRubber_Timer
    Select Case LStep
        Case 1:LeftSLing4.Visible = 0:LeftSLing3.Visible = 1:Lemk.RotX = 14
        Case 2:LeftSLing3.Visible = 0:LeftSLing2.Visible = 1:Lemk.RotX = 2
        Case 3:LeftSLing2.Visible = 0:Lemk.RotX = -10:LeftSlingshotRubber.TimerEnabled = 0
    End Select

    LStep = LStep + 1
End Sub

	



' The Right Slingshot has been Hit, Add Some Points and Flash the Slingshot Lights
'
Sub RightSlingshotRubber_Slingshot()

	Switch()
    PlaySound "RightSlingShot"
if (blackout = false) and (tilted = false) then

    PlaySound SoundFXDOF("RightSlingShot", 104, DOFPulse, DOFContactors), 0, 1, 0.05, 0.05
    DOF 121, DOFPulse
	RightSling4.Visible = 1
    Remk.RotX = 26
    RStep = 0
    RightSlingShotRubber.TimerEnabled = True
	DOF 141, DOFPulse


	' add some points
	AddScore(110)
	addmatch()
	' flash the lights around the slingshot
	FlashForMs RightSlingshotBulb1, 100, 50, BulbOff
	FlashForMs RightSlingshotBulb2, 100, 50, BulbOff

	flashforms strobe10, 500, 100, 0

	if faded = false then

	playsound "JYCSFX40"', FALSE, 0.7

	end if

end if
	
End Sub


Sub RightSlingshotRubber_Timer
    Select Case RStep
        Case 1:RightSLing4.Visible = 0:RightSLing3.Visible = 1:Remk.RotX = 14
        Case 2:RightSLing3.Visible = 0:RightSLing2.Visible = 1:Remk.RotX = 2
        Case 3:RightSLing2.Visible = 0:Remk.RotX = -10:RightSlingShotRubber.TimerEnabled = 0
    End Select

    RStep = RStep + 1
End Sub
'



' The Left InLane trigger has been Hit
'
Sub LeftInLaneTrigger_Hit()
	If Tilted Then Exit Sub	' Ignore this _Hit() event if the table is tilted.
	DOF 111, DOFPulse
	Switch()

if (blackout = false) and (tilted = false) then

	if matchon = false then

	if clawlight2.state = 1 then

		if (multiballon = false) and (faded = false) then

			playsound "jycsfx18"', False, 0.4

		end if

	else

	if faded = false then

	playsound "jycsfx3"', False, 0.4

	end if

	flashforms leftinlanestrobe, 1000, 75, bulboff
	flashforms leftinlanestrobe2, 1000, 75, bulboff

	if multiballstrobes = false then

		leftstrobesdown()

	end if

	end if

	clawlight2.state = bulbon
	checkclawlanes()

	' add some points
	AddScore(5000)
	' remember last trigger hit by the ball
	set LastSwitchHit = LeftInLaneTrigger

	end if

end if

End Sub


' The Right InLane trigger has been Hit
'
Sub RightInLaneTrigger_Hit()
	If Tilted Then Exit Sub	' Ignore this _Hit() event if the table is tilted.
	DOF 112, DOFPulse
	Switch()

if (blackout = false) and (tilted = false) then

	if clawlight3.state = 1 then

		if (multiballon = false) and (faded = false) then

			playSound "jycsfx18"', False, 0.4

		end if

	else

	if faded = false then

	playSound "jycsfx3"', False, 0.4

	end if

	flashforms rightinlanestrobe, 1000, 75, bulboff
	flashforms rightinlanestrobe2, 1000, 75, bulboff

	if multiballstrobes = false then

		rightstrobesdown()

	end if

	end if

	clawlight3.state = bulbon
	checkclawlanes()

	' add some points
	AddScore(5000)
	' remember last trigger hit by the ball
	set LastSwitchHit = RightInLaneTrigger

end if

End Sub


' The Left OutLane trigger has been Hit
'
Sub LeftOutLaneTrigger_Hit()
	If Tilted Then Exit Sub	' Ignore this _Hit() event if the table is tilted.
	DOF 110, DOFPulse
    DMDUpdate.Enabled = 0
if (blackout = false) and (tilted = false) then

	clawlight1.state = bulbon
	checkclawlanes()

	If kickbacklit = true then
 
	Kickback.enabled = 1
    kickbacktimer.interval = 800
	kickbacktimer.enabled = true
	kickbacklight.state = bulbblink

	MainSeq2.updateinterval = 5
	MainSeq2.Play SeqUpOn, 50

	AddScore(5000)

	if ((multiballon = false) and (quickmultiballon = false)) then
	
		kickbacksave = true

	end if

	if faded = false then

	playSound "jycsfx29"', False, 0.6

	end if

	else

	outlane()

	end if


	' remember last trigger hit by the ball
	set LastSwitchHit = LeftOutLaneTrigger

else
    Kickback.enabled = 0
    'LeftOutLaneTrigger.Kick  120, 2
	playSound "jycsfx30"', False, 0.5

end if

End Sub

Sub KickbackSolenoidPulse()
    DMDUpdate.interval = 2000
    DMDUpdate.Enabled = 1
    Kickback.kick 0, 70
    LaserKickP1.TransY = 90
    vpmtimer.addtimer 800, "LaserKickP1.TransY = 0 '"
    Playsound "bumper_retro"
End sub

Sub Kickback_Hit()
    Kickback.kick 0, 70
    LaserKickP1.TransY = 90
    vpmtimer.addtimer 800, "LaserKickP1.TransY = 0 '"
    Playsound "bumper_retro"
End sub

dim kickbacklit

sub lightkickback()
    
	kickbacklit = true
	kickbacklight.state = bulbon
	lightkickbacklight.state = bulboff
    Kickback.enabled = 1
end sub

sub kickbacktimer_Timer()
    Kickback.enabled = 0
	kickbacktimer.enabled = false
	kickbacklit = false
	kickbacklight.state = bulboff
	lightkickbacklight.state = bulbon
	kickbacksave = false

end sub

dim outlanes
dim ballsaveoutlanesafety

sub outlane()

	playSound "jycsfx30"', False, 0.5

	AddScore(20000)

	If ((multiballon = false) and (quickmultiballon = false) and (ballsave = false)) then

		musicstarted = false

		If locklit = false then
			if score(currentplayer) > 1000000 then
			playSound "jycmainballlost"', False, 0.7
			else
			playSound "jycmainballlost2"',' False, 0.7								
			end if
		end if

		if ((locklit = true) and (multiballrestart = false)) then
			playSound "jyclocklitballlost"', False, 0.7
		end if

		if ((locklit = true) and (multiballrestart = true)) then
			playSound "jycrestartmultiballballlost"', False, 0.7
		end if

		if blackout = true then
			playSound "jycblackoutballlost"', False, 0.7
		end if	

		outlanes = outlanes + 1

		if outlanes = 2 then

		playSound "spchnotagain"', false, 0.9, 400
		fadedelay.interval = 400
		fadedelay.enabled = true

		end if

		if outlanes = 3 then

		playSound "spchkittenme"', false, 0.9, 400
		fadedelay.interval = 400
		fadedelay.enabled = true

		outlanes = outlanes - 2

		end if

	end if

	If ballsave = true then

		ballsavetimer.enabled = false
		ballsaveoutlanesafety = true

	end if

end sub

dim extraballs

sub ballsavetimer_Timer()

	endballsave()

end sub

sub endballsave()

	ballsave = false
	ballsavetimer.enabled = false

	ballsaveoutlanesafety = false

	if extraballs > 0 then

	shootagainlight.state = 1
    
	else

	shootagainlight.state = bulboff

	end if

end sub

' The Right OutLane trigger has been Hit
'
Sub RightOutLaneTrigger_Hit()
	If Tilted Then Exit Sub	' Ignore this _Hit() event if the table is tilted.
	DOF 113, DOFPulse
if (blackout = false) and (tilted = false) then

	outlane()

	clawlight4.state = bulbon
	checkclawlanes()

	' add some points
	' remember last trigger hit by the ball
	set LastSwitchHit = RightOutLaneTrigger

else

	playSound "jycsfx30"', False, 0.5

end if

End Sub

dim musicstarted

Sub shootergate_hit()

if tilted = false then

	if musicstarted = false then

		if (blackout = false) and (tilted = false) then

			if locklit = false then
                StopAllSounds
				song = 2
				playsong2()
				musicstarted = true
			end if

			if locklit = true then
                StopAllSounds
				song = 4
				playsong2()
				musicstarted = true
			end if

		else
                StopAllSounds
				song = 9
				playsong2()
				musicstarted = true

		End if

	end if

end if

End sub

Sub Switch()

if (blackout = false) and (tilted = false) then

	if matchon = false then

		ballsearchtimer.interval = 20000
		ballsearchtimer.enabled = true

		if ballsaveoutlanesafety = true then

		endballsave()

		end if

		if statusreporton = true then

			endstatusreport()

		end if

		leftstatustimer.enabled = false
		rightstatustimer.enabled = false

		if ballsearchon = true then

			ballsearchon = false
			resetdiverters()

		end if

		If noswitchhit = true then

			noswitchhit = false
			ballsavetimer.enabled = true

			shooterspeechtimer.enabled = false

			statusspeechtimer.enabled = true

			if ((locklit = true) and (ballinrightlock = false)) then

				resetdiverters()

			end if

		end if

		if musicstarted = false then

			if locklit = false then
                StopAllSounds
				song = 2
				playsong2()
				musicstarted = true
			end if

			if locklit = true then
				song = 4
				playsong2()
				musicstarted = true
			end if

		end if

	end if

else

	if tilted = false then

		if musicstarted = false then

			if blackout = false then

				if locklit = false then
                    StopAllSounds
					song = 2
					playsong2()
					musicstarted = true
				end if

				if locklit = true then
					song = 4
					playsong2()
					musicstarted = true
				end if

			else
		
				song = 9
				playsong2()
				musicstarted = true

			End if

		end if

	end if

	ballsearchtimer.interval = 20000
	ballsearchtimer.enabled = true

	if ballsearchon = true then

		ballsearchon = false
		resetdiverters()

	end if

	If noswitchhit = true then

		noswitchhit = false

	end if

end if

End Sub

sub statusspeechtimer_Timer()

	statusspeech()

end sub

dim speechstatusblinking

sub statusspeech()

if (blackout = false) and (tilted = false) then

	if showinprogress = false then

		if ((multiballon = false) and (quickmultiballon = false) and (multiballrestart = false) and (musicstarted = true)) then

			if locklit = true then

				lockremind()

			else

				if (speechstatusblinking = false) and (multiballplayed = false) then

				playsound "spchshootblinking"', false, 0.8
				fademusic()

				speechstatusblinking = true

				end if

			end if

		end if

	statusspeechtimer.enabled = false

	else

	statusspeechtimer.enabled = true

	end if

end if

end sub

Dim Ballsinscoop

Sub Scoop_hit()
    
	Switch()
	
	scoop1.enabled = 0
	Ballsinscoop = Ballsinscoop + 1
	scooptimer.enabled = true

if (blackout = false) and (tilted = false) then

	if kickbacklit = false then

		lightkickback()
		lightkickbacklight.state = bulboff
		lightkickbackshow()

		showinprogress = true
		showtimer.interval = 2000
		showtimer.enabled = true

		addscore(5000)

	else

		playsound "jycsfx60"', false, 0.8

	end if

	addscore(15000)

	flashforms strobe6, 1000, 40, bulboff

end if

End Sub

sub lightkickbackshow()

	if multiballrestart = false then

	'hdisplay1.flushqueue()
	'hdisplay2.flushqueue()

	playsound "jycsfx38"', False, 0.6
	hdisplay1.text = "    KICKBACK    "', sescrollrightover, 2000
	hdisplay2.text = "     IS LIT     "', sescrollrightover, 2000

	'display1.flushqueue()
	'display2.flushqueue()

	display1.text = "    KICKBACK    "', sescrollrightover, 2000
	display2.text = "     IS LIT     "', sescrollrightover, 2000
    DisplayB2SText2 "     KICKBACK    " & "     IS LIT     "

		if multiballon = false then

			playsound "spchcomeinhandy"', false, 0.8, 800
			fadedelay.interval = 1000
			fadedelay.enabled = true

		end if

	end if

end sub



sub scooptimer_Timer()

	If ballsinscoop > 0 then

		scoopsolenoidpulse()
		ballsinscoop = ballsinscoop - 1

		if ((matchon = false) and (blackout = false) and (faded = false)) then

		playsound "jycsfx28"', False, 0.4

		end if

	End if
	
	If ballsinscoop = 0 then
	
	scooptimer.enabled = false

	End if

End sub

Sub scoopsolenoidpulse()
    PlaySound "salidadebola"
    scoop.kick 0, 20, 1.5
    scoop1Timer.interval = 800
    scoop1Timer.enabled = True
End Sub

Sub scoop1Timer_Timer
    scoop1Timer.enabled = False
    scoop.enabled = 1
    scoop1.enabled = 1
End Sub    


dim trashcanlit
dim nextrandomaward

sub lighttrashcan()

	trashcanlit = true

	if (multiballon = false) and (quickmultiballon = false) then

	randomawardlight.state = 1

	end if

end sub

dim ballintrashcan

Sub trashcan_hit()

if (blackout = false) and (tilted = false) then

	if ballintrashcan = false then

		ballintrashcan = true

		Switch()

		if ((multiballon = true) and (lightjackpotlit = true)) then

			lightjackpot()

		else

		delaytrashcantimer.enabled = true

		end if

	end if

else

	trashcantimer.interval = 1000	
	trashcantimer.enabled = true

end if

End Sub

sub delaytrashcantimer_Timer()

	delaytrashcantimer.enabled = false

	if ((trashcanlit = true) and (multiballon = false) and (quickmultiballon = false) and (multiballrestart = false) and (extraballslit = 0) and (jackpotshowon = false)) then

		randomaward()

	else

		trashcantimer.interval = 1000
		trashcantimer.enabled = true

		if extraballslit = 0 then

			flashforms trashcanstrobe, 1000, 40, bulboff
			playsound "jycsfx60"', false, 0.8

		end if

		if extraballslit > 0 then

		scoreextraball()

		end if

		addscore(25000)

	end if

end sub

Dim extraballsscored

sub scoreextraball()

	extraballs = extraballs + 1
	extraballslit = extraballslit - 1
	shootagainlight.state = 1
	checkextraballs()

	extraballsscored = extraballsscored + 1

	DOF 124, DOFPulse
	DOF 125, DOFPulse

	if (multiballon = false) and (quickmultiballon = false) and (blackout = false) and (multiballrestart = false) and (jackpotshowon = false) then

		extraballshow()

	end if

end sub

dim extraballshowon

sub extraballshow()

	statusspeechtimer.enabled = false
	trashcantimer.enabled = false
	extraballshowtimer.enabled = true
	playsound "jycextraball"', false, 0.8
	playsound "spchcomeinhandy"', false, 0.9, 3250
	showinprogress = true
	showtimer.enabled = false
	ballsearchtimer.enabled = false
	ballsearchon = false

	'lookatbackbox()

	extraballshowon = true

	'hdisplay1.flushqueue()
	'hdisplay2.flushqueue()

	'display1.flushqueue()
	'display2.flushqueue()

	ebstimer.enabled = true
	
	twinklesides = false
	twinkle = 0
	twinkletimer.enabled = true

	mainseq2.stopplay()
	mainseq.updateinterval = 10
	mainseq.Play SeqMiddleOutHorizOn, 30, 10, 0

end sub

dim ebs

sub ebstimer_Timer()

	ebs = ebs + 1

	if ebs = 1 then

	hdisplay1.text = "L               "
	hdisplay2.text = "                "

	display1.text = "L               "
	display2.text = "                "
      DisplayB2SText "L               " & "                "
	end if

	if ebs = 2 then

	hdisplay1.text = "LL              "
	hdisplay2.text = "                "

	display1.text = "LL              "
	display2.text = "                "
      DisplayB2SText "LL              " & "                "
	end if

	if ebs = 3 then

	hdisplay1.text = "ALL             "
	hdisplay2.text = "                "

	display1.text = "ALL             "
	display2.text = "                "
      DisplayB2SText "ALL             " & "                "
	end if

	if ebs = 4 then

	hdisplay1.text = "BALL            "
	hdisplay2.text = "                "

	display1.text = "BALL            "
	display2.text = "                "
      DisplayB2SText "BALL            " & "                "
	end if

	if ebs = 5 then

	hdisplay1.text = " BALL           "
	hdisplay2.text = "                "

	display1.text = " BALL           "
	display2.text = "                "
      DisplayB2SText "BALL            " & "                "
	end if

	if ebs = 6 then

	hdisplay1.text = "A BALL          "
	hdisplay2.text = "                "

	display1.text = "A BALL          "
	display2.text = "                "
      DisplayB2SText "A BALL          " & "                "

	end if

	if ebs = 7 then

	hdisplay1.text = "RA BALL         "
	hdisplay2.text = "                "

	display1.text = "RA BALL         "
	display2.text = "                "
      DisplayB2SText "RA BALL         " & "                "
	end if

	if ebs = 8 then

	hdisplay1.text = "TRA BALL        "
	hdisplay2.text = "                "

	display1.text = "TRA BALL        "
	display2.text = "                "
      DisplayB2SText "TRA BALL        " & "                "
	end if

	if ebs = 9 then

	hdisplay1.text = "XTRA BALL       "
	hdisplay2.text = "                "

	display1.text = "XTRA BALL       "
	display2.text = "                "
      DisplayB2SText "XTRA BALL       " & "                "
	end if

	if ebs = 10 then

	hdisplay1.text = " EXTRA BALL     "
	hdisplay2.text = "                "

	display1.text = " EXTRA BALL     "
	display2.text = "                "
      DisplayB2SText "EXTRA BALL     " & "                "
	end if

	if ebs = 11 then

	hdisplay1.text = "  EXTRA BALL    "
	hdisplay2.text = "                "

	display1.text = "  EXTRA BALL    "
	display2.text = "                "
      DisplayB2SText "  EXTRA BALL    " & "                "
	end if

	if ebs = 12 then

	hdisplay1.text = "   EXTRA BALL   "
	hdisplay2.text = "                "

	display1.text = "   EXTRA BALL   "
	display2.text = "                "
      DisplayB2SText "   EXTRA BALL   " & "                "
	end if

	if ebs = 13 then

	hdisplay1.text = "    EXTRA BALL  "
	hdisplay2.text = "                "

	display1.text = "    EXTRA BALL  "
	display2.text = "                "
      DisplayB2SText "    EXTRA BALL  " & "                "
	end if

	if ebs = 14 then

	hdisplay1.text = "     EXTRA BALL "
	hdisplay2.text = "                "

	display1.text = "     EXTRA BALL "
	display2.text = "                "
      DisplayB2SText2 "     EXTRA BALL " & "                "
	end if

	if ebs = 15 then

	hdisplay1.text = "      EXTRA BALL"
	hdisplay2.text = "                "

	display1.text = "      EXTRA BALL"
	display2.text = "                "
      DisplayB2SText2 "     EXTRA BALL " & "                "
	end if

	if ebs = 16 then

	hdisplay1.text = "       EXTRA BAL"
	hdisplay2.text = "                "

	display1.text = "       EXTRA BAL"
	display2.text = "                "
      DisplayB2SText "     EXTRA BAL  " & "                "
	end if

	if ebs = 17 then

	hdisplay1.text = "        EXTRA BA"
	hdisplay2.text = "                "

	display1.text = "        EXTRA BA"
	display2.text = "                "
      DisplayB2SText "     EXTRA BA   " & "                "
	end if

	if ebs = 18 then

	hdisplay1.text = "         EXTRA B"
	hdisplay2.text = "                "

	display1.text = "         EXTRA B"
	display2.text = "                "
      DisplayB2SText "     EXTRA B    " & "                "
	end if

	if ebs = 19 then

	hdisplay1.text = "          EXTRA "
	hdisplay2.text = "                "

	display1.text = "          EXTRA "
	display2.text = "                "
      DisplayB2SText "     EXTRA      " & "                "
	end if

	if ebs = 20 then

	hdisplay1.text = "           EXTRA"
	hdisplay2.text = "                "

	display1.text = "           EXTRA"
	display2.text = "                "
      DisplayB2SText "           EXTRA" & "                "
	end if

	if ebs = 21 then

	hdisplay1.text = "            EXTR"
	hdisplay2.text = "                "

	display1.text = "            EXTR"
	display2.text = "                "
      DisplayB2SText "            EXTR" & "                "
	end if

	if ebs = 22 then

	hdisplay1.text = "             EXT"
	hdisplay2.text = "                "

	display1.text = "             EXT"
	display2.text = "                "
      DisplayB2SText "             EXT" & "                "
	end if

	if ebs = 23 then

	hdisplay1.text = "              EX"
	hdisplay2.text = "                "

	display1.text = "              EX"
	display2.text = "                "
      DisplayB2SText "              EX" & "                "
	end if

	if ebs = 24 then

	hdisplay1.text = "               E"
	hdisplay2.text = "                "

	display1.text = "               E"
	display2.text = "                "
      DisplayB2SText "               E" & "                "
	end if

	if ebs = 25 then

	hdisplay1.text = "                "
	hdisplay2.text = "               E"

	display1.text = "                "
	display2.text = "               E"
      DisplayB2SText "               E" & "                "
	end if

	if ebs = 26 then

	hdisplay1.text = "                "
	hdisplay2.text = "              EX"

	display1.text = "                "
	display2.text = "              EX"
      DisplayB2SText "              EX" & "                "
	end if

	if ebs = 27 then

	hdisplay1.text = "                "
	hdisplay2.text = "             EXT"

	display1.text = "                "
	display2.text = "             EXT"
      DisplayB2SText "             EXT" & "                "
	end if

	if ebs = 28 then

	hdisplay1.text = "                "
	hdisplay2.text = "            EXTR"

	display1.text = "                "
	display2.text = "            EXTR"
      DisplayB2SText "            EXTR" & "                "
	end if

	if ebs = 29 then

	hdisplay1.text = "                "
	hdisplay2.text = "           EXTRA"

	display1.text = "                "
	display2.text = "           EXTRA"
      DisplayB2SText "           EXTRA" & "                "

	end if

	if ebs = 30 then

	hdisplay1.text = "                "
	hdisplay2.text = "          EXTRA "

	display1.text = "                "
	display2.text = "          EXTRA "
      DisplayB2SText "          EXTRA " & "                "

	end if

	if ebs = 31 then

	hdisplay1.text = "                "
	hdisplay2.text = "         EXTRA B"

	display1.text = "                "
	display2.text = "         EXTRA B"
      DisplayB2SText "         EXTRA B" & "                "
	end if

	if ebs = 32 then

	hdisplay1.text = "                "
	hdisplay2.text = "        EXTRA BA"

	display1.text = "                "
	display2.text = "        EXTRA BA"
      DisplayB2SText "        EXTRA BA" & "                "
	end if

	if ebs = 33 then

	hdisplay1.text = "                "
	hdisplay2.text = "       EXTRA BAL"

	display1.text = "                "
	display2.text = "       EXTRA BAL"
      DisplayB2SText "       EXTRA BAL" & "                "
	end if

	if ebs = 34 then

	hdisplay1.text = "                "
	hdisplay2.text = "      EXTRA BALL"

	display1.text = "                "
	display2.text = "      EXTRA BALL"
      DisplayB2SText "      EXTRA BALL" & "                "
	end if

	if ebs = 35 then

	hdisplay1.text = "                "
	hdisplay2.text = "     EXTRA BALL "

	display1.text = "                "
	display2.text = "     EXTRA BALL "
      DisplayB2SText "     EXTRA BALL " & "                "
	end if

	if ebs = 36 then

	hdisplay1.text = "                "
	hdisplay2.text = "    EXTRA BALL  "

	display1.text = "                "
	display2.text = "    EXTRA BALL  "
      DisplayB2SText "    EXTRA BALL  " & "                "
	end if

	if ebs = 37 then

	hdisplay1.text = "                "
	hdisplay2.text = "   EXTRA BALL   "

	display1.text = "                "
	display2.text = "   EXTRA BALL   "
      DisplayB2SText "   EXTRA BALL   " & "                "
	end if

	if ebs = 38 then

	hdisplay1.text = "                "
	hdisplay2.text = "  EXTRA BALL    "

	display1.text = "                "
	display2.text = "  EXTRA BALL    "
      DisplayB2SText "  EXTRA BALL    " & "                "
	end if

	if ebs = 39 then

	hdisplay1.text = "                "
	hdisplay2.text = " EXTRA BALL     "

	display1.text = "                "
	display2.text = " EXTRA BALL     "
      DisplayB2SText " EXTRA BALL     " & "                "
	end if

	if ebs = 40 then

	hdisplay1.text = "                "
	hdisplay2.text = "EXTRA BALL      "

	display1.text = "                "
	display2.text = "EXTRA BALL      "
      DisplayB2SText "EXTRA BALL      " & "                "
	end if

	if ebs = 41 then

	hdisplay1.text = "                "
	hdisplay2.text = "XTRA BALL       "

	display1.text = "                "
	display2.text = "XTRA BALL       "
      DisplayB2SText "XTRA BALL       " & "                "
	end if

	if ebs = 42 then

	hdisplay1.text = "                "
	hdisplay2.text = "TRA BALL        "

	display1.text = "                "
	display2.text = "TRA BALL        "
      DisplayB2SText "TRA BALL        " & "                "
	end if

	if ebs = 43 then

	hdisplay1.text = "                "
	hdisplay2.text = "RA BALL         "

	display1.text = "                "
	display2.text = "RA BALL         "
      DisplayB2SText "RA BALL         " & "                "
	end if

	if ebs = 44 then

	hdisplay1.text = "                "
	hdisplay2.text = "A BALL          "

	display1.text = "                "
	display2.text = "A BALL          "
      DisplayB2SText "A BALL          " & "                "
	end if

	if ebs = 45 then

	hdisplay1.text = "                "
	hdisplay2.text = "A BALL          "

	display1.text = "                "
	display2.text = "A BALL          "
      DisplayB2SText "A BALL          " & "                "
	end if

	if ebs = 46 then

	hdisplay1.text = "                "
	hdisplay2.text = " BALL           "

	display1.text = "                "
	display2.text = " BALL           "
      DisplayB2SText " BALL           " & "                "
	end if

	if ebs = 47 then

	hdisplay1.text = "                "
	hdisplay2.text = "BALL            "

	display1.text = "                "
	display2.text = "BALL            "
      DisplayB2SText "BALL            " & "                "
	end if

	if ebs = 48 then

	hdisplay1.text = "                "
	hdisplay2.text = "ALL             "

	display1.text = "                "
	display2.text = "ALL             "
      DisplayB2SText "ALL             " & "                "
	end if

	if ebs = 49 then

	hdisplay1.text = "                "
	hdisplay2.text = "LL              "

	display1.text = "                "
	display2.text = "LL              "
      DisplayB2SText "LL              " & "                "
	end if

	if ebs = 50 then

	hdisplay1.text = "                "
	hdisplay2.text = "L               "

	display1.text = "                "
	display2.text = "L               "
      DisplayB2SText "L               " & "                "
	end if


	if ebs = 51 then

	hdisplay1.text = "                "
	hdisplay2.text = "                "

	display1.text = "                "
	display2.text = "                "
      DisplayB2SText "                " & "                "
	end if


	if ebs = 52 then

	hdisplay1.text = "A               "
	hdisplay2.text = "A               "

	display1.text = "A               "
	display2.text = "A               "
      DisplayB2SText "A               " & "                "
	end if


	if ebs = 53 then

	hdisplay1.text = "RA              "
	hdisplay2.text = "RA              "

	display1.text = "RA              "
	display2.text = "RA              "
      DisplayB2SText "RA              " & "                "
	end if


	if ebs = 54 then

	hdisplay1.text = "TRA             "
	hdisplay2.text = "TRA             "

	display1.text = "TRA             "
	display2.text = "TRA             "
      DisplayB2SText "TRA             " & "                "
	end if


	if ebs = 55 then

	hdisplay1.text = "XTRA            "
	hdisplay2.text = "XTRA            "

	display1.text = "XTRA            "
	display2.text = "XTRA            "
      DisplayB2SText "XTRA            " & "                "
	end if


	if ebs = 56 then

	hdisplay1.text = "EXTRA           "
	hdisplay2.text = "EXTRA           "

	display1.text = "EXTRA           "
	display2.text = "EXTRA           "
      DisplayB2SText "EXTRA           " & "                "
	end if


	if ebs = 57 then

	hdisplay1.text = " EXTRA          "
	hdisplay2.text = " EXTRA          "

	display1.text = " EXTRA          "
	display2.text = " EXTRA          "
      DisplayB2SText "EXTRA          " & "                "
	end if


	if ebs = 58 then

	hdisplay1.text = "  EXTRA         "
	hdisplay2.text = "  EXTRA         "

	display1.text = "  EXTRA         "
	display2.text = "  EXTRA         "
      DisplayB2SText "  EXTRA         " & "                "
	end if


	if ebs = 59 then

	hdisplay1.text = "   EXTRA        "
	hdisplay2.text = "   EXTRA        "

	display1.text = "   EXTRA        "
	display2.text = "   EXTRA        "
      DisplayB2SText "   EXTRA        " & "                "
	end if

	if ebs = 60 then

	hdisplay1.text = "   EXTRA       B"
	hdisplay2.text = "   EXTRA       B"

	display1.text = "   EXTRA       B"
	display2.text = "   EXTRA       B"
      DisplayB2SText "   EXTRA       B" & "                "
	end if

	if ebs = 61 then

	hdisplay1.text = "   EXTRA      BA"
	hdisplay2.text = "   EXTRA      BA"

	display1.text = "   EXTRA      BA"
	display2.text = "   EXTRA      BA"
      DisplayB2SText "   EXTRA      BA" & "                "
	end if

	if ebs = 62 then

	hdisplay1.text = "   EXTRA     BAL"
	hdisplay2.text = "   EXTRA     BAL"

	display1.text = "   EXTRA     BAL"
	display2.text = "   EXTRA     BAL"
      DisplayB2SText "   EXTRA     BAL" & "                "
	end if

	if ebs = 63 then

	hdisplay1.text = "   EXTRA    BALL"
	hdisplay2.text = "   EXTRA    BALL"

	display1.text = "   EXTRA    BALL"
	display2.text = "   EXTRA    BALL"
      DisplayB2SText "   EXTRA    BALL" & "                "
	end if

	if ebs = 64 then

	hdisplay1.text = "   EXTRA   BALL "
	hdisplay2.text = "   EXTRA   BALL "

	display1.text = "   EXTRA   BALL "
	display2.text = "   EXTRA   BALL "
      DisplayB2SText "   EXTRA   BALL " & "                "
	end if

	if ebs = 65 then

	hdisplay1.text = "   EXTRA  BALL  "
	hdisplay2.text = "   EXTRA  BALL  "

	display1.text = "   EXTRA  BALL  "
	display2.text = "   EXTRA  BALL  "
      DisplayB2SText "   EXTRA  BALL  " & "                "
	end if

	if ebs = 66 then

	hdisplay1.text = "   EXTRA BALL   "
	hdisplay2.text = "   EXTRA BALL   "

	display1.text = "   EXTRA BALL   "
	display2.text = "   EXTRA BALL   "
      DisplayB2SText2 "   EXTRA BALL   " & "                "
	end if

	if ebs = 67 then

	'hdisplay1.slowblinkspeed = 30
	'hdisplay2.slowblinkspeed = 30

	hdisplay1.text = "   EXTRA BALL   "', seblink, 2000
	hdisplay2.text = "   EXTRA BALL   "', seblink, 2000

	'display1.slowblinkspeed = 30
	'display2.slowblinkspeed = 30

	display1.text = "   EXTRA BALL   "', seblink, 2000
	display2.text = "   EXTRA BALL   "', seblink, 2000
      DisplayB2SText2 "   EXTRA BALL   " & "                "
	end if

	if ebs = 120 then

	showinprogress = false

	end if

	if ebs = 121 then
	
	ebs = ebs - ebs
	ebstimer.enabled = false

	addscore(0)
    addclaw(0)
	end if

end sub

sub extraballshowtimer_Timer()

	trashcantimer.interval = 1000
	trashcantimer.enabled = true

    flashforms trashcanstrobe,1000, 40, bulboff 
	playsound "jycsfx60"', false, 0.8

	extraballshowtimer.enabled = false
	showinprogress = false

	extraballshowon = false

	'lookatplayfield()

	twinkle = 0
	twinkletimer.enabled = false

	if locklit = false then
        StopAllSounds
		song = 2
		playsong2()
	end if

	if locklit = true then
		song = 4
		playsong2()
	end if

end sub

dim randomspeechtrashcan
dim randomspeechlock
dim randomawardshowon


Sub TrashBLightTimer_Timer
    startB2S (33)
End Sub


sub randomaward()
    DMDUpdate.Enabled = 0
	statusspeechtimer.enabled = false
	showtimer.enabled = false
    TrashBLightTimer.Enabled = 1
	showinprogress = true
 	DOF 135, DOFOn
	randomawardshowon = true

	randomtimer.enabled = true
	'lookatbackbox()
	playsound "jyctrashcan"', false, 0.7
	'stopmusic 2
	'stopmusic 3
	'stopmusic 4
	'stopmusic 6
	'stopmusic 7
	'stopmusic 8

	mainseq2.stopplay()
	mainseq.updateinterval = 10
	mainseq.Play SeqMiddleOutHorizOn, 30, 1, 0
	mainseq.Play SeqMiddleOutHorizOn, 40, 1, 0
	mainseq.Play SeqMiddleOutHorizOn, 50, 1, 0
	mainseq.Play SeqMiddleOutHorizOn, 60, 1, 0
	mainseq.Play SeqMiddleOutHorizOn, 70, 1, 0
	mainseq.Play SeqMiddleOutHorizOn, 80, 1, 0
	mainseq.Play SeqMiddleOutHorizOn, 90, 1, 0


	ballsearchtimer.enabled = false
	ballsearchon = false

	randomspeechtrashcan = INT(RND(1)*2)+1

	if randomspeechtrashcan = 1 then

		playsound "spchletsseewhatwegot"', false, 0.8


	end if

	if randomspeechtrashcan = 2 then

		playsound "spchgimme"', false, 0.9


	end if

	'hdisplay1.flushqueue()
	'hdisplay2.flushqueue()

	hdisplay1.text = " CHAINSHAW AWARD "
	hdisplay2.text = "                "

	'display1.flushqueue()
	'display2.flushqueue()

	display1.text = " CHAINSHAW AWARD "
	display2.text = "                "

      DisplayB2SText " CHAINSHAW AWARD " & "                "

end sub

dim random
dim awardcode

sub randomtimer_Timer()
    DMDUpdate.Enabled = 0
	random = random + 1
	DOF 135, DOFOff

	If random = 10 then

	hdisplay1.text = " CHAINSHAW AWARD "
	hdisplay2.text = " ADVANCE BONUS X"

	display1.text = " CHAINSHAW AWARD "
	display2.text = " ADVANCE BONUS X"
      DisplayB2SText " CHAINSHAW AWARD " & " ADVANCE BONUS X"
	playsound "jycsfx14"', false, 0.2

	end if

	If random = 11 then

	hdisplay1.text = " CHAINSHAW AWARD "
	hdisplay2.text = " LIGHT KICKBACK "

	display1.text = " CHAINSHAW AWARD "
	display2.text = " LIGHT KICKBACK "
      DisplayB2SText " CHAINSHAW AWARD " & " LIGHT KICKBACK "
	playsound "jycsfx14b"', false, 0.2

	end if
	If random = 12 then

	hdisplay1.text = " CHAINSHAW AWARD "
	hdisplay2.text = "  ADVANCE  CAT  "

	display1.text = " CHAINSHAW AWARD "
	display2.text = "  ADVANCE  CAT  "
      DisplayB2SText " CHAINSHAW AWARD " & "  ADVANCE  CAT  "
	playsound "jycsfx14"', false, 0.3

	end if
	If random = 14 then

	hdisplay1.text = " CHAINSHAW AWARD "
	hdisplay2.text = "   EXTRA BALL   "

	display1.text = " CHAINSHAW AWARD "
	display2.text = "   EXTRA BALL   "
      DisplayB2SText " CHAINSHAW AWARD " & "   EXTRA BALL   "
	playsound "jycsfx14b"', false, 0.3

	end if
	If random = 17 then

	hdisplay1.text = " CHAINSHAW AWARD "
	hdisplay2.text = "    SPECIAL     "

	display1.text = " CHAINSHAW AWARD "
	display2.text = "    SPECIAL     "
      DisplayB2SText " CHAINSHAW AWARD " & "    SPECIAL     "
	playsound "jycsfx14"', false, 0.4

	end if
	If random = 21 then

	hdisplay1.text = " CHAINSHAW AWARD "
	hdisplay2.text = "QUICK  MULTIBALL"

	display1.text = " CHAINSHAW AWARD "
	display2.text = "QUICK  MULTIBALL"
      DisplayB2SText " CHAINSHAW AWARD " & "QUICK  MULTIBALL"
	playsound "jycsfx14b"', false, 0.5

	end if
	If random = 26 then

	hdisplay1.text = " CHAINSHAW AWARD "
	hdisplay2.text = "     300000     "

	display1.text = " CHAINSHAW AWARD "
	display2.text = "     300000     "
      DisplayB2SText " CHAINSHAW AWARD " & "     300000     "
	playsound "jycsfx14"', false, 0.5

	end if
	If random = 32 then

	hdisplay1.text = " CHAINSHAW AWARD "
	hdisplay2.text = " ADVANCE BONUS X"

	display1.text = " CHAINSHAW AWARD "
	display2.text = " ADVANCE BONUS X"
      DisplayB2SText " CHAINSHAW AWARD " & " ADVANCE BONUS X"
	playsound "jycsfx14b"', false, 0.6

	end if
	If random = 39 then

	hdisplay1.text = " CHAINSHAW AWARD "
	hdisplay2.text = "   EXTRA BALL   "

	display1.text = " CHAINSHAW AWARD "
	display2.text = "   EXTRA BALL   "
      DisplayB2SText " CHAINSHAW AWARD " & "   EXTRA BALL   "
	playsound "jycsfx14"',' false, 0.6

	end if
	If random = 47 then

	awardcode = INT(RND(1)*100)+1

	hdisplay1.text = " CHAINSHAW AWARD "
	display1.text = " CHAINSHAW AWARD "
      DisplayB2SText " CHAINSHAW AWARD " & " CHAINSHAW AWARD "
	showaward()

	end if

end sub

sub showaward()
    DMDUpdate.Enabled = 0

	if (awardcode > 0) and (awardcode < 11) then

		if locklit = false then

			hdisplay2.text = "   ADVANCE ASH  "', seblink, 3000
			display2.text = "   ADVANCE ASH  "', seblink, 3000
            DisplayB2SText "   ADVANCE ASH  " & "   ADVANCE ASH  "
			endrandomtimer.interval = 3000

			playsound "jycsfx36"', false, 0.6

		else

			hdisplay2.text = "     100000     "', seblink, 3000
			display2.text = "     100000     "', seblink, 3000
            DisplayB2SText "     100000     " & "     100000     "
			endrandomtimer.interval = 3000

			playsound "jycsfx36"', false, 0.6

		end if

	end if

	if (awardcode > 10) and (awardcode < 21) then

		if bonusx < 5 then

			hdisplay2.text = "ADVANCE BONUS X "', seblink, 3000
			display2.text = "ADVANCE BONUS X "', seblink, 3000
            DisplayB2SText "ADVANCE BONUS X " & "ADVANCE BONUS X "
			endrandomtimer.interval = 3000

			playsound "jycsfx36"', false, 0.6

		else

			hdisplay2.text = "  ADVANCE BOOK  "', seblink, 3000
			display2.text = "  ADVANCE BOOK  "', seblink, 3000
            DisplayB2SText "  ADVANCE BOOK  " & "  ADVANCE BOOK  "
			endrandomtimer.interval = 3000

			playsound "jycsfx36"', false, 0.6

		end if

	end if

	if (awardcode > 20) and (awardcode < 31) then

		If superjets = false then

			hdisplay2.text = "LIGHT SUPER BOOMSTICK"', seblink, 3000
			display2.text = "LIGHT SUPER BOOMSTICK"', seblink, 3000
            DisplayB2SText "  ADVANCE BOOK  " & "                "
			endrandomtimer.interval = 3000

			playsound "jycsfx36"', false, 0.6

		else

			hdisplay2.text = "     100000     "', seblink, 3000
			display2.text = "     100000     "', seblink, 3000
            DisplayB2SText "     100000     " & "                "
			endrandomtimer.interval = 3000

			playsound "jycsfx36"', false, 0.6

		end if

	end if

	if (awardcode > 30) and (awardcode < 41) then

		If letters < 8 then

			hdisplay2.text = "ADVANCE TIME TRAVEL"', seblink, 3000
			display2.text = "ADVANCE TIME TRAVEL"', seblink, 3000
            DisplayB2SText "ADVANCE TIME TRAVEL" & "                "
			endrandomtimer.interval = 3000

			playsound "jycsfx36"', false, 0.6

		else

			hdisplay2.text = "     200000     "', seblink, 3000
			display2.text = "     200000     "', seblink, 3000
            DisplayB2SText "     200000     " & "                "
			endrandomtimer.interval = 3000

			playsound "jycsfx36"', false, 0.6

		end if

	end if

	if (awardcode > 40) and (awardcode < 51) then

		If kickbacklit = false then

			hdisplay2.text = " LIGHT KICKBACK "', seblink, 3000
			display2.text = " LIGHT KICKBACK "', seblink, 3000
            DisplayB2SText " LIGHT KICKBACK " & "                "
			endrandomtimer.interval = 3000

			playsound "jycsfx36"', false, 0.6

		else

			hdisplay2.text = "     100000     "', seblink, 3000
			display2.text = "     100000     "', seblink, 3000
            DisplayB2SText "     100000     " & "                "
			endrandomtimer.interval = 3000

			playsound "jycsfx36"', false, 0.6

		end if

	end if

	if (awardcode > 50) and (awardcode < 61) then

	hdisplay2.text = "  ADVANCE BOOK  "', seblink, 3000
	display2.text = "  ADVANCE BOOK  "', seblink, 3000
    DisplayB2SText "  ADVANCE BOOK  " & "                "
	endrandomtimer.interval = 3000

	playsound "jycsfx36"', false, 0.6

	end if

	if (awardcode > 60) and (awardcode < 71) then

	hdisplay2.text = "     300000     "', seblink, 3000
	display2.text = "     300000     "', seblink, 3000
            DisplayB2SText "     300000     " & "                "
	endrandomtimer.interval = 3000

	playsound "jycsfx36"', false, 0.6

	end if

	if (awardcode > 70) and (awardcode < 81) then

	hdisplay2.text = "     200000     "', seblink, 3000
	display2.text = "     200000     "', seblink, 3000
    DisplayB2SText "     200000     " & "                "
	endrandomtimer.interval = 3000

	playsound "jycsfx36"', false, 0.6

	end if

	if (awardcode > 80) and (awardcode < 91) then

	hdisplay2.text = "NOTHING BUT BONE"', seblink, 3000
	display2.text = "NOTHING BUT BONE"', seblink, 3000
    DisplayB2SText "NOTHING BUT BONE" & "                "
	endrandomtimer.interval = 3000

	playsound "jycsfx57"', false, 0.8

	end if

	if (awardcode > 90) and (awardcode < 97) then

	hdisplay2.text = "QUICK MULTIBALL "', seblink, 3000
	display2.text = "QUICK MULTIBALL "', seblink, 3000
    DisplayB2SText "QUICK MULTIBALL " & "                "
	endrandomtimer.interval = 3000

	playsound "jycsfx22"', false, 0.9

	end if

	if (awardcode = 97) or (awardcode = 98) then

		if extraballsscored < 3 then

			if extraballs = 0 then

				'hdisplay1.flushqueue()
				'hdisplay2.flushqueue()

				'display1.flushqueue()
				''display2.flushqueue()

				ebstimer.enabled = true

				playsound "jycextraball"', false, 0.8
				playsound "spchcomeinhandy"', false, 0.9, 3250

				extraballs = extraballs + 1
				extraballsscored = extraballsscored + 1
				shootagainlight.state = 1
				checkextraballs()

				endrandomtimer.interval = 4000

			else

				hdisplay2.text = "     300000     "', seblink, 3000
				display2.text = "     300000     "', seblink, 3000
                DisplayB2SText "     300000     " & "                "
				endrandomtimer.interval = 3000

				playsound "jycsfx36"', false, 0.6

			end if

		else

			hdisplay2.text = "     300000     "', seblink, 3000
			display2.text = "     300000     "', seblink, 3000
            DisplayB2SText "     300000     " & "                "
			endrandomtimer.interval = 3000

			playsound "jycsfx36"', false, 0.6

		end if

	end if

	if (awardcode = 99) or (awardcode = 100) then

		if extraballsscored < 3 then

			if extraballs = 0 then

				playsound "fx_knocker"

				extraballs = extraballs + 1
				extraballsscored = extraballsscored + 1
				shootagainlight.state = 1
				checkextraballs()

				endrandomtimer.interval = 5000

				playsound "jycspecial"', false, 0.9
				playsound "spchmeow"', false, 0.8, 4000

				'hdisplay1.flushqueue()
				'hdisplay2.flushqueue()

				'display1.flushqueue()
				'display2.flushqueue()

				showinprogress = true
			
				rds = 0

				replaydisplayshowtimer.enabled = true

			else

				hdisplay2.text = "     300000     "', seblink, 3000
				display2.text = "     300000     "', seblink, 3000
                DisplayB2SText "     300000     " & "                "
				endrandomtimer.interval = 3000

				playsound "jycsfx36"', false, 0.6

			end if

		else

			hdisplay2.text = "     300000     "', seblink, 3000
			display2.text = "     300000     "', seblink, 3000
            DisplayB2SText "     300000     " & "                "
			endrandomtimer.interval = 3000

			playsound "jycsfx36"', false, 0.6

		end if

	end if
    DMDUpdate.interval = 3000
    DMDUpdate.Enabled = 1
	endrandomtimer.enabled = true

end sub

sub endrandomtimer_Timer()

	endrandomtimer.enabled = false

	endrandom()

end sub

sub endrandom()
    TrashBLightTimer.Enabled = 0
  If B2SOn Then
    Controller.B2SSetData 25,1
  End If
	trashcantimer.interval = 1500
	trashcantimer.enabled = true

	'lookatplayfield()

		if locklit = true then
            StopAllSounds
			song = 4 
			PlaySong "mu_jyclocklit"', True, 0.7, 500

		else
            StopAllSounds
			song = 2 
			PlaySong "mu_jycmaintheme"', True, 0.7, 500

		end if

	randomtimer.enabled = false
	trashcanlit = false
	randomawardlight.state = 0
	random = random - random
	showinprogress = false

	DoAward()

end sub

sub DoAward()

if (awardcode > 0) and (awardcode < 11) then

		if locklit = false then

			advancecats()

		else

			addscore(100000)

		end if

	end if

	if (awardcode > 10) and (awardcode < 21) then

		if bonusx < 5 then

			advancex()

		else

			advanceclaw()

		end if

	end if

	if (awardcode > 20) and (awardcode < 31) then

		If superjets = false then
		
			startsuperjets()
			addscore(0)

		else

			addscore(100000)

		end if

	end if

	if (awardcode > 30) and (awardcode < 41) then

		If letters < 8 then
		
			letters = letters + 1
			nvR1 = nvR1 + 1
			addbonuspoints(1000)

			showletters()
			checkblackout()

		else

			addscore(200000)

			Playsound "spchgoodasgold"', false, 0.9, 100

		end if

	end if

	if (awardcode > 40) and (awardcode < 51) then

		If kickbacklit = false then

			lightkickback()
			lightkickbackshow()

		else

			addscore(100000)

		end if

	end if

	if (awardcode > 50) and (awardcode < 61) then

		advanceclaw()

	end if

	if (awardcode > 60) and (awardcode < 71) then

		addscore(300000)

		playsound "spchgoodasgold"', false, 0.9, 100

	end if

	if (awardcode > 70) and (awardcode < 81) then

		addscore(200000)

		playsound "spchgoodasgold"', false, 0.9, 100

	end if

	if (awardcode > 80) and (awardcode < 91) then

		addscore(0)

	end if

	if (awardcode > 90) and (awardcode < 97) then

		quickmultiballlit = true
		startquickmultiball()

	end if

	if (awardcode = 97) or (awardcode = 98) then

		if extraballsscored < 3 then

			if extraballs = 0 then

				addscore(0)

			else

				addscore(300000)

			end if

		else

			addscore(300000)

		end if

	end if

	if (awardcode = 99) or (awardcode = 100) then

		if extraballsscored < 3 then

			if extraballs = 0 then

				addscore(0)

			else

				addscore(300000)

			end if

		else

			addscore(300000)

		end if

	end if

	addbonuspoints(1000)
	randomawardshowon = false
    DMDUpdate.interval = 3000
    DMDUpdate.Enabled = 1
end sub

sub trashcantimer_Timer()
	trashcansolenoidpulse
	trashcantimer.enabled = false
	ballintrashcan = false

if (blackout = false) and (tilted = false) then

	playsound "jycsfx33"', False, 0.5

end if

end sub

Sub trashcansolenoidpulse
    startB2S (25)
    trashcan.kick 177, 20
End Sub

dim rightloop
dim leftloop
dim royloop

dim noswitchhit

dim ward
dim axel
dim roy
dim jenkins
dim scarla

sub leftlooptrigger_hit()
    DMDUpdate.Enabled = 0
	If leftloop = false then
	leftloop = true
	leftlooptimer.enabled = true
	end if

	If leftdiverteropen = true then
	divertersafety()
	end if
	
end sub

sub leftlooptimer_Timer()
    DMDUpdate.interval = 2000
    DMDUpdate.Enabled = 1
	leftlooptimer.enabled = false
	leftloop = false
end sub

sub roylooptrigger_hit()
    DMDUpdate.Enabled = 0
	If royloop = false then
	royloop = true
	roylooptimer.enabled = true
	end if
	
end sub

sub roylooptimer_Timer()
    DMDUpdate.interval = 2000
    DMDUpdate.Enabled = 1
	roylooptimer.enabled = false
	royloop = false
end sub

sub rightlooptrigger_hit()
    DMDUpdate.Enabled = 0
	If rightloop = false then
	rightloop = true
	rightlooptimer.enabled = true
	end if
	
	If rightdiverteropen = true then
	divertersafety()
	end if

	

	if (noswitchhit = true) and (blackout = false) and (tilted = false) then

		es = 0
		entryshowtimer.enabled = true

	end if

	if (balljustsaved = true) and (tilted = false) then

		es = 0
		entryshowtimer.enabled = true

		Playsound "jycsfx37"', false, 0.5

	end if

end sub

sub rightlooptimer_Timer()
    DMDUpdate.interval = 2000
    DMDUpdate.Enabled = 1
	rightlooptimer.enabled = false
	rightloop = false
end sub

dim es

sub entryshowtimer_Timer()

	es = es + 1

	if es = 1 then

		flashforms strobe9, 1000, 50, 0

	end if

	if es = 2 then

		flashforms strobe8, 1000, 50, 0

	end if

	if es = 3 then

		flashforms strobe7, 1000, 50, 0

	end if

	if es = 4 then

		flashforms strobe8, 1000, 50, 0

	end if

	if es = 5 then

		flashforms strobe8, 1000, 50, 0

	end if

	if es = 6 then

		flashforms strobe7, 1000, 50, 0

	end if

	if es = 7 then
		
	es = 0
	entryshowtimer.enabled = false

	end if

end sub


sub leftgate_hit()

end sub

sub leftloopopto_hit()
    Playsound "fx_gate"
	if leftloop = true then
	awardleftloop()
	end if

	if royloop = true then
	awardroyloop()
	end if

end sub

sub rightgate_hit()

end sub

sub rightloopopto_hit()
    Playsound "fx_gate"
	if noswitchhit = false then

		if rightloop = true then
		awardrightloop()
		end if

	end if

end sub

sub awardleftloop()
	
	leftloop = false
	leftlooptimer.enabled = false

if (blackout = false) and (tilted = false) then

	if ward = false then
	spotward()
	
	else

	addscore(15000)

	if faded = false then

	playsound "jycsfx37"', false, 0.5
	giquickflicker()

	flashforms strobe5, 1000, 40, bulboff

	end if

	end if

end if

end sub

sub awardroyloop()
	
	royloop = false
	roylooptimer.enabled = false

if (blackout = false) and (tilted = false) then

	if roy = false then

	spotroy()

	else
		
	AddScore(20000)

	if faded = false then

	playsound "jycsfx49"', false, 1.0
	giquickflicker()

	flashforms strobe4, 1000, 40, bulboff
	flashforms strobe5, 1000, 40, bulboff

	end if

	end if

end if

end sub

sub awardrightloop()
	
	rightloop = false
	rightlooptimer.enabled = false

if (blackout = false) and (tilted = false) then

	if balljustsaved = false then

		if scarla = false then

			spotscarla()

		else

			AddScore(15000)
	
			if faded = false then

				playsound "jycsfx37"', false, 0.5
				giquickflicker()

				es = 0
				entryshowtimer.enabled = true

			end if

		end if

	end if

end if

end sub

sub vturnramptrigger_hit

if (blackout = false) and (tilted = false) then

	Switch()

	if (quickmultiballon = true) or ((multiballon = true) and (jackpotscored = true) and (lightjackpotlit = false) and (twomillionlit = false)) then

	multiballrampshow()
	triplerampvalue()

		if jackpotshowon = false then

			playsound "spchgoodasgold"', false, 0.9, 2000
			fadedelay.interval = 1000
			fadedelay.enabled = true

		end if

	else

		if (axel = true) and (quickmultiballon = false) and (twomillionlit = false) then

			if faded = false then

			playsound "jycsfx21"', false, 0.4
			playsound "jycsfx53"', false, 0.8

			end if

			doublerampvalue()

		end if

		if (multiballon = false) and (quickmultiballon = false) and (multiballrestart = false) then

			MainSeq2.updateinterval = 15
			MainSeq2.Play SeqLeftOn, 50

		end if

	end if

	If ((multiballon = false) and (multiballrestart = false) and (blackout = false) and (quickmultiballlit = true) and (quickmultiballon = false)) then

		startquickmultiball()

	end if

	if twomillionlit = true then

		scoretwomillion()

	end if

	spotaxel()
	advanceramp()
	addbonuspoints(1000)

else

	if tilted = false then

		if blackoutjackpot = false then

			if blackoutmain = false then

				if blackoutvturn = false then

					blackoutvturn = true
					jackpot1light.state = bulbon

					playsound "jycsfx14"', false, 1.0

				end if
	
			else

				lightblackoutjackpot()

			end if

		else

			scoreblackoutjackpot()

		end if

	end if

end if

end sub

Sub vturnramptrigger_Hunhit
    PlaySound "fx_metalrolling", 0, 1, pan(ActiveBall)
End Sub



dim ramp

sub mainramptrigger_hit
DMDUpdate.Enabled = 0
if (blackout = false) and (tilted = false) then

	Switch()

	if (quickmultiballon = true) or ((multiballon = true) and (jackpotscored = true) and (lightjackpotlit = false) and (twomillionlit = false)) then

	multiballrampshow()
	doublerampvalue()

		if jackpotshowon = false then

			Playsound "spchyeahthatsit"', false, 0.9, 2000
			fadedelay.interval = 1000
			fadedelay.enabled = true

		end if

	else

		if (jenkins = true) and (quickmultiballon = false) and (millionlit = false) then

			if faded = false then

			Playsound "jycsfx50"', false, 0.5

			end if

			rampvalue()

		end if

		if faded = false and millionlit = false then
	
			Playsound "jycsfx21"', false, 0.7

		end if

	end if

	if millionlit = true then

		scoremillion()

	end if

	spotjenkins()
	advanceramp()
	addbonuspoints(1000)

	if (multiballon = false) and (quickmultiballon = false) and (multiballrestart = false) then

		MainSeq2.updateinterval = 15
		MainSeq2.Play SeqRightOn, 50

	end if

else

	if tilted = false then

		if blackoutjackpot = false then

			if blackoutvturn = false then
	
				if blackoutmain = false then

					blackoutmain = true
					jackpot2light.state = bulbon

					Playsound "jycsfx14"', false, 1.0

				end if
	
			else

				lightblackoutjackpot()

			end if

		else

			scoreblackoutjackpot()

		end if

	end if

end if

DMDUpdate.interval = 2000
DMDUpdate.Enabled = 1
end sub

dim blackoutmain
dim blackoutvturn
dim blackoutjackpot

sub lightblackoutjackpot()

	blackoutjackpot = true

	'song = 11
	'playsong2()
    playsong "mu_jychurryup"
	Playsound "spchspotted"', false, 1.0
	Playsound "jycsfx24"', false, 0.8

	blackoutjackpottimer.enabled = true

	hus = hus - hus
	hurryupshowtimer.enabled = true

		jackpot2light.State = bulbblink
		axelshotlight.State = bulbblink
		quickmultiballlight.State = bulbblink

		jackpot1light.State = bulbblink
		jenkinsshotlight.State = bulbblink
		jackpot2light.State = bulbblink
		axelshotlight.State = bulbblink
		quickmultiballlight.State = bulbblink

end sub

sub blackoutjackpottimer_Timer()

	blackoutjackpottimer.enabled = false
	Playsound "jychurryuplost"', false, 0.7

	endblackoutmiss()

end sub

dim blackoutjackpotscored

sub scoreblackoutjackpot()

	blackoutjackpottimer.enabled = false
	restartmusictimer.enabled = true

	blackoutjackpotscored = true

	Playsound "jycjackpot"', false, 1.0, 1000
	Playsound "spchfree"', false, 1.0

	jackpotvalue = 3
	jackpotshow()

	endblackoutwin()

end sub

sub restartmusictimer_Timer()

	restartmusictimer.enabled = false

	if ((ballsonplayfield > 0) and (ballslocked = 0)) or ((ballsonplayfield > 1) and (ballslocked = 1)) then
	
		If ballslocked <> 2 then

			If locklit = false then
                StopAllSounds
				song = 2
				playsong2()
				musicstarted = true
			end if

			If locklit = true then
                StopAllSounds
				song = 4
				playsong2()
				musicstarted = true
			end if

		End if

	end if

end sub

sub advanceramp ()
	
	ramp = ramp + 1

	if ramp = 2 then

	value1.state = bulbon
	value2.state = bulbon

	end if

	if ramp = 3 then

	value2.state = bulbon
	value3.state = bulbon

	end if

	if ramp = 4 then

	value3.state = bulbon
	value4.state = bulbon

	end if

	if ramp = 5 then

	value1.state = bulbblink
	value2.state = bulbblink
	value3.state = bulbblink
	value4.state = bulbblink
	value5.state = bulbblink

	lighttrashcan()

	end if

	if ramp > 5 then

		ramp = 1

		value1.state = bulbon
		value2.state = bulboff
		value3.state = bulboff
		value4.state = bulboff
		value5.state = bulboff

	end if

end sub

sub resetvaluelights()

	ramp = 1

	value1.State = Bulbon', "10", 200
	value2.State = bulboff' "10", 200
	value3.State = bulboff', "10", 200
	value4.State = bulboff', "10", 200
	value5.State = bulboff', "10", 200

end sub

sub scoremillion()

	jackpotvalue = 1
	jackpotshow()
	jackpot1light.state = bulbon
	jackpot2light.state = bulboff

	addscore(1000000)

end sub

sub scoretwomillion()

	jackpotvalue = 2
	jackpotshow()
	jackpot1light.state = bulbon
	jackpot2light.state = bulbon

	addscore(2000000)

end sub

sub killjackpotshow()

	jackpotshowon = false
	showinprogress = false

	jackpotshowtimer.enabled = false
	
	jps = 0
   jps2 = 0
	jpstimer.enabled = false

	twinklesides = false
	twinkletimer.interval = 100
	twinkletimer.enabled = false

	jptshowtimer.enabled = false

	mainseq.stopplay()

	if ballintrashcan = true then

		trashcantimer.enabled = true

	end if

end sub

dim jackpotshowon

sub jackpotshow()

	hurryupshowtimer.enabled = false
	hus = hus - hus

	jackpotshowon = true
	showinprogress = true

	jackpotscored = true
	Playsound "jycjackpot"', false, 1.0, 1000
	Playsound "spchfree"', false, 1.0
	Playsound "jycsfx21"', false, 0.7
	faded = true
	'stopmusic 4
    StopSound "mu_jyclocklit"
	jackpotshowtimer.enabled = true
	jackpottimer.enabled = false
	millionlit = false
	twomillionlit = false
	lightjackpotlit = false

	resetdiverters()
	diverterlight.state = 0

	mainseq.updateinterval = 5
   mainseq.play SeqBlinking, , 38, 30 
   mainseq.play SeqBlinking, , 4, 150
   mainseq.play SeqBlinking, , 7, 75
   mainseq.play SeqBlinking, , 35, 30
	
   jps = 0
   jps2 = 0
	jpstimer.enabled = true

	axelshotlight.state = bulbon
	jenkinsshotlight.state = bulbon
	quickmultiballlight.state = bulboff

	randomawardlight.state = bulboff
	checkextraballs()
	lightjackpotlight.state = bulboff

	twinklesides = false
	twinkletimer.interval = 100
	twinkletimer.enabled = true

	jptshowtimer.enabled = true

	endmultiballstrobes()

end sub

sub jackpotshowtimer_Timer()

	jackpotshowtimer.enabled = false

	if ballintrashcan = true then

	trashcantimer.interval = 1000
	trashcantimer.enabled = true

	FlashForMs trashcanstrobe, 1000, 40, bulboff

	playsound "jycsfx60"', false, 0.8

	end if

	if lockballonhold = true then

	lockballshow()

	else
	
		if multiballon = true then
            StopAllSounds
			song = 5
			playsong2()
	
		else
            StopAllSounds
			song = 2
			playsong2()

		end if

	end if

	jackpotshowon = false
	faded = false
	showinprogress = false

end sub

dim twinkle
dim twinklesides

sub quicktwinkle()

	if (multiballon = false) and (quickmultiballon = false) and (multiballrestart = false) then

		twinkle = 0 
		quicktwinkletimer.interval = 1000
		quicktwinkletimer.enabled = true
		twinkletimer.enabled = true
		twinklesides = false

	end if

end sub

sub quicktwinkletimer_Timer()

	twinkle = 0 
	quicktwinkletimer.enabled = false
	twinkletimer.enabled = false

end sub

sub twinkletimer_Timer()

	twinkle = twinkle + 1

	if twinklesides = false then

		if twinkle = 1 then

			flashforms strobe1, 500, 50, 0 
			flashforms strobe3, 500, 50, 0
 			flashforms strobe5, 500, 50, 0
 			flashforms strobe7, 500, 50, 0
			flashforms strobe9, 500, 50, 0  


		end if

		if twinkle = 2 then

			flashforms strobe2, 500, 50, 0 
			flashforms strobe4, 500, 50, 0
 			flashforms strobe6, 500, 50, 0
 			flashforms strobe8, 500, 50, 0
			flashforms strobe10, 500, 50, 0


		twinkle = twinkle - twinkle

		end if

	else

		if twinkle = 1 then

			flashforms strobe1, 500, 50, 0 
			flashforms strobe2, 500, 50, 0
 			flashforms strobe3, 500, 50, 0
 			flashforms strobe4, 500, 50, 0
			flashforms strobe5, 500, 50, 0

		end if

		if twinkle = 2 then

			flashforms strobe6, 500, 50, 0 
			flashforms strobe7, 500, 50, 0
 			flashforms strobe8, 500, 50, 0
 			flashforms strobe9, 500, 50, 0
			flashforms strobe10, 500, 50, 0

		twinkle = twinkle - twinkle

		end if

	end if

end sub

dim jpt

sub jptshowtimer_Timer()

	jpt = jpt + 1 

	if jpt = 32 then

	twinklesides = true
	twinkletimer.interval = 300

	end if

	if jpt = 45 then

	twinkletimer.interval = 150

	end if

	if jpt = 57 then

	twinklesides = false
	twinkletimer.interval = 100

	end if

	if jpt = 80 then

		if multiballon = true then

		startmultiballstrobes()

		end if

	twinkletimer.enabled = false
	jptshowtimer.enabled = false
	jpt = jpt - jpt

	end if

end sub

dim multiballstrobes

sub startmultiballstrobes()

	multiballstrobes = true

	leftstrobesup()
	rightstrobesdown()

end sub

sub endmultiballstrobes()

	multiballstrobes = false

	lstrobes = 0
	rstrobes = 0
	lstrobestimer.enabled = false
	rstrobestimer.enabled = false

end sub

sub spotward()
	if ward = false then
	ward = true
  if B2SOn Then
    Controller.B2SSetData 9, 1
  End If
	wardlight.state=bulbon
	wardshotlight.state = bulbon
	checkcats()
	playsound "jycsfx48"', false, 0.9

	catshow()

	'hdisplay1.flushqueue()
	'hdisplay2.flushqueue()

	'hdisplay1.slowblinkspeed = 30
	hdisplay1.text = "   LORD ARTHUR   "', sescrollrightover
	hdisplay2.text = " JOINS THE CATS "', sescrollleftover, 3000
	hdisplay1.text = "   LORD ARTHUR   "', seblinkmask, 3000

	'display1.flushqueue()
'	display2.flushqueue()

	'display1.slowblinkspeed = 30
	display1.text = "   LORD ARTHUR   "', sescrollrightover
	display2.text = " JOINS ASH "', sescrollleftover, 3000
	display1.text = "   LORD ARTHUR   "', seblinkmask, 3000
     DisplayB2SText2 "   LORD ARTHUR   " & " JOINS ASH "
	addscore(50000)
	addbonuspoints(1000)
	end if
end sub

sub spotaxel()
	if axel = false then
	axel = true
  If B2SOn Then
    Controller.B2SSetData 10, 1
  End If
	axellight.state=bulbon
	axelshotlight.state = bulbon
	checkcats()
	playsound "jycsfx53"', false, 0.8

	catshow()

	'hdisplay1.flushqueue()
	'hdisplay2.flushqueue()

	'hdisplay1.slowblinkspeed = 30
	hdisplay1.text = "      LINDA      "', sescrollrightover
	hdisplay2.text = " JOINS ASH "', sescrollleftover, 3000
	hdisplay1.text = "      LINDA      "', seblinkmask, 3000

	'display1.flushqueue()
	'display2.flushqueue()

	'display1.slowblinkspeed = 30
	display1.text = "      LINDA      "', sescrollrightover
	display2.text = " JOINS ASH "', sescrollleftover, 3000
	display1.text = "      LINDA      "', seblinkmask, 3000
     DisplayB2SText2 "      LINDA      " & " JOINS THE LINDA "
	addscore(50000)
	addbonuspoints(1000)
	end if
end sub

sub spotroy()
	if roy = false then
	roy = true
  If B2SOn Then
    Controller.B2SSetData 11, 1
  End If
	roylight.state=bulbon
	royshotlight.state = bulbon
	checkcats()
	playsound "jycsfx49"', false, 1.0

	catshow()

	'hdisplay1.flushqueue()
	'hdisplay2.flushqueue()

	'hdisplay1.slowblinkspeed = 30
	hdisplay1.text = "       SHEILA      "', sescrollrightover
	hdisplay2.text = " JOINS ASH "', sescrollleftover, 3000
	hdisplay1.text = "       SHEILA      "', seblinkmask, 3000

	'display1.flushqueue()
	'display2.flushqueue()

	'display1.slowblinkspeed = 30
	display1.text = "       SHEILA      "', sescrollrightover
	display2.text = " JOINS ASH "', sescrollleftover, 3000
	display1.text = "       SHEILA      "', seblinkmask, 3000
     DisplayB2SText2 "       SHEILA      " & " JOINS ASH "
	addscore(50000)
	addbonuspoints(1000)
	end if
end sub

sub spotjenkins()
	if jenkins = false then
	jenkins = true
  If B2SOn Then
    Controller.B2SSetData 12, 1
  End If
	jenkinslight.state=bulbon
	jenkinsshotlight.state = bulbon
	checkcats()
	playsound "jycsfx50"', false, 0.8

	catshow()

	'hdisplay1.flushqueue()
	'hdisplay2.flushqueue()

	'hdisplay1.slowblinkspeed = 30
	hdisplay1.text = "     IAN    "', sescrollrightover
	hdisplay2.text = " JOINS ASH "', sescrollleftover, 3000
	hdisplay1.text = "     IAN    "', seblinkmask, 3000

	'display1.flushqueue()
	'display2.flushqueue()

	'display1.slowblinkspeed = 30
	display1.text = "     IAN    "', sescrollrightover
	display2.text = " JOINS ASH "', sescrollleftover, 3000
	display1.text = "     IAN    "', seblinkmask, 3000
     DisplayB2SText2 "     IAN    " & " JOINS ASH "
	addscore(50000)
	addbonuspoints(1000)
	end if
end sub

sub spotscarla()
	if scarla = false then
	scarla = true
  If B2SOn Then
    Controller.B2SSetData 13, 1
  End If
	scarlalight.state=1
	scarlashotlight.state = 1
	checkcats()
	playsound "jycsfx52"', false, 0.8

	catshow()

	'hdisplay1.flushqueue()
	'hdisplay2.flushqueue()

	'hdisplay1.slowblinkspeed = 30
	hdisplay1.text = "     PATRICIA     "', sescrollrightover
	hdisplay2.text = " JOINS ASH "', sescrollleftover, 3000
	hdisplay1.text = "     PATRICIA     "', seblinkmask, 3000

	'display1.flushqueue()
	'display2.flushqueue()

	'display1.slowblinkspeed = 30
	display1.text = "     PATRICIA     "', sescrollrightover
	display2.text = " JOINS ASH "', sescrollleftover, 3000
	display1.text = "     PATRICIA     "', seblinkmask, 3000
     DisplayB2SText2 "     PATRICIA     " & " JOINS ASH "
	addscore(50000)
	addbonuspoints(1000)
	end if
end sub

sub catshow()

	showinprogress = true
	showtimer.interval = 3000
	showtimer.enabled = true

	giquickflicker()
	quicktwinkle()

end sub

sub checkcats()

	checkcatstimer.enabled = true

end sub

sub checkcatstimer_Timer()

	checkcatstimer.enabled = false

	if (ward = true) and (axel = true) and (roy = true) and (jenkins = true) and (scarla = true) and (locklit = false) then
	lightlock()
	end if

end sub

dim locklit
dim locklitonhold
dim lockshow

sub lightlock()

if (blackout = false) and (tilted = false) then

	statusspeechtimer.enabled = false
	delayletterstimer.enabled = false

	if quickmultiballon = false then

		locklit = true
		song = 4

		if musicstarted = true then

			playsong2()

		end if

		lock1light.state = bulbblink
		lock2light.state = bulbblink
		rightdiverter.RotateToEnd
		leftdiverter.RotateToEnd
		leftdiverteropen = true
		rightdiverteropen = true

		lockshow = true

	'	hdisplay1.flushqueue()
	'	hdisplay2.flushqueue()

	'	hdisplay1.slowblinkspeed = 30
		'hdisplay2.slowblinkspeed = 30

		hdisplay1.text = "  LOCK IS LIT   "', sescrollout, 100
		hdisplay2.text = "                "', sescrollout, 4000
		hdisplay1.text = "  LOCK IS LIT   "', seblinkmask, 3900
    
		'display1.flushqueue()
		'display2.flushqueue()

		'display1.slowblinkspeed = 30
		'display2.slowblinkspeed = 30

		display1.text = "  LOCK IS LIT   "', sescrollout, 100
		display2.text = "                "', sescrollout, 4000
		display1.text = "  LOCK IS LIT   "', seblinkmask, 3900
        DisplayB2SText2 "  LOCK IS LIT   " & "                "
		showinprogress = true
		showtimer.interval = 4000
		showtimer.enabled = true

		randomspeechlock = INT(RND(1)*2)+1

		If randomspeechlock = 1 then

			playsound "spchlockislit1"', false, 0.9, 1000

		end if

		If randomspeechlock = 2 then

			playsound "spchlockislit2"', false, 0.9, 1000

		end if
	
		fadedelay.interval = 1000
		fadedelay.enabled = true
		playsound "jycsfx2"', false, 0.6

		wardlight.State =    BulbBlink', "100000000011", 75
		axellight.State =    BulbBlink', "010000000100", 75
		roylight.State =     BulbBlink', "001000001000", 75
		jenkinslight.State = BulbBlink', "000100010000", 75
		scarlalight.State =  BulbBlink', "000011100000", 75

		giquickflicker()

	else

		locklitonhold = true

	end if

	addscore(50000)

end if

end sub

sub leftlock_hit()

if (blackout = false) and (tilted = false) then

	if multiballrestart = false then

		if locklit = false then

			leftlocktimer.enabled = true

		else

			if (locklit = true) and (ballinleftlock = false) then

				lockleftball()

			end if

		end if

	end if

	If multiballrestart = true then

		mballrestart = true
		restartmultiball()

		addscore(100000)

	end if

	If multiballon = true then

		if (showinprogress = false) and (mballrestart = false) then

			leftlocksolenoidpulse

			if ((matchon = false) and (blackout = false) and (faded = false)) then

				playsound "jycsfx28"', False, 0.4

			end if
	
		end if

	end if

else

leftlocktimer.enabled = true

end if

end sub


sub leftlocksolenoidpulse()
    leftlock.Kick 0, 35, 1.5
    playsound "fx_vukout_LAH"
end Sub

Sub leftlock_Unhit
    playsound "fx_metalrolling"
End Sub


sub leftlocktimer_Timer()

	leftlocktimer.enabled = false
	leftlocksolenoidpulse

	if ((matchon = false) and (blackout = false) and (faded = false) and (tilted = false)) then

		playsound "jycsfx28"', False, 0.4

	end if

end sub

sub rightlock_hit()

if (blackout = false) and (tilted = false) then

	Switch()
	'rightlock.destroyball
    'rightlocksolenoidpulse
	if multiballrestart = false then

		if locklit = false then

			Ballsinscoop = Ballsinscoop + 1
			'scooptimer.enabled = true
             rightlocksolenoidpulse
			flashforms strobe6, 1000, 40, 0
			playsound "jycsfx60"', false, 1.0

		else

			if ((locklit = true) and (ballinrightlock = false)) then
	
				lockrightball()	

			else

				Ballsinscoop = Ballsinscoop + 1
				'scooptimer.enabled = true
                flashforms strobe6, 1000, 40, 0
				playsound "jycsfx60"', false, 1.0
                rightlocksolenoidpulse
			end if
		
		end if

	end if

	if multiballrestart = true then

		mballrestart = true
		restartmultiball()
		Ballsinscoop = Ballsinscoop + 1
		addscore(100000)

	end if

else

ballsinscoop = ballsinscoop + 1
scooptimer.enabled = true

end if

end sub

Sub Rightlocksolenoidpulse()
    rightlock1.enabled = 1
    scoop.enabled = 0
    scoop1.enabled = 0
    scoop2Timer.interval = 800
    scoop2Timer.enabled = True 
End Sub

Sub scoop2Timer_Timer
    scoop2Timer.enabled = False
    PlaySound "subway2"
    rightlock.kick 235, 10
End Sub 

Sub rightlock1_Hit
    PlaySound "salidadebola"
    rightlock1.enabled = 0
    rightlock1.kick 0, 20, 1.5
    scoop1Timer.interval = 800
    scoop1Timer.enabled = True
End Sub

dim ballinleftlock
dim ballinrightlock
dim multiballon
dim multiballrestart
dim ballslocked

sub lockleftball()
	
	ballslocked = ballslocked + 1
	ballinleftlock = true
	resetdiverters()
	lock1light.state = bulbon
	checklock()

end sub

sub lockrightball()

	ballslocked = ballslocked + 1
	ballinrightlock = true
	resetdiverters()
	lock2light.state = bulbon
	checklock()

end sub

dim lockballonhold

sub checklock()

	ballsearchtimer.enabled = false

	if jackpotshowon = true then

		lockballonhold = true

	else

		lockballshow()

	end if

end sub

sub rightdivertersafetytimer_Timer()

	rightdivertersafetytimer.enabled = false
	resetdiverters()

end sub

sub ballsearchtimer_Timer()

	ballsearchon = true
	
	ballsearch()
	ballsearchtimer.interval = 7500

end sub

sub ballsearch()
    DMDUpdate.Enabled = 0
	divertersafety()

if ((blackout = false) and (multiballrestart = false) and (tilted = false)) then

	hdisplay1.text = "  BALL SEARCH   "
	hdisplay2.text = "  BALL SEARCH   "

	display1.text = "  BALL SEARCH   "
	display2.text = "  BALL SEARCH   "
     DisplayB2SText2 "  BALL SEARCH   " & "                "
end if

end sub

sub divertersafety()

	if rightdiverteropen = false then

		rightdiverter.rotatetoend
                Playsound "DiverterOn"
        Rightlocksolenoidpulse
        rightlock1.Enabled = 0
        scoopsolenoidpulse
	else

		rightdiverter.rotatetostart
                Playsound "DiverterOff"
        rightlock1.Enabled = 0
        scoopsolenoidpulse
	end if

	if leftdiverteropen = false then

		leftdiverter.rotatetoend
                Playsound "DiverterOn"
   
	else

		leftdiverter.rotatetostart
                Playsound "DiverterOff"
        leftlocksolenoidpulse
	end if

	divertersafetytimer.enabled = true

end sub


sub divertersafetytimer_Timer()

	divertersafetytimer.enabled = false
	resetdiverters()

end sub

sub resetdiverters()

if (blackout = false) and (tilted = false) then

	if multiballrestart = false then

		if twomillionlit = false then

			if locklit = false then

				leftdiverter.RotateToStart
				rightdiverter.RotateToStart
                Playsound "DiverterOff"
				leftdiverteropen = false
				rightdiverteropen = false

			else

				if ballinleftlock = true then

					leftdiverter.RotateToStart
					leftdiverteropen = false
                Playsound "DiverterOff"
				else

					leftdiverter.RotateToEnd
					leftdiverteropen = true
                Playsound "DiverterOn"
				end if

				if ballinrightlock = true then

					rightdiverter.RotateToStart
					rightdiverteropen = false
                Playsound "DiverterOff"
				else

					rightdiverter.RotateToEnd
					rightdiverteropen = true
                Playsound "DiverterOn"
				end if

			end if

		else

			rightdiverter.RotateToEnd
			rightdiverteropen = true

			leftdiverter.RotateToStart
			leftdiverteropen = false
                Playsound "DiverterOff"
		end if

	else

	leftdiverter.RotateToEnd
	leftdiverteropen = true

	rightdiverter.RotateToEnd
	rightdiverteropen = true
                Playsound "DiverterOn"
	end if

else

	rightdiverter.RotateToStart
	rightdiverteropen = false

	leftdiverter.RotateToStart
	leftdiverteropen = false
                Playsound "DiverterOff"
end if

end sub

sub autolaunchball()

	plungerkicker.createball
	plungerkicker.kick 90, 8
	autolaunch = true
	Ballsonplayfield = ballsonplayfield + 1
	Ballsindrain = Ballsindrain - 1

	ballindrain = false

    vpmtimer.addtimer 1000, "plungerIM.AutoFire '" 

end sub

dim multiballsaver
dim millionlit
dim twomillionlit
dim lightjackpotlit
dim multiballshowon

sub startmultiball()

	multiballreleasetimer.enabled = true
	'lookatbackbox()

	multiballshowon = true
	showinprogress = true

	endballsave()

	song = 5
	playsound "jycmultiballstart"', false, 0.8

	giflicker()

	mballstart = true
	atexttimer.enabled = true

	multiballs = 2
	multiballon = true

	wardlight.State = bulbon
	axellight.State = bulbon
	roylight.State = bulbon
	jenkinslight.State = bulbon
	scarlalight.State = bulbon

	quickmultiballlight.state = bulboff
	randomawardlight.state = bulboff

	lightjackpotlight.State = bulbblink', "10", 150
	extraballlight.State =    bulbblink', "10", 150
	randomawardlight.State =  bulbblink', "10", 150

	lightjackpotlit = true

	'mainseq.play seqalloff

	addscore(100000)

end sub

sub multiballreleasetimer_Timer()

	Ballsinscoop = Ballsinscoop + 1
	scooptimer.enabled = true
	leftlocktimer.enabled = true
    rightlocksolenoidpulse()
	autolaunchball()
	multiballsavertimer.enabled = true

	'lookatplayfield()
	multiballreleasetimer.enabled = false

	multiballshowon = false
	showinprogress = false

	playsound "jycsfx62"', false, 0.4

	TurnGIon()

	startmultiballstrobes()

	'mainseq.stopplay()
	'BGGI.stopplay()

end sub

sub multiballsavertimer_Timer()

	if multiballs > 0 then

		autolaunchball()
		multiballs = multiballs - 1

	else

	multiballsavertimer.enabled = false

	end if

end sub

sub multiballsavercutoff_Timer()

	multiballsaver = false
	multiballsavercutoff.enabled = false
	multiballsavertimer.enabled = false
	ShootAgainLight.state = 0

end sub

dim multiballplayed
dim jackpotscored

sub endmultiball()

	multiballplayed = true
	multiballon = false
   lightjackpotlit = false
	jackpottimer.enabled = false

	endmultiballstrobes()

	if ((millionlit = true) or (twomillionlit = true)) then

	trashcantimer.interval = 1000
	trashcantimer.enabled = true

	flashforms trashcanstrobe, 1000, 40, 0

	millionlit = false
	twomillionlit = false

	diverterlight.state = 0
	resetdiverters()

	'stopmusic 4
    StopSound "mu_jycrestartmultiball"

	hurryupshowtimer.enabled = false
	showinprogress = false
	hus = hus - hus

	end if

	jackpot1light.state = bulboff
	jackpot2light.state = bulboff
	jenkinsshotlight.state = bulbon
	axelshotlight.state = bulbon
	quickmultiballlight.state = bulboff

	lightjackpotlight.state = bulboff
	randomawardlight.state = bulboff

	checkextraballs()

	if ((jackpotscored = false) and (restartmultiballscored = false)) then

	startrestartmultiball()

	else

	ingamereset()

	end if

end sub

dim randomspeechrestart

sub startrestartmultiball()
	'stopmusic 1
    StopAllSounds
	song = 6
	playsong2()
	playsound "jycsfx41"', false, 0.7
	multiballrestart = true
	leftdiverter.RotateToEnd
	rightdiverter.RotateToEnd
    Playsound "DiverterOn"
	leftdiverteropen = true
	rightdiverteropen = true
	restartmultiballtimer.enabled = true
	timer.enabled = true
	time = 30

	showinprogress = true

	'hdisplay1.flushqueue()
	'hdisplay2.flushqueue()

	'hdisplay1.slowblinkspeed = 30
	'hdisplay2.slowblinkspeed = 30

		hdisplay1.text = "    RESTART     "', seblink, 2000
		hdisplay2.text = "   MULTIBALL    "', seblink, 2000

	'display1.flushqueue()
	'display2.flushqueue()

	'display1.slowblinkspeed = 30
	'display2.slowblinkspeed = 30

		display1.text = "    RESTART     "', seblink, 2000
		display2.text = "   MULTIBALL    "', seblink, 2000
     DisplayB2SText2 "    RESTART     " & "   MULTIBALL    "
	lock1light.state = bulbblink
	lock2light.state = bulbblink

	randomspeechrestart = INT(RND(1)*2)+1

	if randomspeechrestart = 1 then

		playsound "spchnotgivingup"', false, 0.8, 2500
		fadedelay.interval = 2500
		fadedelay.enabled = true

	end if

	if randomspeechrestart = 2 then

		playsound "spchnotoveryet"', false, 0.8, 2500
		fadedelay.interval = 2500
		fadedelay.enabled = true

	end if

end sub

dim time

sub timer_Timer()

	time = time - 1

	if (multiballrestart = true) then

		if time = 27 then

		'hdisplay1.flushqueue()
		'hdisplay2.flushqueue()

		'hdisplay1.slowblinkspeed = 150
		'hdisplay2.slowblinkspeed = 150

		hdisplay1.text = "SHOOT BALL LOCKS"', seBlink, 30000
		hdisplay2.text = "    TIME " & time
		'hdisplay2.flushqueue()

		'display1.flushqueue()
		'display2.flushqueue()

		'display1.slowblinkspeed = 150
		'display2.slowblinkspeed = 150

		display1.text = "SHOOT BALL LOCKS"', seBlink, 30000
		display2.text = "    TIME " & time
		'display2.flushqueue()
        DMDUpdate.Enabled = 0
     DisplayB2SText2 "SHOOT BALL LOCKS" & "    TIME " & time

		end if

		if time < 27 then

		hdisplay2.text = "    TIME " & time
		display2.text = "    TIME " & time
		playsound "jycsfx12"', false, 0.5
        DMDUpdate.Enabled = 0
    ' DisplayB2SText  "    TIME " & time & "                "
     DisplayB2SText "SHOOT BALL LOCKS" & "    TIME " & time
		end if

	end if

	if time = 0 then

		'hdisplay1.flushqueue()
		'hdisplay2.flushqueue()

		'display1.flushqueue()
		'display2.flushqueue()
		
		timer.enabled = false
		showinprogress = false

	end if

end sub

sub lightjackpot()

	'song = 11
	'playsong2()

	lightjackpotlit = false

	playsound "spchspotted", false, 1.0
	playsound "jycsfx24", false, 0.8

	randomawardlight.state = bulbon
	extraballlight.state = bulbon
	lightjackpotlight.state = bulbon

	jackpottimer.enabled = true

	hurryupshowtimer.enabled = true

	if jackpotscored = true then

		twomillionlit = true
		jackpot2light.State =       bulbblink', "10", 150
		axelshotlight.State =       bulbblink', "10", 150
		quickmultiballlight.State = bulbblink', "10", 150
		

	else

		millionlit = true
		twomillionlit = true
		jackpot1light.State = 		bulbblink', "10", 150
		jenkinsshotlight.State =    bulbblink', "10", 150
		jackpot2light.State =       bulbblink', "10", 150
		axelshotlight.State =       bulbblink', "10", 150
		quickmultiballlight.State = bulbblink', "10", 150

	end if

	resetdiverters()
	diverterlight.state = 1

end sub

dim hus

sub hurryupshowtimer_Timer()

	hus = hus + 1

	'hdisplay1.flushqueue()
	'hdisplay2.flushqueue()

	'display1.flushqueue()
	'display2.flushqueue()

	showinprogress = true

	if ((millionlit = true) and (twomillionlit = true)) or (blackout = true) then

		if hus = 1 then

			'hdisplay1.slowblinkspeed = 30
			'hdisplay2.slowblinkspeed = 30

			hdisplay1.text = "SHOOT THE RAMPS "', seblink, 300
			hdisplay2.text = "                "', seblink, 300

			'display1.slowblinkspeed = 30
			'display2.slowblinkspeed = 30

			display1.text = "SHOOT THE RAMPS "', seblink, 300
			display2.text = "                "', seblink, 300
            DisplayB2SText2 "SHOOT THE RAMPS " & "                "
		end if

		if hus = 2 then

			hdisplay1.text = "                "', seblink, 300
			hdisplay2.text = "SHOOT THE RAMPS "', seblink, 300

			display1.text = "                "', seblink, 300
			display2.text = "SHOOT THE RAMPS "', seblink, 300
            DisplayB2SText2 "                " & "SHOOT THE RAMPS "
		end if

		if hus = 3 then

			hdisplay1.text = "SHOOT THE RAMPS "', seblink, 300
			hdisplay2.text = "                "', seblink, 300

			display1.text = "SHOOT THE RAMPS "', seblink, 300
			display2.text = "                "', seblink, 300
            DisplayB2SText2 "SHOOT THE RAMPS " & "                "
		end if

		if hus = 4 then

			hdisplay1.text = "                "', seblink, 300
			hdisplay2.text = "SHOOT THE RAMPS "', seblink, 300

			display1.text = "                "', seblink, 300
			display2.text = "SHOOT THE RAMPS "', seblink, 300
            DisplayB2SText2 "                " & "SHOOT THE RAMPS "
		end if

		if hus = 5 then

			hdisplay1.text = "ESCAPE          "', seblink, 300
			hdisplay2.text = "NOW             "', seblink, 300

			display1.text = "ESCAPE          "', seblink, 300
			display2.text = "NOW             "', seblink, 300
            DisplayB2SText2 "ESCAPE          " & "NOW             "

		end if

		if hus = 6 then

			hdisplay1.text = "          ESCAPE"', seblink, 300
			hdisplay2.text = "             NOW"', seblink, 300

			display1.text = "          ESCAPE"', seblink, 300
			display2.text = "             NOW"', seblink, 300
            DisplayB2SText2 "          ESCAPE" & "             NOW"
		end if

		if hus = 7 then

			hdisplay1.text = "ESCAPE          "', seblink, 300
			hdisplay2.text = "NOW             "', seblink, 300

			display1.text = "ESCAPE          "', seblink, 300
			display2.text = "NOW             "', seblink, 300
            DisplayB2SText2 "ESCAPE          " & "NOW             "
		end if

		if hus = 8 then

			hdisplay1.text = "          ESCAPE"', seblink, 300
			hdisplay2.text = "             NOW"', seblink, 300

			display1.text = "          ESCAPE"', seblink, 300
			display2.text = "             NOW"', seblink, 300
            DisplayB2SText2 "          ESCAPE" & "             NOW"
			hus = hus - hus

		end if
	
	end if

	if ((millionlit = false) and (twomillionlit = true)) and (blackout = false) then

		if hus = 1 then

			'hdisplay1.slowblinkspeed = 30
			'hdisplay2.slowblinkspeed = 30

			hdisplay1.text = "SHOOT LEFT RAMP "', seblink, 300
			hdisplay2.text = "                "', seblink, 300

			'display1.slowblinkspeed = 30
			'display2.slowblinkspeed = 30

			display1.text = "SHOOT LEFT RAMP "', seblink, 300
			display2.text = "                "', seblink, 300
            DisplayB2SText2 "SHOOT LEFT RAMP " & "                "
		end if

		if hus = 2 then

			hdisplay1.text = "                "', seblink, 300
			hdisplay2.text = "SHOOT LEFT RAMP "', seblink, 300

			display1.text = "                "', seblink, 300
			display2.text = "SHOOT LEFT RAMP "', seblink, 300
            DisplayB2SText2 "                " & "SHOOT LEFT RAMP "
		end if

		if hus = 3 then

			hdisplay1.text = "SHOOT LEFT RAMP "', seblink, 300
			hdisplay2.text = "                "', seblink, 300

			display1.text = "SHOOT LEFT RAMP "', seblink, 300
			display2.text = "                "', seblink, 300
            DisplayB2SText2 "SHOOT LEFT RAMP " & "                "
		end if

		if hus = 4 then

			hdisplay1.text = "                "', seblink, 300
			hdisplay2.text = "SHOOT LEFT RAMP "', seblink, 300

			display1.text = "                "', seblink, 300
			display2.text = "SHOOT LEFT RAMP "', seblink, 300
          DisplayB2SText2 "                " & "SHOOT LEFT RAMP "
		end if

		if hus = 5 then

			hdisplay1.text = "ESCAPE          "', seblink, 300
			hdisplay2.text = "NOW             "', seblink, 300

			display1.text = "ESCAPE          "', seblink, 300
			display2.text = "NOW             "', seblink, 300
          DisplayB2SText2 "ESCAPE          " & "NOW             "
		end if

		if hus = 6 then

			hdisplay1.text = "          ESCAPE"', seblink, 300
			hdisplay2.text = "             NOW"', seblink, 300

			display1.text = "          ESCAPE"', seblink, 300
			display2.text = "             NOW"', seblink, 300
          DisplayB2SText2 "          ESCAPE" & "             NOW"
		end if

		if hus = 7 then

			hdisplay1.text = "ESCAPE          "', seblink, 300
			hdisplay2.text = "NOW             "', seblink, 300

			display1.text = "ESCAPE          "', seblink, 300
			display2.text = "NOW             "', seblink, 300
          DisplayB2SText "ESCAPE          " & "NOW             "
		end if

		if hus = 8 then

			hdisplay1.text = "          ESCAPE"', seblink, 300
			hdisplay2.text = "             NOW"', seblink, 300

			display1.text = "          ESCAPE"', seblink, 300
			display2.text = "             NOW"', seblink, 300
          DisplayB2SText2 "          ESCAPE" & "             NOW"
			hus = hus - hus

		end if
	
	end if


end sub

sub jackpottimer_Timer()

	jackpottimer.enabled = false
	missjackpot()

end sub

sub missjackpot()

	song = 5
	playsong2()

	millionlit = false
	twomillionlit = false

	playsound "SPCHclosecall", false, 0.8
	fademusic()

	jackpot1light.state = bulboff
	jackpot2light.state = bulboff
	jenkinsshotlight.state = bulbon
	axelshotlight.state = bulbon
	quickmultiballlight.state = bulboff

	lightjackpotlight.State = bulbblink', "10", 150
	extraballlight.State =    bulbblink', "10", 150
	randomawardlight.State =  bulbblink', "10", 150

	lightjackpotlit = true

	trashcantimer.interval = 1000
	trashcantimer.enabled = true

    flashforms trashcanstrobe,1000, 40, bulboff 


	hurryupshowtimer.enabled = false
	showinprogress = false
	hus = hus - hus

	resetdiverters()
	diverterlight.state = 0

	addscore(0)

end sub

sub restartmultiballtimer_Timer()

	endrestartmultiball()

end sub

sub endrestartmultiball()
	
	multiballrestart = false
	leftdiverter.RotateToStart
	rightdiverter.RotateToStart
    Playsound "DiverterOff"
	leftdiverteropen = false
	rightdiverteropen = false
	restartmultiballtimer.enabled = false
	ingamereset()

	timer.enabled = false
	time = 0

	showinprogress = false

	'hdisplay1.flushqueue()
	'hdisplay2.flushqueue()

	'display1.flushqueue()
	'display2.flushqueue()

	addscore(0)

end sub

dim restartmultiballscored
dim multiballs

sub restartmultiball()

	restartmultiballscored = true
	multiballrestart = false

	'stopmusic 1
    StopSound "mu_jycmainshooter"
	playsound "SPCHlightscameraaction"', false, 0.8

	multiballshowon = true

	'mainseq.play seqalloff
	turnGIoff()

	mballrestart = true
	atexttimer.enabled = true

	'lookatbackbox()

	restartmultiballtimer.enabled = false

	leftdiverter.RotateToStart
	rightdiverter.RotateToStart
    Playsound "DiverterOff"
	leftdiverteropen = false
	rightdiverteropen = false
	lock1light.state = bulbon
	lock2light.state = bulbon

	multiballon = true

	lightjackpotlight.State = bulbblink', "10", 150
	extraballlight.State =    bulbblink', "10", 150
	randomawardlight.State =  bulbblink', "10", 150

	lightjackpotlit = true

	timer.enabled = false
	time = 0

	showinprogress = false

	'hdisplay1.flushqueue()
	'hdisplay2.flushqueue()

	'display1.flushqueue()
	'display2.flushqueue()

	addscore(0)

end sub

sub releasemultiballs()

end sub 

dim jackpotvalue
dim congrats
dim jps
dim jps2

sub jpstimer_Timer()

	jps = jps + 1
	showinprogress = true

	if jackpotvalue = 1 then

		if jps = 1 then

		jpstimer.interval = 100

		'hdisplay1.flushqueue()
		'hdisplay2.flushqueue()

		'hdisplay1.slowblinkspeed = 30
		'hdisplay2.slowblinkspeed = 30

		hdisplay1.text = "    JACKPOT     "', seblink, 1700
		hdisplay2.text = "    JACKPOT     "', seblink, 1700

		'display1.flushqueue()
		'display2.flushqueue()

		'display1.slowblinkspeed = 30
		'display2.slowblinkspeed = 30

		display1.text = "    JACKPOT     "', seblink, 1700
		display2.text = "    JACKPOT     "', seblink, 1700
          DisplayB2SText2 "    JACKPOT     " & "                "
		end if

		if jps = 15 then

		jpstimer.interval = 50

		hdisplay1.text = "1000000         "
		hdisplay2.text = "         1000000"

		display1.text = "1000000         "
		display2.text = "         1000000"
          DisplayB2SText "    JACKPOT     " & "         1000000"
		end if

		if jps = 16 then

		hdisplay1.text = "         1000000"
		hdisplay2.text = "1000000         "

		display1.text = "         1000000"
		display2.text = "1000000         "
          DisplayB2SText2 "    JACKPOT     " & "1000000         "
		jps2 = jps2 + 1

			if jps2 < 35 then

				jps = jps - 2

			else

				jps = jps + 1
				jps2 = jps2 - jps2

			end if

		end if

		if jps = 18 then

			jpstimer.interval = 100
			hdisplay1.text = "1000000  1000000"', seblink, 3000
			hdisplay2.text = "1000000  1000000"', seblink, 3000

			display1.text = "1000000  1000000"', seblink, 3000
			display2.text = "1000000  1000000"', seblink, 3000
          DisplayB2SText2 "    JACKPOT     " & "         1000000"     
		end if

		if jps = 24 then

		jpstimer.enabled = false
		jps = 0
		jps2 = 0

		end if
	
	end if

	if jackpotvalue = 2 then

		if jps = 1 then

		jpstimer.interval = 100

		'hdisplay1.flushqueue()
		'hdisplay2.flushqueue()

		'hdisplay1.slowblinkspeed = 30
		'hdisplay2.slowblinkspeed = 30

		hdisplay1.text = " DOUBLE JACKPOT "', seblink, 1700
		hdisplay2.text = " DOUBLE JACKPOT "', seblink, 1700

		'display1.flushqueue()
		'display2.flushqueue()

		'display1.slowblinkspeed = 30
		'display2.slowblinkspeed = 30

		display1.text = " DOUBLE JACKPOT "', seblink, 1700
		display2.text = " DOUBLE JACKPOT "', seblink, 1700
              DisplayB2SText " DOUBLE JACKPOT " & "2000000         "
		end if

		if jps = 15 then

		jpstimer.interval = 50

		hdisplay1.text = "2000000         "
		hdisplay2.text = "         2000000"

		display1.text = "2000000         "
		display2.text = "         2000000"
              DisplayB2SText " DOUBLE JACKPOT " & "         2000000"
		end if

		if jps = 16 then

		hdisplay1.text = "         2000000"
		hdisplay2.text = "2000000         "

		display1.text = "         2000000"
		display2.text = "2000000         "
              DisplayB2SText " DOUBLE JACKPOT " & "2000000         "
		jps2 = jps2 + 1

			if jps2 < 35 then

				jps = jps - 2

			else

				jps = jps + 1
				jps2 = jps2 - jps2

			end if

		end if

		if jps = 18 then

			jpstimer.interval = 100
			hdisplay1.text = "2000000  2000000"', seblink, 3000
			hdisplay2.text = "2000000  2000000"', seblink, 3000

			display1.text = "2000000  2000000"', seblink, 3000
			display2.text = "2000000  2000000"', seblink, 3000
              DisplayB2SText2 " DOUBLE JACKPOT " & "         2000000"
		end if

		if jps = 24 then

		jpstimer.enabled = false
		jps = 0
		jps2 = 0

		end if
	
	end if

	if jackpotvalue = 3 then

		if jps = 1 then

		jpstimer.interval = 100

		'hdisplay1.flushqueue()
		'hdisplay2.flushqueue()

		'hdisplay1.slowblinkspeed = 30
		'hdisplay2.slowblinkspeed = 30

		hdisplay1.text = " TRIPLE JACKPOT "', seblink, 1700
		hdisplay2.text = " TRIPLE JACKPOT "', seblink, 1700

		'display1.flushqueue()
		'display2.flushqueue()

		'display1.slowblinkspeed = 30
		'display2.slowblinkspeed = 30

		display1.text = " TRIPLE JACKPOT "', seblink, 1700
		display2.text = " TRIPLE JACKPOT "', seblink, 1700
              DisplayB2SText2 " TRIPLE JACKPOT " & "3000000         "
		end if

		if jps = 15 then

		jpstimer.interval = 50

		hdisplay1.text = "3000000         "
		hdisplay2.text = "         3000000"

		display1.text = "3000000         "
		display2.text = "         3000000"
              DisplayB2SText " TRIPLE JACKPOT " & "         3000000"
		end if

		if jps = 16 then

		hdisplay1.text = "         3000000"
		hdisplay2.text = "3000000         "

		display1.text = "         3000000"
		display2.text = "3000000         "
              DisplayB2SText2 " TRIPLE JACKPOT " & "3000000         "
		jps2 = jps2 + 1

			if jps2 < 35 then

				jps = jps - 2

			else

				jps = jps + 1
				jps2 = jps2 - jps2

			end if

		end if

		if jps = 18 then

			jpstimer.interval = 100
			hdisplay1.text = "3000000  3000000"', seblink, 3000
			hdisplay2.text = "3000000  3000000"', seblink, 3000

			display1.text = "3000000  3000000"', seblink, 3000
			display2.text = "3000000  3000000"', seblink, 3000
              DisplayB2SText2 " TRIPLE JACKPOT " & "         3000000"
		end if

		if jps = 24 then

		jpstimer.enabled = false
		jps = 0
		jps2 = 0

		end if
	
	end if

end sub

sub ingamereset()

	if musicstarted = true then

		if jackpotshowon = false then

				'stopmusic 1
                StopAllSounds
                'playsong2
				song = 2 
                playsong2
				'playsound "jycsfx41"', false, 0.7
				'playsound "jycmaintheme"', True, 0.7, 1500

				catscampleft = false
				catscamper()

				if jackpotscored = false then
				playsound "spchbacktothedrawingboard"', false, 0.9, 2000
				fadedelay.interval = 2000
				fadedelay.enabled = true

				else
	
				if congrats = false and blackoutjackpotscored = false then

					playsound "spchnicework"', false, 0.7, 2000
					fadedelay.interval = 2000
					fadedelay.enabled = true

					congrats = true

				end if

				end if

		end if

	end if

	ward = false: 'Controller.B2SSetData 9, 0
	axel = false: 'Controller.B2SSetData 10, 0
	roy = false: 'Controller.B2SSetData 11, 0
	jenkins = false: 'Controller.B2SSetData 12, 0
	scarla = false: 'Controller.B2SSetData 13, 0
	resetlocklights()
	locklit = false
	ballinleftlock = false
	ballinrightlock = false
	multiballrestart = false
	ballslocked = ballslocked - ballslocked
	restartmultiballscored = false
	resetdiverters()

	if quickmultiballlit = true then

		quickmultiballlight.State = 2', "10", 200

	end if

	if trashcanlit = true then

		randomawardlight.state = bulbon

	end if

end sub

sub resetlocklights()

if tilted = false then

	lock1light.state = 0
	lock2light.state = 0
	wardlight.state = 0
	axellight.state = 0
	roylight.state = 0
	jenkinslight.state = 0
	scarlalight.state = 0
	wardshotlight.State =    2', "10", 200
	royshotlight.State =     2', "10", 200
	axelshotlight.State =    2', "10", 200
	jenkinsshotlight.State = 2', "10", 200
	scarlashotlight.State =  2', "10", 200
	lock1light.state = 0
	lock2light.state = 0

else

	lock1light.state = 0
	lock2light.state = 0
	wardlight.state = 0
	axellight.state = 0
	roylight.state = 0
	jenkinslight.state = 0
	scarlalight.state = 0
	wardshotlight.State =    0', "10", 200
	royshotlight.State =     0', "10", 200
	axelshotlight.State =    0', "10", 200
	jenkinsshotlight.State = 0', "10", 200
	scarlashotlight.State =  0', "10", 200
	lock1light.state = 0
	lock2light.state = 0

end if

end sub

sub Jtarget_hit()
	Switch()

if (blackout = false) and (tilted = false) then

	Jlight.state = bulbon
	checktargetstimer.enabled = true

	flashforms strobe1,100, 100, 0

	if faded = false then

	playSound "jycsfx31"', false, 0.4

	end if

	addscore(1000)

end if

end sub

sub Utarget_hit()
	Switch()

if (blackout = false) and (tilted = false) then

	Ulight.state = bulbon
	checktargetstimer.enabled = true

	flashforms strobe1,100, 100, 0

	if faded = false then

	playSound "jycsfx31"', false, 0.4

	end if

	addscore(1000)

end if

end sub

sub Ntarget_hit()
	Switch()

if (blackout = false) and (tilted = false) then

	Nlight.state = bulbon
	checktargetstimer.enabled = true

	flashforms strobe1,100, 100, 0

	if faded = false then

	playSound "jycsfx31"', false, 0.4

	end if

	addscore(1000)

end if

end sub

sub Ktarget_hit()
	Switch()

if (blackout = false) and (tilted = false) then

	Klight.state = bulbon
	checktargetstimer.enabled = true

	flashforms strobe1,100, 100, 0

	if faded = false then

	playSound "jycsfx31"', false, 0.4

	end if

	addscore(1000)

end if

end sub

sub Ytarget_hit()
	Switch()

if (blackout = false) and (tilted = false) then

	Ylight.state = bulbon
	checktargetstimer.enabled = true

	if faded = false then

	playSound "jycsfx31"', false, 0.4

	end if

	addscore(1000)

end if

end sub

sub Atarget_hit()
	Switch()

if (blackout = false) and (tilted = false) then

	Alight.state = bulbon
	checktargetstimer.enabled = true

	if faded = false then

	playSound "jycsfx31"', false, 0.4

	end if

	addscore(1000)

end if

end sub

sub Rtarget_hit()
	Switch()

if (blackout = false) and (tilted = false) then

	Rlight.state = bulbon
	checktargetstimer.enabled = true

	if faded = false then

	playSound "jycsfx31"', false, 0.4

	end if

	addscore(1000)

end if

end sub

sub Dtarget_hit()
	Switch()

if (blackout = false) and (tilted = false) then

	Dlight.state = bulbon
	checktargetstimer.enabled = true

	if faded = false then

	playSound "jycsfx31"', false, 0.4

	end if

	addscore(1000)

end if

end sub

sub checktargetstimer_Timer()
	checktargets()
	checktargetstimer.enabled = false
end sub

sub checktargets()
	if (Jtarget.Isdropped = 1) and (Utarget.Isdropped = 1) and (Ntarget.Isdropped = 1) and (Ktarget.Isdropped = 1) and (Ytarget.Isdropped = 1) and (Atarget.Isdropped = 1) and (Rtarget.Isdropped = 1) and (Dtarget.Isdropped = 1) then
	
	if multiballplayed = false then

		advancecats()

	end if

	resettargets()
	advancebanks()

	end if
end sub

sub resettargets()
    PlaySound "fx_resetdrop"
	Jlight.state = bulboff
	Ulight.state = bulboff
	Nlight.state = bulboff
	Klight.state = bulboff
	Ylight.state = bulboff
	Alight.state = bulboff
	Rlight.state = bulboff
	Dlight.state = bulboff
	Jtarget.Isdropped = 0
	Utarget.Isdropped = 0
	Ntarget.Isdropped = 0
	Ktarget.Isdropped = 0
	Ytarget.Isdropped = 0
	Atarget.Isdropped = 0
	Rtarget.Isdropped = 0
	Dtarget.Isdropped = 0
end sub

dim banks
dim letters

sub advancebanks()

if (blackout = false) and (tilted = false) then

	banks = banks + 1
	letters = letters + 1
	nvR1 = nvR1 + 1

	addbonuspoints(1000)

	checkblackout()
	targetpoints()

	if ((multiballon = false) and (multiballrestart = false)) then

		if locklit = true then

			showletters()

		else

			if multiballplayed = true then

				showletters()

			else

				delayletters()

			end if

		end if

	end if

end if

end sub

sub delayletters()

	delayletterstimer.enabled = true

end sub

sub delayletterstimer_Timer()

	delayletterstimer.enabled = false
	showletters()

end sub

sub showletters()

	playSound "jycsfx59"', false, 1.0

	'hdisplay1.flushqueue()
	'hdisplay2.flushqueue()

	'hdisplay1.slowblinkspeed = 30
	'hdisplay2.slowblinkspeed = 30

	'display1.flushqueue()
	'display2.flushqueue()

	'display1.slowblinkspeed = 30
	'display2.slowblinkspeed = 30

	showinprogress = true
	showtimer.interval = 2600
	showtimer.enabled = true

	if letters = 1 then

	hdisplay1.Text = "TIME TRAVEL "', sescrollupover, 50
	hdisplay2.Text = "TIME TRAVEL "', sescrollupover, 50
	hdisplay1.Text = "  TIME TRAVEL "', seblinkmask, 2500
	hdisplay2.Text = "  TIME TRAVEL "', seblinkmask, 2500

	display1.Text = "TIME TRAVEL "', sescrollupover, 50
	display2.Text = "TIME TRAVEL "', sescrollupover, 50
	display1.Text = "  TIME TRAVEL "', seblinkmask, 2500
	display2.Text = "  TIME TRAVEL "', seblinkmask, 2500
    DisplayB2SText2 "TIME TRAVEL " & "  TIME TRAVEL "
	end if

	if letters = 2 then

	hdisplay1.Text = "TIME TRAVEL "', sescrollupover, 50
	hdisplay2.Text = "TIME TRAVEL "', sescrollupover, 50
	hdisplay1.Text = "    TIME TRAVEL "', seblinkmask, 2500
	hdisplay2.Text = "    TIME TRAVEL "', seblinkmask, 2500

	display1.Text = "TIME TRAVEL "', sescrollupover, 50
	display2.Text = "TIME TRAVEL "', sescrollupover, 50
	display1.Text = "    TIME TRAVEL "', seblinkmask, 2500
	display2.Text = "    TIME TRAVEL "', seblinkmask, 2500
    DisplayB2SText2 "TIME TRAVEL " & "    TIME TRAVEL "
	end if

	if letters = 3 then

	hdisplay1.Text = "TIME TRAVEL "', sescrollupover, 50
	hdisplay2.Text = "TIME TRAVEL "', sescrollupover, 50
	hdisplay1.Text = "      TIME TRAVEL "', seblinkmask, 2500
	hdisplay2.Text = "      TIME TRAVEL "', seblinkmask, 2500

	display1.Text = "TIME TRAVEL "', sescrollupover, 50
	display2.Text = "TIME TRAVEL "', sescrollupover, 50
	display1.Text = "      TIME TRAVEL "', seblinkmask, 2500
	display2.Text = "      TIME TRAVEL "', seblinkmask, 2500
    DisplayB2SText2 "TIME TRAVEL " & "      TIME TRAVEL "
	end if

	if letters = 4 then

	hdisplay1.Text = "TIME TRAVEL "', sescrollupover, 50
	hdisplay2.Text = "TIME TRAVEL "', sescrollupover, 50
	hdisplay1.Text = "        TIME TRAVEL "', seblinkmask, 2500
	hdisplay2.Text = "        TIME TRAVEL "', seblinkmask, 2500

	display1.Text = "TIME TRAVEL "', sescrollupover, 50
	display2.Text = "TIME TRAVEL "', sescrollupover, 50
	display1.Text = "        TIME TRAVEL "', seblinkmask, 2500
	display2.Text = "        TIME TRAVEL "', seblinkmask, 2500
    DisplayB2SText2 "TIME TRAVEL " & "        TIME TRAVEL "
	end if

	if letters = 5 then

	hdisplay1.Text = "TIME TRAVEL "', sescrollupover, 50
	hdisplay2.Text = "TIME TRAVEL "', sescrollupover, 50
	hdisplay1.Text = "          TIME TRAVEL "', seblinkmask, 2500
	hdisplay2.Text = "          TIME TRAVEL "', seblinkmask, 2500

	display1.Text = "TIME TRAVEL "', sescrollupover, 50
	display2.Text = "TIME TRAVEL "', sescrollupover, 50
	display1.Text = "          TIME TRAVEL "', seblinkmask, 2500
	display2.Text = "          TIME TRAVEL "', seblinkmask, 2500
    DisplayB2SText2 "TIME TRAVEL " & "          TIME TRAVEL "
	end if

	if letters = 6 then

	hdisplay1.Text = "TIME TRAVEL "', sescrollupover, 50
	hdisplay2.Text = "TIME TRAVEL "', sescrollupover, 50
	hdisplay1.Text = "            TIME TRAVEL "', seblinkmask, 2500
	hdisplay2.Text = "            TIME TRAVEL "', seblinkmask, 2500

	display1.Text = "TIME TRAVEL "', sescrollupover, 50
	display2.Text = "TIME TRAVEL "', sescrollupover, 50
	display1.Text = "            TIME TRAVEL "', seblinkmask, 2500
	display2.Text = "            TIME TRAVEL "', seblinkmask, 2500
    DisplayB2SText2 "TIME TRAVEL " & "            TIME TRAVEL "
	end if

	if letters = 7 then

	hdisplay1.Text = "TIME TRAVEL "', sescrollupover, 50
	hdisplay2.Text = "TIME TRAVEL "', sescrollupover, 50
	hdisplay1.Text = "              TIME TRAVEL "', seblinkmask, 2500
	hdisplay2.Text = "              TIME TRAVEL "', seblinkmask, 2500

	display1.Text = "TIME TRAVEL "', sescrollupover, 50
	display2.Text = "TIME TRAVEL "', sescrollupover, 50
	display1.Text = "              TIME TRAVEL "', seblinkmask, 2500
	display2.Text = "              TIME TRAVEL "', seblinkmask, 2500
    DisplayB2SText2 "TIME TRAVEL " & "              T "
	end if

	if letters > 7 then

	hdisplay1.Text = "TIME TRAVEL "', sescrollupover, 50
	hdisplay2.Text = "TIME TRAVEL "', sescrollupover, 50
	hdisplay1.Text = "TIME TRAVEL "', seblinkmask, 2500
	hdisplay2.Text = "TIME TRAVEL "', seblinkmask, 2500

	display1.Text = "TIME TRAVEL "', sescrollupover, 50
	display2.Text = "TIME TRAVEL "', sescrollupover, 50
	display1.Text = "TIME TRAVEL "', seblinkmask, 2500
	display2.Text = "TIME TRAVEL "', seblinkmask, 2500
    DisplayB2SText2 "TIME TRAVEL " & "TIME TRAVEL "
	end if


end sub

sub checkblackout()
    If B2SOn = 0 Then
       On Error Resume Next
	if letters = 0 then
        LightblackoutBackGlassTimer.Enabled = 0
		bo1.state = bulboff:Controller.B2SSetData 1, 0
		bo2.state = bulboff:Controller.B2SSetData 2, 0
		bo3.state = bulboff:Controller.B2SSetData 3, 0
		bo4.state = bulboff:Controller.B2SSetData 4, 0
		bo5.state = bulboff:Controller.B2SSetData 5, 0
		bo6.state = bulboff:Controller.B2SSetData 6, 0
		bo7.state = bulboff:Controller.B2SSetData 7, 0
		bo8.state = bulboff:Controller.B2SSetData 8, 0

	end if

	if letters = 1 then

		bo1.state = bulbon :Controller.B2SSetData 1, 1
		bo2.state = bulboff:Controller.B2SSetData 2, 0
		bo3.state = bulboff:Controller.B2SSetData 3, 0
		bo4.state = bulboff:Controller.B2SSetData 4, 0
		bo5.state = bulboff:Controller.B2SSetData 5, 0
		bo6.state = bulboff:Controller.B2SSetData 6, 0
		bo7.state = bulboff:Controller.B2SSetData 7, 0
		bo8.state = bulboff:Controller.B2SSetData 8, 0

	end if

	if letters = 2 then

		bo1.state = bulbon:Controller.B2SSetData 1, 1
		bo2.state = bulbon:Controller.B2SSetData 2, 1
		bo3.state = bulboff:Controller.B2SSetData 3, 0
		bo4.state = bulboff:Controller.B2SSetData 4, 0
		bo5.state = bulboff:Controller.B2SSetData 5, 0
		bo6.state = bulboff:Controller.B2SSetData 6, 0
		bo7.state = bulboff:Controller.B2SSetData 7, 0
		bo8.state = bulboff:Controller.B2SSetData 8, 0

	end if

	if letters = 3 then

		bo1.state = bulbon :Controller.B2SSetData 1, 1
		bo2.state = bulbon :Controller.B2SSetData 2, 1
		bo3.state = bulbon :Controller.B2SSetData 3, 1
		bo4.state = bulboff:Controller.B2SSetData 4, 0
		bo5.state = bulboff:Controller.B2SSetData 5, 0
		bo6.state = bulboff:Controller.B2SSetData 6, 0
		bo7.state = bulboff:Controller.B2SSetData 7, 0
		bo8.state = bulboff:Controller.B2SSetData 8, 0

	end if

	if letters = 4 then

		bo1.state = bulbon :Controller.B2SSetData 1, 1
		bo2.state = bulbon :Controller.B2SSetData 2, 1
		bo3.state = bulbon :Controller.B2SSetData 3, 1
		bo4.state = bulbon :Controller.B2SSetData 4, 1
		bo5.state = bulboff:Controller.B2SSetData 5, 0
		bo6.state = bulboff:Controller.B2SSetData 6, 0
		bo7.state = bulboff:Controller.B2SSetData 7, 0
		bo8.state = bulboff:Controller.B2SSetData 8, 0

	end if

	if letters = 5 then

		bo1.state = bulbon :Controller.B2SSetData 1, 1
		bo2.state = bulbon :Controller.B2SSetData 2, 1 
		bo3.state = bulbon :Controller.B2SSetData 3, 1
		bo4.state = bulbon :Controller.B2SSetData 4, 1
		bo5.state = bulbon :Controller.B2SSetData 5, 1
		bo6.state = bulboff:Controller.B2SSetData 6, 0
		bo7.state = bulboff:Controller.B2SSetData 7, 0
		bo8.state = bulboff:Controller.B2SSetData 8, 0

	end if

	if letters = 6 then

		bo1.state = bulbon :Controller.B2SSetData 1, 1
		bo2.state = bulbon :Controller.B2SSetData 2, 1
		bo3.state = bulbon :Controller.B2SSetData 3, 1
		bo4.state = bulbon :Controller.B2SSetData 4, 1
		bo5.state = bulbon :Controller.B2SSetData 5, 1
		bo6.state = bulbon :Controller.B2SSetData 6, 1
		bo7.state = bulboff:Controller.B2SSetData 7, 0
		bo8.state = bulboff:Controller.B2SSetData 8, 0

	end if

	if letters = 7 then

		bo1.state = bulbon :Controller.B2SSetData 1, 1
		bo2.state = bulbon :Controller.B2SSetData 2, 1
		bo3.state = bulbon :Controller.B2SSetData 3, 1
		bo4.state = bulbon :Controller.B2SSetData 4, 1
		bo5.state = bulbon :Controller.B2SSetData 5, 1
		bo6.state = bulbon :Controller.B2SSetData 6, 1
		bo7.state = bulbon :Controller.B2SSetData 7, 1
		bo8.state = bulboff:Controller.B2SSetData 8, 0

	end if

	if letters = 8 then

		bo1.state = bulbblink:Controller.B2SSetData 1, 0
		bo2.state = bulbblink:Controller.B2SSetData 2, 0
		bo3.state = bulbblink:Controller.B2SSetData 3, 0
		bo4.state = bulbblink:Controller.B2SSetData 4, 0
		bo5.state = bulbblink:Controller.B2SSetData 5, 0
		bo6.state = bulbblink:Controller.B2SSetData 6, 0
		bo7.state = bulbblink:Controller.B2SSetData 7, 0
		bo8.state = bulbblink:Controller.B2SSetData 8, 0
        LightblackoutBackGlassTimer.Interval = 500
        LightblackoutBackGlassTimer.Enabled = 1
		lightblackout()

	end if
 End If
end sub


Sub LightblackoutBackGlassTimer_Timer
  If B2SOn Then
    Controller.B2SSetData 34, 1
  End If
End Sub



sub targetpoints()

	if letters = 1 then

		addscore(10000)

	end if

	if letters = 2 then

		addscore(20000)

	end if

	if letters = 3 then

		addscore(30000)

	end if

	if letters = 4 then

		addscore(40000)

	end if

	if letters = 5 then

		addscore(50000)

	end if

	if letters = 6 then

		addscore(60000)

	end if

	if letters = 7 then

		addscore(70000)

	end if

	if letters > 7 then

		addscore(100000)

	end if

end sub

Dim blackout
dim blackoutlit

sub lightblackout()

	blackoutlit = true

end sub

sub advancecats()

	If locklit = false then

		If ward = false then

			spotward()
	
		else

			If ward = true then

				if axel = false then
				
					spotaxel()
			
				else

					if axel = true then
			
						if roy = false then

							spotroy()

						else

							if roy = true then

								if jenkins = false then

									spotjenkins()

								else

									spotscarla()

								end if

							end if
				
						end if

					end if

				end if

			end if

		end if

	end if

end sub

dim jets
dim displayinterrupt
dim showinprogress
dim nextbumperaward
dim extraballslit

sub interruptdisplay()

	displayinterrupt = true
	displayinterrupttimer.enabled = true

end sub

sub displayinterrupttimer_Timer()

	enddisplayinterrupt()

end sub

sub enddisplayinterrupt()

	displayinterrupttimer.enabled = false
	displayinterrupt = false

	if showinprogress = false then

	addscore(0)

	end if

end sub

dim superjets

sub bumper1_hit()
    PlaySound SoundFXDOF("fx_bumper",107,DOFPulse,DOFContactors), 0, 1, pan(ActiveBall)
	DOF 110, DOFPulse
	Switch()

if (blackout = false) and (tilted = false) then

	jets = jets + 1

	if (multiballon = false) and (quickmultiballon = false) and (showinprogress = false) then

	displayinterrupttimer.interval = 4000
	interruptdisplay()

	hdisplay1.text = "    " & jets & " HITS   "	
	hdisplay2.text = "   EXTRA BALL AT " & nextbumperaward 

	display1.text = "    " & jets & " HITS   "	
	display2.text = "   EX BALL AT " & nextbumperaward 
    DisplayB2SText "    " & jets & " HITS   " & "   EXTRABALL AT " & nextbumperaward
	end if

	checkjets()

	if ((superjets = true) and (faded = false)) then

	addscore(5000)
	playSound "jycsfx10"', False, 0.8	

	flashforms strobe3, 500, 50, 0
	flashforms strobe4, 500, 50, 0
	flashforms strobe5, 500, 50, 0

	else

	flashforms strobe4, 500, 50, 0

	addscore (500)

		if ((twomillionlit = false) and (faded = false)) then

			playSound "jycsfx7"', False, 0.4

		end if

	end if

end if

end sub

sub bumper2_hit()
	Switch()
    PlaySound SoundFXDOF("fx_bumper2",107,DOFPulse,DOFContactors), 0, 1, pan(ActiveBall)
	DOF 112, DOFPulse
if (blackout = false) and (tilted = false) then

	jets = jets + 1

	if (multiballon = false) and (quickmultiballon = false) and (showinprogress = false) then

	displayinterrupttimer.interval = 4000
	interruptdisplay()

	hdisplay1.text = "    " & jets & " HITS   "	
	hdisplay2.text = " EX BALL AT " & nextbumperaward 

	display1.text = "    " & jets & " HITS   "	
	display2.text = " EX BALL AT " & nextbumperaward 
    DisplayB2SText "    " & jets & " HITS   " & "   EXTRABALL AT " & nextbumperaward
	end if

	checkjets()

	if ((superjets = true) and (faded = false)) then

	addscore(5000)
	playSound "jycsfx10"', False, 0.8

	flashforms strobe6, 500, 50, 0
	flashforms strobe7, 500, 50, 0
	flashforms strobe8, 500, 50, 0
	flashforms strobe9, 500, 50, 0

	else

	flashforms strobe6, 500, 50, 0

	addscore (500)

		if ((twomillionlit = false) and (faded = false)) then

			playSound "jycsfx8"', False, 0.4

		end if

	end if

end if

end sub

sub bumper3_hit()
	Switch()
    PlaySound SoundFXDOF("fx_bumper3",107,DOFPulse,DOFContactors), 0, 1, pan(ActiveBall)
	DOF 111, DOFPulse
if (blackout = false) and (tilted = false) then

	jets = jets + 1

	if (multiballon = false) and (quickmultiballon = false) and (showinprogress = false) then

	displayinterrupttimer.interval = 4000
	interruptdisplay()

	hdisplay1.text = "    " & jets & " HITS   "	
	hdisplay2.text = " EX BALL AT " & nextbumperaward 

	display1.text = "    " & jets & " HITS   "	
	display2.text = " EX BALL AT " & nextbumperaward 
    DisplayB2SText "    " & jets & " HITS   " & "   EXTRABALL AT " & nextbumperaward
	end if

	checkjets()

	if ((superjets = true) and (faded = false)) then

	addscore(5000)
	playSound "jycsfx10"', False, 0.8

	flashforms strobe1, 500, 50, 0
	flashforms strobe2, 500, 50, 0
	flashforms strobe10, 500, 50, 0

	else

	flashforms strobe3, 500, 50, 0

	addscore (500)

		if ((twomillionlit = false) and (faded = false)) then

			playSound "jycsfx9"', False, 0.4

		end if

	end if

end if

end sub

sub checkjets()

	if jets = nextbumperaward then

	lightextraball()
	nextbumperaward = nextbumperaward + 300

	end if

end sub

sub lightextraball()

extraballslit = extraballslit + 1
extraballlitshow()
checkextraballs()

addbonuspoints(1000)	

end sub

sub checkextraballs()

	if extraballslit > 0 then

		extraballlight.state = bulbblink

	else

		extraballlight.state = bulboff

	end if

end sub

sub clane_hit()

	Switch()

if (blackout = false) and (tilted = false) then

	addscore(300)

	if (multiballon = false) and (faded = false) then

		playSound "jycsfx18"', False, 0.4

	end if

	clanelight.state = bulbon
	checkCATlanes()

end if

end sub

sub alane_hit()

	Switch()

if (blackout = false) and (tilted = false) then

	addscore(300)

	if (multiballon = false) and (faded = false) then

		playSound "jycsfx18"', False, 0.4

	end if

	alanelight.state = bulbon
	checkCATlanes()

end if

end sub

sub tlane_hit()

	Switch()

if (blackout = false) and (tilted = false) then

	addscore(300)

	if (multiballon = false) and (faded = false) then

		playSound "jycsfx18"', False, 0.4

	end if

	tlanelight.state = bulbon
	checkCATlanes()

end if

end sub

dim tempstate

sub shiftCATlanesleft()

if (blackout = false) and (tilted = false) then

	TempState = clanelight.State
	clanelight.State = alanelight.State
	alanelight.State = tlanelight.State
	tlanelight.State = TempState

end if

end sub

sub shiftCATlanesright()

if (blackout = false) and (tilted = false) then

	TempState = tlanelight.State
	tlanelight.State = alanelight.State
	alanelight.State = clanelight.State
	clanelight.State = TempState

end if

end sub

sub checkCATlanes()

	If (clanelight.State = 1) And (alanelight.State = 1) And (tlanelight.State = 1) Then
		advancex()
		clanelight.State = BulbOff
		alanelight.State = BulbOff
		tlanelight.State = BulbOff
	End If

end sub


sub advancex()

if (blackout = false) and (tilted = false) then

	bonusx = bonusx + 1

	select case bonusx

	case 2:

		twoxlight.state = bulbon

		if multiballrestart = false then

			'hdisplay1.flushqueue()
			'hdisplay2.flushqueue()

			hdisplay1.text = "    2X BONUS    "', sescrollrightover, 2000
			hdisplay2.text = "    2X BONUS    "', sescrollleftover, 2000

			'display1.flushqueue()
			'display2.flushqueue()

			display1.text = "    2X BONUS    "', sescrollrightover, 2000
			display2.text = "    2X BONUS    "', sescrollleftover, 2000
            DisplayB2SText2 "    2X BONUS    " & "                "
			showinprogress = true
			showtimer.interval = 1500
			showtimer.enabled = true

			if faded = false then

				playSound "jycsfx5"', false, 0.7

			end if

		end if

	case 3:

		threexlight.state = bulbon

		if multiballrestart = false then

			'hdisplay1.flushqueue()
			'hdisplay2.flushqueue()

		hdisplay1.text = "    3X BONUS    "', sescrollrightover, 2000
	   hdisplay2.text = "    3X BONUS    "', sescrollleftover, 2000

			'display1.flushqueue()
			'display2.flushqueue()

		display1.text = "    3X BONUS    "', sescrollrightover, 2000
	   display2.text = "    3X BONUS    "', sescrollleftover, 2000
       DisplayB2SText2 "    3X BONUS    " & "                "
		showinprogress = true
		showtimer.interval = 1500
		showtimer.enabled = true

		if faded = false then

		playSound "jycsfx5"', false, 0.7

		end if

		end if

	case 4:

		fourxlight.state = bulbon

		if multiballrestart = false then

			'hdisplay1.flushqueue()
			'hdisplay2.flushqueue()

		hdisplay1.text = "    4X BONUS    "', sescrollrightover, 2000
	   hdisplay2.text = "    4X BONUS    "', sescrollleftover, 2000

			'display1.flushqueue()
			'display2.flushqueue()

		display1.text = "    4X BONUS    "', sescrollrightover, 2000
	   display2.text = "    4X BONUS    "', sescrollleftover, 2000
       DisplayB2SText2 "    4X BONUS    " & "                "
		showinprogress = true
		showtimer.interval = 1500
		showtimer.enabled = true

		if faded = false then

		playSound "jycsfx5"', false, 0.7

		end if

		end if

	case 5:

		fivexlight.state = bulbon

		if multiballrestart = false then

			'hdisplay1.flushqueue()
			'hdisplay2.flushqueue()

		hdisplay1.text = "    5X BONUS    "', sescrollrightover, 2000
	   hdisplay2.text = "    5X BONUS    "', sescrollleftover, 2000

			'display1.flushqueue()
			'display2.flushqueue()

		display1.text = "    5X BONUS    "', sescrollrightover, 2000
	   display2.text = "    5X BONUS    "', sescrollleftover, 2000
       DisplayB2SText2 "    5X BONUS    " & "                "
		showinprogress = true
		showtimer.interval = 1500
		showtimer.enabled = true

		if faded = false then

		playSound "jycsfx5"', false, 0.7

		end if

		end if

	case 6:

		bonusx = bonusx - 1

		'hdisplay1.slowblinkspeed = 30
		'display1.slowblinkspeed = 30

		if superjets = false then

			if multiballrestart = false then

			'hdisplay1.flushqueue()
			'hdisplay2.flushqueue()

		hdisplay1.text = "     100000     "', sescrollrightover, 2000
	   hdisplay2.text = " SUPER BOOMSTICK LIT "', sescrollleftover, 50
		hdisplay2.text = " SUPER BOOMSTICK LIT "', seblinkmask, 2000

			'display1.flushqueue()
			'display2.flushqueue()

		display1.text = "     100000     "', sescrollrightover, 2000
	   display2.text = " SUPER BOOMSTICK LIT "', sescrollleftover, 50
		display2.text = " SUPER BOOMSTICK LIT "', seblinkmask, 2000
      DisplayB2SText2 "     100000     " & " SUPER BOOMSTICK LIT "
			end if

		startsuperjets()

		else

			if multiballrestart = false then

			'hdisplay1.flushqueue()
			'hdisplay2.flushqueue()

		hdisplay1.text = "     100000     "', sescrollrightover, 50
	   hdisplay2.text = "                "', sescrollleftover, 2000
		hdisplay1.text = "     100000     "', seblinkmask, 2000

			'display1.flushqueue()
			'display2.flushqueue()

		display1.text = "     100000     "', sescrollrightover, 50
	   display2.text = "                "', sescrollleftover, 2000
		display1.text = "     100000     "', seblinkmask, 2000
     DisplayB2SText2 "     100000     " & "                 "
			end if

		end if

		showinprogress = true
		showtimer.interval = 1500
		showtimer.enabled = true

		if faded = false then

		playSound "jycsfx47"', false, 0.7

		end if

		addscore(100000)

	end select

	if (multiballon = false) and (quickmultiballon = false) and (multiballrestart = false) then

		MainSeq2.updateinterval = 6
		MainSeq2.Play SeqDownOn, 50

		flashforms strobe4, 1000, 40, bulboff
		flashforms strobe6, 1000, 40, bulboff

	end if

	addscore(20000)
	addbonuspoints(1000)

end if

end sub

sub showtimer_Timer()

	showtimer.enabled = false

	if multiballrestart = false then

		showinprogress = false

		'hdisplay1.flushqueue()
		'hdisplay2.flushqueue()

		'display1.flushqueue()
		'display2.flushqueue()

		addscore(0)

		if statusonhold = true then

			onholdstatus()

		end if

		if lockshow = true then

			lockshow = false

		end if

	end if

end sub

dim tempstate2

sub shiftCLAWlanesleft()

if (blackout = false) and (tilted = false) then

	TempState2 = clawlight1.State
	clawlight1.State = clawlight2.State
	clawlight2.State = clawlight3.State
	clawlight3.State = clawlight4.State
	clawlight4.State = TempState2

end if

end sub

sub shiftCLAWlanesright()

if (blackout = false) and (tilted = false) then

	TempState2 = clawlight4.State
	clawlight4.State = clawlight3.State
	clawlight3.State = clawlight2.State
	clawlight2.State = clawlight1.State
	clawlight1.State = TempState2

end if

end sub

sub checkclawlanes()

	If (clawlight1.State = 1) And (clawlight2.State = 1) And (clawlight3.State = 1) And (clawlight4.State = 1) Then
		advanceclaw()
		clawlight1.State = BulbOff
		clawlight2.State = BulbOff
		clawlight3.State = BulbOff
		clawlight4.State = BulbOff

	End If

end sub

dim claw

sub addclaw(points)

	SpecialScore(CurrentPlayer) = SpecialScore(CurrentPlayer) + points

end sub

sub advanceclaw()

	claw = claw + 1
	addclaw(1)

	if faded = false then

		Playsound "jycsfx5"', false, 0.7

	end if

	flashforms leftinlanestrobe, 1000, 75, bulboff
	flashforms leftinlanestrobe2, 1000, 75, bulboff
	flashforms rightinlanestrobe, 1000, 75, bulboff
	flashforms rightinlanestrobe2, 1000, 75, bulboff

	if ((multiballrestart = false) and (twomillionlit = false)) then

		'hdisplay1.flushqueue()
		'hdisplay2.flushqueue()	

		'display1.flushqueue()
		'display2.flushqueue()	

		if claw = 1 then

					'hdisplay1.slowblinkspeed = 30

					hdisplay1.text = "    1 BOOK      "', sescrollrightover 
					hdisplay2.text = "SHOOT LEFT RAMP "', sescrollleftover, 2000

					hdisplay1.text = "    1 BOOK      "', seblinkmask, 2000

					'display1.slowblinkspeed = 30

					display1.text = "    1 BOOK      "', sescrollrightover 
					display2.text = "SHOOT LEFT RAMP "', sescrollleftover, 2000

					display1.text = "    1 BOOK      "', seblinkmask, 2000
                    DisplayB2SText2 "    1 BOOK      " & "SHOOT LEFT RAMP "
			showinprogress = true
			showtimer.interval = 3000
			showtimer.enabled = true

		end if

		if claw > 1 then

			if ((quickmultiballon = false) and (multiballon = false)) then

				if claw = nextquick then

					'hdisplay1.slowblinkspeed = 30

					hdisplay1.text = "    " & claw & " BOOK    "', sescrollrightover
					hdisplay2.text = "SHOOT LEFT RAMP "', sescrollleftover, 2000

					hdisplay1.text = "    " & claw & " BOOK    "', seblinkmask, 2000

					'display1.slowblinkspeed = 30

					display1.text = "    " & claw & " BOOK    "', sescrollrightover
					display2.text = "SHOOT LEFT RAMP "', sescrollleftover, 2000

					display1.text = "    " & claw & " BOOK    "', seblinkmask, 2000
                    DisplayB2SText2 "    " & claw & " BOOK    " & "SHOOT LEFT RAMP "
					showinprogress = true
					showtimer.interval = 3000
					showtimer.enabled = true

				else

					if quickmultiballlit = false then

						'hdisplay1.slowblinkspeed = 30

						hdisplay1.text = "    " & claw & " BOOK    "', sescrollrightover
						hdisplay2.text = "NEXT AWARD AT " & nextquick', sescrollleftover, 2000

						hdisplay1.text = "    " & claw & " BOOK    "', seblinkmask, 2000

						'display1.slowblinkspeed = 30

						display1.text = "    " & claw & " BOOK    "', sescrollrightover
						display2.text = "NEXT AWARD AT " & nextquick', sescrollleftover, 2000

						display1.text = "    " & claw & " BOOK    "', seblinkmask, 2000
                        DisplayB2SText2 "    " & claw & " BOOK    " & "NEXT AWARD AT " & nextquick
						showinprogress = true
						showtimer.interval = 3000
						showtimer.enabled = true

						else

						'hdisplay1.slowblinkspeed = 30

						hdisplay1.text = "    " & claw & " BOOK    "', sescrollrightover
						hdisplay2.text = "SHOOT LEFT RAMP "', sescrollleftover, 2000

						hdisplay1.text = "    " & claw & " BOOK    "', seblinkmask, 2000

						'display1.slowblinkspeed = 30

						display1.text = "    " & claw & " BOOK    "', sescrollrightover
						display2.text = "SHOOT LEFT RAMP "', sescrollleftover, 2000

						display1.text = "    " & claw & " BOOK    "', seblinkmask, 2000
                        DisplayB2SText2 "    " & claw & " BOOK    " & "                "
						showinprogress = true
						showtimer.interval = 3000
						showtimer.enabled = true

					end if

				end if

			else

				'hdisplay1.slowblinkspeed = 30

				hdisplay1.text = "     " & claw & " BOOK   "', sescrollrightover
				hdisplay2.text = "                "', sescrollleftover, 2000

				hdisplay1.text = "     " & claw & " BOOK   "', seblinkmask, 2000

				'display1.slowblinkspeed = 30

				display1.text = "     " & claw & " BOOK   "', sescrollrightover
				display2.text = "                "', sescrollleftover, 2000

				display1.text = "     " & claw & " BOOK   "', seblinkmask, 2000
                DisplayB2SText2 "    " & claw & " BOOK    " & "                "
				showinprogress = true
				showtimer.interval = 3000
				showtimer.enabled = true

			end if

		end if

	end if

	if (claw = nextquick) and (quickmultiballlit = false) then

		lightquickmultiball()

	end if

	if (multiballon = false) and (quickmultiballon = false) and (multiballrestart = false) then

		MainSeq2.updateinterval = 5
		MainSeq2.Play SeqUpOn, 50

	end if

	addscore(claw*10000)
	addbonuspoints(claw*1000)

end sub

dim quickmultiballlit
dim quickmultiballon

sub lightquickmultiball()

	quickmultiballlit = true
	quickremindtimer.enabled = true
	
	If (multiballon = false) and (multiballrestart = false) then

	quickmultiballlight.State = BulbBlink', "10", 200
	
	end if

end sub

sub quickremindtimer_Timer()

	quickremindtimer.enabled = false
	quickremind()

end sub

sub quickremind()

	if ((musicstarted = true) and (multiballon = false) and (lockshow = false) and (ballintrashcan = false)) then

	showinprogress = true
	showtimer.interval = 2000
	showtimer.enabled = true

	Playsound "jycsfx54"', false, 0.8
	Playsound "spchmeow"', false, 0.8, 1600

	'hdisplay1.flushqueue()
	'hdisplay2.flushqueue()
	'hdisplay1.slowblinkspeed = 120
	'hdisplay2.slowblinkspeed = 120
	hdisplay1.text = "QUICK MULTI-BALL"', seBlink, 900
	hdisplay2.text = "     IS LIT     "', seBlink, 900

	'display1.flushqueue()
	'display2.flushqueue()
	'display1.slowblinkspeed = 120
	'display2.slowblinkspeed = 120
	display1.text = "QUICK MULTI-BALL"', seBlink, 900
	display2.text = "     IS LIT     "', seBlink, 900
     DisplayB2SText2 "QUICK MULTI-BALL"  & "     IS LIT     " 
	end if

end sub

sub startquickmultiball()

	quickmultiballlight.state = bulbon

	endballsave()

	startmultiballstrobes()

	song = 7 
	playsong2()

	autolaunchball()

	playsound "spchtwocanplay"', false, 0.9

	fademusic()

	quickmultiballon = true

	randomawardlight.state = bulboff
	jackpot1light.state = bulbblink
	jackpot2light.state = bulbblink

	If locklit = true then

	lock1light.state = bulbon
	lock2light.state = bulbon
	leftdiverter.RotateToStart
	rightdiverter.RotateToStart
    Playsound "DiverterOff"
	leftdiverteropen = false
	rightdiverteropen = false

	end if

	addscore(30000)
	addbonuspoints(1000)

end sub

dim nextquick

sub endquickmultiball()

	quickmultiballlight.state = bulboff
	quickmultiballon = false
	quickmultiballlit = false

	jackpot1light.state = bulboff
	jackpot2light.state = bulboff

	nextquick = claw + 3

	endmultiballstrobes()

	if trashcanlit = true then

		randomawardlight.state = bulbon

	end if

	resetdiverters()

	if locklit = true then

		'stopmusic 1
        StopAllSounds
		song = 4
        playsong2()
		playsound "jycsfx41"', False, 0.7
	

		catscampleft = false
		catscamper()

		if ballinleftlock = false then

			lock1light.state = bulbblink

		end if
	
		if ballinrightlock = false then

			lock2light.state = bulbblink

		end if

	else

		if locklitonhold = true then

		lightlock()
		locklitonhold = false

		else
          
		'stopmusic 1
        StopAllSounds
		song = 2
        playsong2()
		playsound "jycsfx41"', False, 0.7

		catscampleft = false
		catscamper()

		end if

	end if

end sub

dim exballshow
dim lballshow

sub extraballlitshow()

	if multiballrestart = false then

'	 hdisplay1.flushqueue()
'	 hdisplay2.flushqueue()
'	 hdisplay1.slowblinkspeed = 150
'	 hdisplay2.slowblinkspeed = 150
'	 hdisplay1.queuetext "   EXTRA BALL   ", seBlink, 1200
'	 hdisplay2.queuetext "     IS LIT     ", seBlink, 1200

'	 display1.flushqueue()
''	 display2.flushqueue()
'	 display1.slowblinkspeed = 150
'	 display2.slowblinkspeed = 150
'	 display1.queuetext "   EXTRA BALL   ", seBlink, 1200
'	 display2.queuetext "     IS LIT     ", seBlink, 1200
     display1.text = "   EXTRA BALL   "  & "     IS LIT     "
     DisplayB2SText2 "   EXTRA BALL   "  & "     IS LIT     " 	 	
	 showinprogress = true
	 exballshow = true
	 buzz()

	end if

end sub

dim locksafety

sub lockballshow()
	 ballsearchtimer.enabled = false
	 ballsearchon = false

	 if ballslocked = 1 then

'		hdisplay1.flushqueue()
'		hdisplay2.flushqueue()
'		hdisplay1.slowblinkspeed = 30
'		hdisplay2.slowblinkspeed = 30
'		hdisplay1.queuetext "  AMMO COLLECTED  ", seBlink, 3000, , true
'		hdisplay2.queuetext "  FOR MULTIBALL ", seBlink, 3000, , true

'		display1.flushqueue()
'		display2.flushqueue()
'		display1.slowblinkspeed = 30
'		display2.slowblinkspeed = 30
'		display1.queuetext "  AMMO COLLECTED  ", seBlink, 3000, , true
'		display2.queuetext "  FOR MULTIBALL ", seBlink, 3000, , true
        display1.text = "  AMMO COLLECTED  "  & "  FOR MULTIBALL "
        DisplayB2SText2 "  AMMO COLLECTED  "  & "  FOR MULTIBALL "
	 end if

	 if ballslocked = 2 then

'		hdisplay1.flushqueue()
'		hdisplay2.flushqueue()
'		hdisplay1.slowblinkspeed = 30
'		hdisplay2.slowblinkspeed = 30
'		hdisplay1.queuetext "  BOOMSTICK SET ", seBlink, 3000, , true
'		hdisplay2.queuetext "  FOR MULTIBALL ", seBlink, 3000, , true

'		display1.flushqueue()
'		display2.flushqueue()
'		display1.slowblinkspeed = 30
'		display2.slowblinkspeed = 30
'		display1.queuetext "  BOOMSTICK SET ", seBlink, 3000, , true
'		display2.queuetext "  FOR MULTIBALL ", seBlink, 3000, , true
        display1.text = "  BOOMSTICK SET "  & "  FOR MULTIBALL "
        DisplayB2SText2 "  BOOMSTICK SET "  & "  FOR MULTIBALL "
	 end if


	 showinprogress = true
	 showtimer.interval = 4000
	 showtimer.enabled = true
	 playsound "jycsfx4"', false, 0.3
	 playsound "jycsfx32"', false, 0.5

     'StopAllSounds
	 'stopmusic 1
	 'stopmusic 6

	 'fade.enabled = false

	 lockballonhold = false

	 balljustlocked = true
	 balljustlockedtimer.enabled = true

	 exballshow = false
    buzztimer.enabled = false
    buzzer = buzzer - buzzer

	 mainseq2.stopplay()
	 mainseq.play SeqBlinking, , 33, 30

	if ballslocked = 1 then

	 noswitchhit = true
	 musicstarted = false

		if ballinleftlock = true then

			rightdiverter.RotatetoStart
			rightdiverteropen = false
			locksafety = true

		end if

	end if

	 releaseballtimer.enabled = true

end sub

sub balljustlockedtimer_Timer()

	balljustlocked = false
	balljustlockedtimer.enabled = false

end sub

sub releaseballtimer_Timer()
	releaseballtimer.enabled = false

	if ballslocked = 1 then

	createnewball()
	playsound "jyclocklitshooter"', True, 0.8
    playsound "jycsfx6"', false, 0.8

	faded = false

	else

	startmultiball()

	end if

end sub

sub lockremind()

	if showinprogress = false then

		'if ballslocked = 1 then

			'hdisplay1.flushqueue()
			'hdisplay2.flushqueue()
			'hdisplay1.slowblinkspeed = 150
			'hdisplay2.slowblinkspeed = 150
			'hdisplay1.queuetext "LOCK 1 MORE BALL", seBlink, 1200
			'hdisplay2.queuetext "                ", seBlink, 1200
			'lballshow = true
			'buzz()

		'else

			'playmusic 5, "spchwhateverittakes", false, 0.8
			'fademusic()

		'end if

	'else

		playsound "spchwhateverittakes"', false, 0.8
		fademusic()

	end if
	
end sub

dim buzzer

sub buzz()

	Playsound "jycsfx11"', false, 0.7
	buzztimer.enabled = true

end sub

sub buzztimer_Timer()
		buzzer = buzzer + 1
		If buzzer = 1 then
		Playsound  "jycsfx11", false, 0.7
		end if
		If buzzer= 2 then
		Playsound  "jycsfx11", false, 0.7
		end if
		If buzzer = 3 then
		Playsound "jycsfx11", false, 0.7
		end if
		if buzzer = 5 then
		showinprogress = false

			if exballshow = true then
				exballshow = false

				if multiballon = false then
				Playsound "spchgettheextraball", false, 0.8
				fademusic()
				end if

			end if

			if lballshow = true then
				lballshow = false
				Playsound "spchwhateverittakes", false, 0.8
				fademusic()
			end if

		end if
		if buzzer = 15 then
		buzztimer.enabled = false
		buzzer = buzzer - buzzer
		addscore(0)
		end if

end sub

dim lstrobes
dim rstrobes
dim lstrobesup
dim rstrobesup

sub leftstrobesup()

if (blackout = false) and (tilted = false) then

	lstrobesup = true
	lstrobestimer.enabled = true

end if

end sub

sub leftstrobesdown()

if (blackout = false) and (tilted = false) then

	lstrobesup = false
	lstrobes = 6
	lstrobestimer.enabled = true

end if

end sub

sub lstrobestimer_Timer()

	if lstrobesup = true then

	lstrobes = lstrobes + 1

	else

	lstrobes = lstrobes - 1

	end if

	if lstrobes = 0 then

		if multiballstrobes = true then

		lstrobestimer.enabled = true
		lstrobes = 5

		flashforms strobe5, 500, 50, 0

		else

		lstrobestimer.enabled = false
		lstrobes = lstrobes - lstrobes

		end if

	end if

	if lstrobes = 1 then
		flashforms strobe1, 500, 50, 0
	end if

	if lstrobes = 2 then
		flashforms strobe2, 500, 50, 0
	end if

	if lstrobes = 3 then
		flashforms strobe3, 500, 50, 0
	end if

	if lstrobes = 4 then
		flashforms strobe4, 500, 50, 0
	end if

	if lstrobes = 5 then
		flashforms strobe5, 500, 50, 0
	end if

	if lstrobes = 6 then

		if multiballstrobes = true then

		lstrobestimer.enabled = true
		lstrobes = 1

		flashforms strobe1, 500, 50, 0

		else

		lstrobestimer.enabled = false
		lstrobes = lstrobes - lstrobes

		end if

	end if

end sub

sub rightstrobesup()

if (blackout = false) and (tilted = false) then

	rstrobesup = true
	rstrobestimer.enabled = true

end if

end sub

sub rightstrobesdown()

if (blackout = false) and (tilted = false) then

	rstrobesup = false
	rstrobes = 6
	rstrobestimer.enabled = true

end if

end sub

sub rstrobestimer_Timer()

	if rstrobesup = true then

	rstrobes = rstrobes + 1

	else

	rstrobes = rstrobes - 1

	end if

	if rstrobes = 0 then

		if multiballstrobes = true then

		rstrobestimer.enabled = true
		rstrobes = 5

		flashforms strobe6, 500, 50, 0

		else

		rstrobestimer.enabled = false
		rstrobes = rstrobes - rstrobes

		end if

	end if

	if rstrobes = 1 then
		flashforms strobe10, 500, 50, 0
	end if

	if rstrobes = 2 then
		flashforms strobe9, 500, 50, 0
	end if

	if rstrobes = 3 then
		flashforms strobe8, 500, 50, 0
	end if

	if rstrobes = 4 then
		flashforms strobe7, 500, 50, 0
	end if

	if rstrobes = 5 then
		flashforms strobe6, 500, 50, 0
	end if

	if rstrobes = 6 then

		if multiballstrobes = true then

		rstrobestimer.enabled = true
		rstrobes = 0

		flashforms strobe10, 500, 50, 0

		else

		rstrobestimer.enabled = false
		rstrobes = rstrobes - rstrobes

		end if

	end if

end sub

sub allstrobesup()

	leftstrobesup()
	rightstrobesup()

end sub

sub allstrobesdown()

	leftstrobesdown()
	rightstrobesdown()

end sub

dim faded

sub fademusic()

'	effectmusic 1, fadevolume, 0.5, 100
'	effectmusic 2, fadevolume, 0.5, 100
'	effectmusic 3, fadevolume, 0.5, 100
'	effectmusic 4, fadevolume, 0.5, 100
'	effectmusic 6, fadevolume, 0.5, 100
'	effectmusic 7, fadevolume, 0.5, 100
'	effectmusic 8, fadevolume, 0.5, 100

'	fade.enabled = true
'	faded = true

end sub

sub fade_Timer()

	'fade.enabled = false

	if song = 11 then
	
	effectmusic 1, fadevolume, 0.8, 300

	else

	effectmusic 1, fadevolume, 0.7, 300

	end if

	effectmusic 2, fadevolume, 0.8, 300
	effectmusic 3, fadevolume, 0.8, 300
	effectmusic 4, fadevolume, 0.8, 300
	effectmusic 6, fadevolume, 0.8, 300
	effectmusic 7, fadevolume, 0.8, 300
	effectmusic 8, fadevolume, 0.8, 300	

	faded = false

end sub

sub fadedelay_Timer()

	fadedelay.enabled = false
	fademusic()

end sub

sub multiballrampshow()

	if jackpotshowon = false then

		mutemusic()

		if (ramp = 1) or (ramp = 2) then

			Playsound "jycsfx44", false, 1.0

		end if

		if (ramp = 3) or (ramp = 4) then

			Playsound "jycsfx45", false, 1.0
	
		end if
	
		if (ramp = 5) or (ramp > 5) then

			Playsound "jycsfx46", false, 1.0

		end if

		mainseq.play SeqBlinking, , 16, 30

	end if

end sub

sub mutemusic()

	'effectmusic 1, fadevolume, 0.0, 300
	mutemusictimer.interval = 2600
	mutemusictimer.enabled = true

end sub

sub mutemusictimer_Timer()

	'effectmusic 1, fadevolume, 0.7, 300
	mutemusictimer.enabled = false

end sub

dim catscamp
dim catscampleft

sub catscamper()

	catscamp = 0
	catscampertimer.enabled = true

	showinprogress = true

end sub

sub catscampertimer_Timer()

if (blackout = false) and (tilted = false) then

	catscamp = catscamp + 1

	If catscamp = 1 then

		if catscampleft = true then

			hdisplay1.text = "@?              "
			hdisplay2.text = "                "

			display1.text = "@?              "
			display2.text = "                "

		else

			hdisplay1.text = "              #%"
			hdisplay2.text = "                "

			display1.text = "              #%"
			display2.text = "                "

		end if

	end if

	If catscamp = 2 then

		if catscampleft = true then

			hdisplay1.text = " @?             "
			hdisplay2.text = "                "

			display1.text = " @?             "
			display2.text = "                "

		else

			hdisplay1.text = "             #% "
			hdisplay2.text = "                "

			display1.text = "             #% "
			display2.text = "                "

		end if

	end if

	If catscamp = 3 then

		if catscampleft = true then

			hdisplay1.text = "  @?            "
			hdisplay2.text = "                "

			display1.text = "  @?            "
			display2.text = "                "

		else

			hdisplay1.text = "            #%  "
			hdisplay2.text = "                "

			display1.text = "            #%  "
			display2.text = "                "

		end if

	end if

	If catscamp = 4 then

		if catscampleft = true then

			hdisplay1.text = "?  @?           "
			hdisplay2.text = "                "

			display1.text = "?  @?           "
			display2.text = "                "

		else

			hdisplay1.text = "           #%  #"
			hdisplay2.text = "                "

			display1.text = "           #%  #"
			display2.text = "                "

		end if

	end if

	If catscamp = 5 then

		if catscampleft = true then

			hdisplay1.text = "@?  @?          "
			hdisplay2.text = "                "

			display1.text = "@?  @?          "
			display2.text = "                "

		else

			hdisplay1.text = "          #%  #%"
			hdisplay2.text = "                "

			display1.text = "          #%  #%"
			display2.text = "                "

		end if

	end if

	If catscamp = 6 then

		if catscampleft = true then

			hdisplay1.text = " @?  @?         "
			hdisplay2.text = "                "

			display1.text = " @?  @?         "
			display2.text = "                "

		else

			hdisplay1.text = "         #%  #% "
			hdisplay2.text = "                "

			display1.text = "         #%  #% "
			display2.text = "                "

		end if

	end if

	If catscamp = 7 then

		if catscampleft = true then

			hdisplay1.text = "  @?  @?        "
			hdisplay2.text = "                "

			display1.text = "  @?  @?        "
			display2.text = "                "

		else

			hdisplay1.text = "        #%  #%  "
			hdisplay2.text = "                "

			display1.text = "        #%  #%  "
			display2.text = "                "

		end if

	end if

	If catscamp = 8 then

		if catscampleft = true then

			hdisplay1.text = "   @?  @?       "
			hdisplay2.text = "                "

			display1.text = "   @?  @?       "
			display2.text = "                "

		else

			hdisplay1.text = "       #%  #%   "
			hdisplay2.text = "                "

			display1.text = "       #%  #%   "
			display2.text = "                "

		end if

	end if

	If catscamp = 9 then

		if catscampleft = true then

			hdisplay1.text = "    @?  @?      "
			hdisplay2.text = "                "

			display1.text = "    @?  @?      "
			display2.text = "                "

		else

			hdisplay1.text = "      #%  #%    "
			hdisplay2.text = "                "

			display1.text = "      #%  #%    "
			display2.text = "                "

		end if

	end if

	If catscamp = 10 then

		if catscampleft = true then

			hdisplay1.text = "     @?  @?     "
			hdisplay2.text = "                "

			display1.text = "     @?  @?     "
			display2.text = "                "

		else

			hdisplay1.text = "     #%  #%     "
			hdisplay2.text = "                "

			display1.text = "     #%  #%     "
			display2.text = "                "

		end if

	end if

	If catscamp = 11 then

		if catscampleft = true then

			hdisplay1.text = "      @?  @?    "
			hdisplay2.text = "                "

			display1.text = "      @?  @?    "
			display2.text = "                "

		else

			hdisplay1.text = "    #%  #%      "
			hdisplay2.text = "                "

			display1.text = "    #%  #%      "
			display2.text = "                "

		end if

	end if

	If catscamp = 12 then

		if catscampleft = true then

			hdisplay1.text = "       @?  @?   "
			hdisplay2.text = "                "

			display1.text = "       @?  @?   "
			display2.text = "                "

		else

			hdisplay1.text = "   #%  #%       "
			hdisplay2.text = "                "

			display1.text = "   #%  #%       "
			display2.text = "                "

		end if

	end if

	If catscamp = 13 then

		if catscampleft = true then

			hdisplay1.text = "        @?  @?  "
			hdisplay2.text = "                "

			display1.text = "        @?  @?  "
			display2.text = "                "

		else

			hdisplay1.text = "  #%  #%        "
			hdisplay2.text = "                "

			display1.text = "  #%  #%        "
			display2.text = "                "

		end if

	end if

	If catscamp = 14 then

		if catscampleft = true then

			hdisplay1.text = "         @?  @? "
			hdisplay2.text = "                "

			display1.text = "         @?  @? "
			display2.text = "                "

		else

			hdisplay1.text = " #%  #%         "
			hdisplay2.text = "                "

			display1.text = " #%  #%         "
			display2.text = "                "

		end if

	end if

	If catscamp = 15 then

		if catscampleft = true then

			hdisplay1.text = "          @?  @?"
			hdisplay2.text = "                "

			display1.text = "          @?  @?"
			display2.text = "                "

		else

			hdisplay1.text = "#%  #%          "
			hdisplay2.text = "                "

			display1.text = "#%  #%          "
			display2.text = "                "

		end if

	end if

	If catscamp = 16 then

		if catscampleft = true then

			hdisplay1.text = "           @?  @"
			hdisplay2.text = "                "

			display1.text = "           @?  @"
			display2.text = "                "

		else

			hdisplay1.text = "%  #%           "
			hdisplay2.text = "                "

			display1.text = "%  #%           "
			display2.text = "                "

		end if

	end if

	If catscamp = 17 then

		if catscampleft = true then

			hdisplay1.text = "            @?  "
			hdisplay2.text = "                "

			display1.text = "            @?  "
			display2.text = "                "

		else

			hdisplay1.text = "  #%            "
			hdisplay2.text = "                "

			display1.text = "  #%            "
			display2.text = "                "

		end if

	end if

	If catscamp = 18 then

		if catscampleft = true then

			hdisplay1.text = "             @? "
			hdisplay2.text = "                "

			display1.text = "             @? "
			display2.text = "                "

		else

			hdisplay1.text = " #%             "
			hdisplay2.text = "                "

			display1.text = " #%             "
			display2.text = "                "

		end if

	end if

	If catscamp = 19 then

		if catscampleft = true then

			hdisplay1.text = "              @?"
			hdisplay2.text = "                "

			display1.text = "              @?"
			display2.text = "                "

		else

			hdisplay1.text = "#%              "
			hdisplay2.text = "                "

			display1.text = "#%              "
			display2.text = "                "

		end if

	end if

	If catscamp = 20 then

		if catscampleft = true then

			hdisplay1.text = "               @"
			hdisplay2.text = "                "

			display1.text = "               @"
			display2.text = "                "

		else

			hdisplay1.text = "%               "
			hdisplay2.text = "                "

			display1.text = "%               "
			display2.text = "                "

		end if

	end if

	If catscamp = 21 then

		if catscampleft = true then

			hdisplay1.text = "                "
			hdisplay2.text = "                "

			display1.text = "                "
			display2.text = "                "

		else

			hdisplay1.text = "                "
			hdisplay2.text = "                "

			display1.text = "                "
			display2.text = "                "

		end if

	end if

	If catscamp = 22 then

		catscampertimer.enabled = false
		catscamp = 0

		showinprogress = false

		addscore(0)

	end if

end if

end sub

	'# - cat head facing left
	'$ - cat tail facing left straight
	'% - cat tail facing left diagnol

	'@ - cat tail facing right diagnol
	': - cat tail facing right straight
	'? - cat head facing right

	'use "#%" to draw a cat facing left with diagnol tail
	'use "@?" to draw a cat facing right with diagnol tail

	'use "#$" to draw a cat facing left with a straight tail
	'use ":?" to draw a cat facing right with a straight tail

dim atext
dim start1
dim start2
dim mballstart
dim mballrestart

sub atexttimer_Timer()

	atext = atext + 1

	if start1 = true then

		if atext = 1 then

			hdisplay1.text = " KLATUU,BARADA,NIKTU...          "
			hdisplay2.text = "                "

			display1.text = " KLATUU,BARADA,NIKTU...          "
			display2.text = "                "
            DisplayB2SText " KLATUU,BARADA,NIKTU...          "  & "                "
		end if

		if atext = 3 then

			hdisplay1.text = " KLATUU,BARADA,NIKTU...  "
			hdisplay2.text = "                "

			display1.text = " KLATUU,BARADA,NIKTU...  "
			display2.text = "                "
            DisplayB2SText " KLATUU,BARADA,NIKTU...  "  & "                "
		end if

		if atext = 7 then

			hdisplay1.text = " KLATUU,BARADA,NIKTU...  "
			hdisplay2.text = "KLATUU,BARADA,NIKTU...           "

			display1.text = " KLATUU,BARADA,NIKTU...  "
			display2.text = "KLATUU,BARADA,NIKTU...           "
            DisplayB2SText " KLATUU,BARADA,NIKTU...  "  & "KLATUU,BARADA,NIKTU...           "
		end if

		if atext = 9 then

			hdisplay1.text = " KLATUU,BARADA,NIKTU...  "
			hdisplay2.text = "KLATUU,BARADA,NIKTU...      "

			display1.text = " KLATUU,BARADA,NIKTU...  "
			display2.text = "KLATUU,BARADA,NIKTU...      "
            DisplayB2SText " KLATUU,BARADA,NIKTU...  "  & "KLATUU,BARADA,NIKTU...      "
		end if

		if atext = 11 then

			hdisplay1.text = " KLATUU,BARADA,NIKTU...  "
			hdisplay2.text = "KLATUU,BARADA,NIKTU..."

			display1.text = " KLATUU,BARADA,NIKTU...  "
			display2.text = "KLATUU,BARADA,NIKTU..."
            DisplayB2SText2 " KLATUU,BARADA,NIKTU...  "  & "KLATUU,BARADA,NIKTU..."
		end if

		if atext = 12 then

			atexttimer.enabled = false
			atext = atext - atext
			start1 = false

		end if


	end if

	if start2 = true then

		if atext = 1 then

			hdisplay1.text = "   WELCOME      "
			hdisplay2.text = "                "

			display1.text = "   WELCOME      "
			display2.text = "                "
            DisplayB2SText "   WELCOME      "  & "                "
		end if

		if atext = 3 then

			hdisplay1.text = "   WELCOME    "
			hdisplay2.text = "                "

			display1.text = "   WELCOME    "
			display2.text = "                "
            DisplayB2SText "   WELCOME    "  & "                "
		end if

		if atext = 5 then

			hdisplay1.text = "   WELCOME   "
			hdisplay2.text = "TIME TRAVELER        "

			display1.text = "   WELCOME    "
			display2.text = "TIME TRAVELER         "
            DisplayB2SText "   TIME TRAVELER      "  & "ASH WILLIAMAS         "
		end if

		if atext = 11 then

			hdisplay1.text = "   WELCOME   "
			hdisplay2.text = "TIME TRAVELER   "

			display1.text = "   WELCOME   "
			display2.text = "TIME TRAVELER   "
            DisplayB2SText "   TIME TRAVELER      "  & "ASH WILLIAMAS   "
		end if

		if atext = 14 then

			hdisplay1.text = "   WELCOME   "
			hdisplay2.text = "TIME TRAVELER"

			display1.text = "   WELCOME   "
			display2.text = "TIME TRAVELER"
            DisplayB2SText2 "   TIME TRAVELER      "  & "ASH WILLIAMS"
		end if

		if atext = 15 then

			atexttimer.enabled = false
			atext = atext - atext
			start2 = false

		end if

	end if

	if mballstart = true then
            DMDUpdate.Enabled = 0
		if atext = 1 then

			showtimer.enabled = false
			showinprogress = false

			hdisplay1.text = "   ATTENTION    "
			hdisplay2.text = "                "

			display1.text = "   ATTENTION    "
			display2.text = "                "
            DisplayB2SText "   ATTENTION    "  & "                "
		end if

		if atext = 9 then

			hdisplay1.text = "   ATTENTION    "
			hdisplay2.text = " EVIL DEAD           "

			display1.text = "   ATTENTION    "
			display2.text = " EVIL DEAD           "
            DisplayB2SText "   ATTENTION    "  & " EVIL           "
		end if

		if atext = 13 then

			hdisplay1.text = "   ATTENTION    "
			hdisplay2.text = " EVIL DEAD       "

			display1.text = "   ATTENTION    "
			display2.text = " EVIL DEAD       "
            DisplayB2SText "   ATTENTION    "  & " EVIL DEAD       "
		end if

		if atext = 18 then

			hdisplay1.text = "   ATTENTION    "
			hdisplay2.text = " ARMY OF DARKNESS  "

			display1.text = "   ATTENTION    "
			display2.text = " ARMY OF DARKNESS  "
            DisplayB2SText2 "   ATTENTION    "  & " ARMY OF DARKNESS  "
		end if

		if atext = 26 then

			hdisplay1.text = "  YOU           "
			hdisplay2.text = "                "

			display1.text = "  YOU           "
			display2.text = "                "
            DisplayB2SText "  YOU           "  & "                "
		end if

		if atext = 27 then

			hdisplay1.text = "  YOU ENTERED THE       "
			hdisplay2.text = "                "

			display1.text = "  YOU ARE ENTERED THE      "
			display2.text = "                "
            DisplayB2SText "  YOU ARE ENTERED THE      "  & "                "
		end if

		if atext = 30 then

			hdisplay1.text = "  YOU ENTERED THE OLD GRAVEYARD.   "
			hdisplay2.text = "                "

			display1.text = "  YOU ENTERED THE OLD GRAVEYARD.   "
			display2.text = "                "
            DisplayB2SText "  YOU ENTERED THE OLD GRAVEYARD.   "  & "                "
		end if

		if atext = 34 then

			hdisplay1.text = "  YOU ENTERED THE   "
			hdisplay2.text = "   OLD GRAVEYARD    "

			display1.text = "  YOU ENTERED THE   "
			display2.text = "   OLD GRAVEYARD    "
            DisplayB2SText2 "  YOU ENTERED THE.   "  & "   OLD GRAVEYARD    "
		end if

		if atext = 41 then

			hdisplay1.text = "OPEN             "
			hdisplay2.text = "                "

			display1.text = "OPEN             "
			display2.text = "                "
            DisplayB2SText "OPEN             "  & "                "
		end if

		if atext = 44 then

			hdisplay1.text = "OPEN THE         "
			hdisplay2.text = "                "

			display1.text = "OPEN THE         "
			display2.text = "                "
            DisplayB2SText "OPEN THE         "  & "                "
		end if

		if atext = 47 then

			hdisplay1.text = "OPEN THE BOOK"
			hdisplay2.text = "                "

			display1.text = "OPEN THE BOOK"
			display2.text = "                "
            DisplayB2SText2 "OPEN THE BOOK"  & "                "
		end if

		if atext = 60 then

			'hdisplay1.slowblinkspeed = 30
			'hdisplay2.slowblinkspeed = 30

			hdisplay1.text = " SHOOT CHAINSHAW AREA "', seblink, 2000
			hdisplay2.text = "TO LIGHT JACKPOT"', seblink, 2000

			'display1.slowblinkspeed = 30
			'display2.slowblinkspeed = 30

			display1.text = " SHOOT CHAINSHAW AREA "', seblink, 2000
			display2.text = "TO LIGHT JACKPOT"', seblink, 2000
            DisplayB2SText2 " SHOOT CHAINSHAW AREA "  & "TO LIGHT JACKPOT"
		end if

		if atext = 61 then

			atexttimer.enabled = false
			atext = atext - atext
			mballstart = false
			faded = false

		end if

	end if

	if mballrestart = true then

		if atext = 1 then

			'playmusic 6, "jycsfx2", false, 0.6

			hdisplay1.text = " THIS IS MY BOOMSTICK!         "
			hdisplay2.text = "                "

			display1.text = " THIS IS MY BOOMSTICK!         "
			display2.text = "                "
            DisplayB2SText "THIS IS MY BOOMSTICK!         "  & "                "
		end if

		if atext = 9 then

			hdisplay1.text = " THIS IS MY BOOMSTICK! "
			hdisplay2.text = "                "

			display1.text = " THIS IS MY BOOMSTICK! "
			display2.text = "                "
            DisplayB2SText " THIS IS MY BOOMSTICK! "  & "                "
		end if

		if atext = 18 then

			hdisplay1.text = " THIS IS MY BOOMSTICK! "
			hdisplay2.text = "     THIS IS MY BOOMSTICK!     "

			display1.text = " THIS IS MY BOOMSTICK! "
			display2.text = "     THIS IS MY BOOMSTICK!     "
            DisplayB2SText2 " THIS IS MY BOOMSTICK! "  & "     THIS IS MY BOOMSTICK!     "
			song = 5
			playsong2()

		end if

		if atext = 24 then

			'Lookatplayfield()
			Triggermultiballrestart()
			multiballshowon = false

		end if

		if atext = 24 then

			atexttimer.enabled = false
			atext = atext - atext
			mballrestart = false

		end if


	end if

end sub

sub killatext()

	atexttimer.enabled = false
	atext = atext - atext
	start1 = false
	start2 = false
	mballstart = false
	mballrestart = false

end sub

Sub Triggermultiballrestart()

	multiballs = 1
	multiballsavertimer.enabled = true
	autolaunchball()

	startmultiballstrobes()

	playsound "jycsfx62"', false, 0.4

	TurnGIon()
	'mainseq.stopplay()

	If ballsinscoop > 0 then

	scooptimer.enabled = true

	else

	leftlocktimer.enabled = true

	end if

end sub

sub rubber26_hit()

	if (blackout = false) and (tilted = false) then
	
	addscore(10)
	addmatch()

		if faded = false then

		playsound "jycsfx16"', false, 0.4

		end if

	end if

end sub

sub bank1_hit()
	
	if (blackout = false) and (tilted = false) then
	
	addscore(10)
	addmatch()

		if faded = false then

		playsound "jycsfx16"', false, 0.4

		end if

	end if

end sub

sub bank2_hit()
	
	if (blackout = false) and (ilted = false) then
	
	addscore(10)
	addmatch()

		if faded = false then

		playsound "jycsfx16"', false, 0.4

		end if

	end if

end sub

sub rampvalue()

	if multiballrestart = false then

	'hdisplay1.flushqueue()
	'hdisplay2.flushqueue()

	'display1.flushqueue()
	'display2.flushqueue()

	showinprogress = true
	showtimer.interval = 3110
	showtimer.enabled = true

	'hdisplay2.slowblinkspeed = 30

	hdisplay1.text = "   RAMP VALUE   "', sescrollrightover, 100
	hdisplay2.text = "     " & ((ramp*25000) + 25000) & "     "', sescrollleftover, 100

	hdisplay2.text = "     " & ((ramp*25000) + 25000) & "     "', seblinkmask, 3000

	'display2.slowblinkspeed = 30

	display1.text = "   RAMP VALUE   "', sescrollrightover, 100
	display2.text = "     " & ((ramp*25000) + 25000) & "     "', sescrollleftover, 100

	display2.text = "     " & ((ramp*25000) + 25000) & "     "', seblinkmask, 3000
    DisplayB2SText2 "   RAMP VALUE   "  & "     " & ((ramp*25000) + 25000) & "     "
	addscore((ramp*25000) + 25000)
	addbonuspoints(1000)

	giquickflicker()

	end if

end sub

sub doublerampvalue()

	if multiballrestart = false then

	'hdisplay1.flushqueue()
	'hdisplay2.flushqueue()

	'display1.flushqueue()
	'display2.flushqueue()

	showinprogress = true
	showtimer.interval = 3110
	showtimer.enabled = true

	'hdisplay2.slowblinkspeed = 30

	hdisplay1.text = " 2X RAMP VALUE  "', sescrollrightover, 100
	hdisplay2.text = "    " & (((ramp*25000) + 25000)*2) & "      "', sescrollleftover, 100

	hdisplay2.text = "    " & (((ramp*25000) + 25000)*2) & "      "', seblinkmask, 3000

	'display2.slowblinkspeed = 30

	display1.text = " 2X RAMP VALUE  "', sescrollrightover, 100
	display2.text = "    " & (((ramp*25000) + 25000)*2) & "      "', sescrollleftover, 100

	display2.text = "    " & (((ramp*25000) + 25000)*2) & "      "', seblinkmask, 3000
    DisplayB2SText2 " 2X RAMP VALUE  "  & "     " & ((ramp*25000) + 25000) & "     "
	addscore(((ramp*25000) + 25000)*2)
	addbonuspoints(2000)

	giquickflicker()

	end if

end sub

sub triplerampvalue()

	if multiballrestart = false then

	'hdisplay1.flushqueue()
	'hdisplay2.flushqueue()

	'display1.flushqueue()
	'display2.flushqueue()

	showinprogress = true
	showtimer.interval = 3110
	showtimer.enabled = true

	'hdisplay2.slowblinkspeed = 30

	hdisplay1.text = " 3X RAMP VALUE  "', sescrollrightover, 100
	hdisplay2.text = "    " & (((ramp*25000) + 25000)*3) & "      "', sescrollleftover, 100

	hdisplay2.text = "    " & (((ramp*25000) + 25000)*3) & "      "', seblinkmask, 3000

	'display2.slowblinkspeed = 30

	display1.text = " 3X RAMP VALUE  "', sescrollrightover, 100
	display2.text = "    " & (((ramp*25000) + 25000)*3) & "      "', sescrollleftover, 100

	display2.text = "    " & (((ramp*25000) + 25000)*3) & "      "', seblinkmask, 3000

    DisplayB2SText2 " 3X RAMP VALUE  "  & "     " & ((ramp*25000) + 25000) & "     "
	addscore(((ramp*25000) + 25000)*3)
	addbonuspoints(3000)

	giquickflicker()

	end if

end sub

sub startsuperjets()
	
	superjets = true

	bumper1l.State = Bulbblink', "10", 150
	bumper2l.State = Bulbblink', "10", 150
	bumper3l.State = Bulbblink', "10", 150

end sub

sub endsuperjets()

	superjets = false

	bumper1l.State = Bulbon', "10", 150
	bumper2l.State = Bulbon', "10", 150
	bumper3l.State = Bulbon', "10", 150

end sub





'********************
'     Flippers
'********************

Sub SolLFlipper(Enabled)
'	startB2S(4)
    If Enabled Then
        PlaySound SoundFXDOF("fx_flipperup", 101, DOFOn, DOFFlippers), 0, 1, -0.05, 0.15
        LeftFlipper.RotateToEnd
        shiftCLAWlanesleft
        shiftCATlanesleft
        
    Else
        PlaySound SoundFXDOF("fx_flipperdown", 101, DOFOff, DOFFlippers), 0, 1, -0.05, 0.15
        LeftFlipper.RotateToStart
    End If
End Sub

Sub SolRFlipper(Enabled)
'	startB2S(4)
    If Enabled Then
        PlaySound SoundFXDOF("fx_flipperup", 102, DOFOn, DOFFlippers), 0, 1, 0.05, 0.15
        RightFlipper.RotateToEnd
        Upperflipper.RotateToEnd
        shiftCLAWlanesRight
        shiftCATlanesRight
    Else
        PlaySound SoundFXDOF("fx_flipperdown", 102, DOFOff, DOFFlippers), 0, 1, 0.05, 0.15
        RightFlipper.RotateToStart
        Upperflipper.RotateToStart
    End If
End Sub

' flippers hit Sound

Sub LeftFlipper_Collide(parm)
    PlaySound "fx_rubber_flipper", 0, parm / 10, -0.05, 0.25
End Sub

Sub RightFlipper_Collide(parm)
    PlaySound "fx_rubber_flipper", 0, parm / 10, 0.05, 0.25
End Sub




'*********
' TILT
'*********

'NOTE: The TiltDecreaseTimer Subtracts .01 from the "Tilt" variable every round

Sub CheckTilt                                    'Called when table is nudged

    Tilt = Tilt + TiltSensitivity                'Add to tilt count
    TiltDecreaseTimer.Enabled = True
    If(Tilt> TiltSensitivity) AND(Tilt <15) Then 'show a warning
        'DMDFlush
        hdisplay1.text = "CAREFUL!"
        DisplayB2SText "CAREFUL!"
        Playsound "jycsfx26"
    End if
    If Tilt> 15 Then 'If more that 15 then TILT the table
        Tilted = True
        Playsound "spchkittenme"
        'display Tilt
        DMDUpdate.Enabled = 0
        hdisplay1.text = "TILT!"
        DisplayB2SText "      TILT!     "
        DisableTable True
        TiltRecoveryTimer.Enabled = True 'start the Tilt delay to check for all the balls to be drained
    End If
End Sub

Sub TiltDecreaseTimer_Timer
    ' DecreaseTilt
    If Tilt> 0 Then
        Tilt = Tilt - 0.1
    Else
        TiltDecreaseTimer.Enabled = False
    End If
End Sub

Sub DisableTable(Enabled)
    If Enabled Then
        'turn off GI and turn off all the lights
        GiOff
        LightSeqTilt.Play SeqAllOff
        'Disable slings, bumpers etc
        LeftFlipper.RotateToStart
        RightFlipper.RotateToStart
		DOF 101, DOFOff
		DOF 102, DOFOff
        Bumper1.Force = 0
        Bumper2.Force = 0
        Bumper3.Force = 0
        LeftSlingshotRubber.Disabled = 1
        RightSlingshotRubber.Disabled = 1
    Else
        'turn back on GI and the lights
        GiOn
        LightSeqTilt.StopPlay
        'Bumper1.Force = 6
        LeftSlingshotRubber.Disabled = 0
        RightSlingshotRubber.Disabled = 0
        'clean up the buffer display
    '    DMDFlush
    End If
End Sub

Sub TiltRecoveryTimer_Timer()
    ' if all the balls have been drained then..
    If(BallsOnPlayfield = 0) Then
        ' do the normal end of ball thing (this doesn't give a bonus if the table is tilted)
        EndOfBall()
        TiltRecoveryTimer.Enabled = False
    End If
' else retry (checks again in another second or so)
End Sub







'**********************
'     GI effects
' independent routine
' it turns on the gi
' when there is a ball
' in play
'**********************

Dim OldGiState
OldGiState = -1   'start witht the Gi off

Sub ChangeGi(col) 'changes the gi color
    Dim bulb
    For each bulb in aGILights
        SetLightColor bulb, col, -1
    Next
End Sub

Sub GIUpdateTimer_Timer
    Dim tmp, obj
    tmp = Getballs
    If UBound(tmp) <> OldGiState Then
        OldGiState = Ubound(tmp)
        If UBound(tmp) = 0 Then 'we have 4 captive balls on the table (-1 means no balls, 0 is the first ball, 1 is the second..)
            GiOff               ' turn off the gi if no active balls on the table, we could also have used the variable ballsonplayfield.
        Else
            Gion
        End If
    End If
End Sub

Sub GiOn
    DOF 127, DOFOn
    Dim bulb
    For each bulb in aGiLights
        bulb.State = 1
    Next
    Table1.ColorGradeImage = "ColorGradeLUT256x16_ConSat"
End Sub

Sub GiOff
    DOF 127, DOFOff
    Dim bulb
    For each bulb in aGiLights
        bulb.State = 0
    Next
    Table1.ColorGradeImage = "ColorGradeLUT256x16_ConSatDark"
End Sub



' GI & light sequence effects

Sub GiEffect(n)
    Dim ii
    Select Case n
        Case 0 'all off
            LightSeqGi.Play SeqAlloff
        Case 1 'all blink
            LightSeqGi.UpdateInterval = 10
            LightSeqGi.Play SeqBlinking, , 10, 10
        Case 2 'random
            LightSeqGi.UpdateInterval = 10
            LightSeqGi.Play SeqRandom, 50, , 1000
        Case 3 'upon
            LightSeqGi.UpdateInterval = 4
            LightSeqGi.Play SeqUpOn, 5, 1
        Case 4 ' left-right-left
            LightSeqGi.UpdateInterval = 5
            LightSeqGi.Play SeqLeftOn, 10, 1
            LightSeqGi.UpdateInterval = 5
            LightSeqGi.Play SeqRightOn, 10, 1
    End Select
End Sub

Sub LightEffect(n)
    Select Case n
        Case 0 ' all off
            LightSeqInserts.Play SeqAlloff
        Case 1 'all blink
            LightSeqInserts.UpdateInterval = 10
            LightSeqInserts.Play SeqBlinking, , 10, 10
        Case 2 'random
            LightSeqInserts.UpdateInterval = 10
            LightSeqInserts.Play SeqRandom, 50, , 1000
        Case 3 'upon
            LightSeqInserts.UpdateInterval = 4
            LightSeqInserts.Play SeqUpOn, 10, 1
        Case 4 ' left-right-left
            LightSeqInserts.UpdateInterval = 5
            LightSeqInserts.Play SeqLeftOn, 10, 1
            LightSeqInserts.UpdateInterval = 5
            LightSeqInserts.Play SeqRightOn, 10, 1
    End Select
End Sub

' Flasher Effects using lights

Dim FEStep, FEffect
FEStep = 0
FEffect = 0

Sub FlashEffect(n)
    Dim ii
    Select case n
        Case 0 ' all off
            LightSeqFlasher.Play SeqAlloff
        Case 1 'all blink
            LightSeqFlasher.UpdateInterval = 10
            LightSeqFlasher.Play SeqBlinking, , 10, 10
        Case 2 'random
            LightSeqFlasher.UpdateInterval = 10
            LightSeqFlasher.Play SeqRandom, 50, , 1000
        Case 3 'upon
            LightSeqFlasher.UpdateInterval = 4
            LightSeqFlasher.Play SeqUpOn, 10, 1
        Case 4 ' left-right-left
            LightSeqFlasher.UpdateInterval = 5
            LightSeqFlasher.Play SeqLeftOn, 10, 1
            LightSeqFlasher.UpdateInterval = 5
            LightSeqFlasher.Play SeqRightOn, 10, 1
    End Select
End Sub


'****************************************
' Real Time updatess using the GameTimer
'****************************************
'used for all the real time updates

Sub GameTimer_Timer
    RollingUpdate
    BallShadowUpdate
    FlashersUpdate()

	leftdiverterP.objRotZ = leftdiverter.CurrentAngle
    rightdiverterP.objRotZ = rightdiverter.CurrentAngle


End Sub


'********************************************************************************************
' Only for VPX 10.2 and higher.
' FlashForMs will blink light or a flasher for TotalPeriod(ms) at rate of BlinkPeriod(ms)
' When TotalPeriod done, light or flasher will be set to FinalState value where
' Final State values are:   0=Off, 1=On, 2=Return to previous State
'********************************************************************************************

Sub FlashForMs(MyLight, TotalPeriod, BlinkPeriod, FinalState) 'thanks gtxjoe for the first version

    If TypeName(MyLight) = "Light" Then

        If FinalState = 2 Then
            FinalState = MyLight.State 'Keep the current light state
        End If
        MyLight.BlinkInterval = BlinkPeriod
        MyLight.Duration 2, TotalPeriod, FinalState
    ElseIf TypeName(MyLight) = "Flasher" Then

        Dim steps

        ' Store all blink information
        steps = Int(TotalPeriod / BlinkPeriod + .5) 'Number of ON/OFF steps to perform
        If FinalState = 2 Then                      'Keep the current flasher state
            FinalState = ABS(MyLight.Visible)
        End If
        MyLight.UserValue = steps * 10 + FinalState 'Store # of blinks, and final state

        ' Start blink timer and create timer subroutine
        MyLight.TimerInterval = BlinkPeriod
        MyLight.TimerEnabled = 0
        MyLight.TimerEnabled = 1
        ExecuteGlobal "Sub " & MyLight.Name & "_Timer:" & "Dim tmp, steps, fstate:tmp=me.UserValue:fstate = tmp MOD 10:steps= tmp\10 -1:Me.Visible = steps MOD 2:me.UserValue = steps *10 + fstate:If Steps = 0 then Me.Visible = fstate:Me.TimerEnabled=0:End if:End Sub"
    End If
End Sub




' *********************************************************************
'               Funciones para los sonidos de la mesa
' *********************************************************************

Function Vol(ball) ' Calcula el volumen del sonido basado en la velocidad de la bola
    Vol = Csng(BallVel(ball) ^2 / 2000)
End Function

Function Pan(ball) ' Calculala posición estéreo de la bola (izquierda a derecha)
    Dim tmp
    tmp = ball.x * 2 / table1.width-1
    If tmp > 0 Then
        Pan = Csng(tmp ^10)
    Else
        Pan = Csng(-((- tmp) ^10))
    End If
End Function

Function Pitch(ball) ' Calcula el tono según la velocidad de la bola
    Pitch = BallVel(ball) * 20
End Function

Function BallVel(ball) 'Calcula la velocidad de la bola
    BallVel = INT(SQR((ball.VelX ^2) + (ball.VelY ^2)))
End Function

Function AudioFade(ball) 'Solo para VPX 10.4 y siguentes: calcula la posición de arriba/abajo de la bola, para mesas con el sonido dolby
    Dim tmp
    tmp = ball.y * 2 / Table1.height-1
    If tmp > 0 Then
        AudioFade = Csng(tmp ^10)
    Else
        AudioFade = Csng(-((- tmp) ^10))
    End If
End Function

Sub PlaySoundAt(soundname, tableobj) ' Hace sonar un sonido en la posición de un objeto, como bumpers y flippers
    PlaySound soundname, 0, 1, Pan(tableobj), 0, 0, 0, 0, AudioFade(tableobj)
End Sub

Sub PlaySoundAtBall(soundname) ' hace sonar un sonido en la posición de la bola
    PlaySound soundname, 0, Vol(ActiveBall), pan(ActiveBall), 0, Pitch(ActiveBall), 0, 0, AudioFade(ActiveBall)
End Sub

'*****************************************
'      Los sonidos de la bola/s rodando
'*****************************************

Const tnob = 8 ' número total de bola
Const lob = 1  'número de bola encerradas
ReDim rolling(tnob)
InitRolling

Sub InitRolling
    Dim i
    For i = 0 to tnob
        rolling(i) = False
    Next
End Sub

Sub RollingUpdate()
    Dim BOT, b, ballpitch
    BOT = GetBalls

    ' para el sonido de bolas perdidas
    For b = UBound(BOT) + 1 to tnob
        rolling(b) = False
        StopSound("fx_ballrolling" & b)
    Next

    ' sale de la rutina si no hay más bolas en la mesa
    If UBound(BOT) = lob - 1 Then Exit Sub

    ' hace sonar el sonido de la bola rodando para cada bola
    For b = lob to UBound(BOT)
        If BallVel(BOT(b)) > 1 Then
            If BOT(b).z < 30 Then
                ballpitch = Pitch(BOT(b))
            Else
                ballpitch = Pitch(BOT(b)) + 20000 'aumenta el tono del sonido si la bola está sobre una rampa
            End If
            rolling(b) = True
            PlaySound("fx_ballrolling" & b), -1, Vol(BOT(b)), Pan(BOT(b)), 0, ballpitch, 1, 0, AudioFade(BOT(b))
        Else
            If rolling(b) = True Then
                StopSound("fx_ballrolling" & b)
                rolling(b) = False
            End If
        End If
    Next
End Sub

'*****************************
' Sonido de las bolas chocando
'*****************************

Sub OnBallBallCollision(ball1, ball2, velocity)
    PlaySound "fx_collide", 0, Csng(velocity) ^2 / 2000, Pan(ball1), 0, Pitch(ball1), 0, 0, AudioFade(ball1)
End Sub





'*********** BALL SHADOW *********************************
Dim BallShadow
BallShadow = Array (BallShadow1, BallShadow2, BallShadow3, BallShadow4, BallShadow5, BallShadow6)

Sub BallShadowUpdate()
    Dim BOT, b
    BOT = GetBalls
	' render the shadow for each ball
    For b = 0 to Ubound(BOT)
		If BOT(b).X < Table1.Width/2 Then
			BallShadow(b).X = ((BOT(b).X) - (Ballsize/6) + ((BOT(b).X - (Table1.Width/2))/10)) + 10
		Else
			BallShadow(b).X = ((BOT(b).X) + (Ballsize/6) + ((BOT(b).X - (Table1.Width/2))/10)) - 10
		End If
	    ballShadow(b).Y = BOT(b).Y + 15
		If BOT(b).Z > 20 Then
			BallShadow(b).visible = 1
		Else
			BallShadow(b).visible = 0
		End If
	Next
End Sub



'******************************
' Diverse Collection Hit Sounds
'******************************

Sub aMetals_Hit(idx):PlaySound "fx_MetalHit", 0, Vol(ActiveBall), pan(ActiveBall), 0, Pitch(ActiveBall), 0, 0:End Sub
Sub aRubber_Bands_Hit(idx):PlaySound "fx_rubber", 0, Vol(ActiveBall), pan(ActiveBall), 0, Pitch(ActiveBall), 0, 0:End Sub
Sub aRubber_Posts_Hit(idx):PlaySound "fx_rubber", 0, Vol(ActiveBall), pan(ActiveBall), 0, Pitch(ActiveBall), 0, 0:End Sub
Sub aRubber_Pins_Hit(idx):PlaySound "fx_rubber", 0, Vol(ActiveBall), pan(ActiveBall), 0, Pitch(ActiveBall), 0, 0:End Sub
Sub aPlastics_Hit(idx):PlaySound "fx_plastichit", 0, Vol(ActiveBall), pan(ActiveBall), 0, Pitch(ActiveBall), 0, 0:End Sub
Sub aDropTargets_Hit(idx):PlaySound "fx_target", 0, Vol(ActiveBall), pan(ActiveBall), 0, Pitch(ActiveBall), 0, 0:End Sub
Sub aGates_Hit(idx):PlaySound "fx_Gate", 0, Vol(ActiveBall), pan(ActiveBall), 0, Pitch(ActiveBall), 0, 0:End Sub
Sub aWoods_Hit(idx):PlaySound "fx_Woodhit", 0, Vol(ActiveBall), pan(ActiveBall), 0, Pitch(ActiveBall), 0, 0:End Sub


Sub RHelp2_Hit()
    StopSound "fx_metalrolling"
    PlaySound "fx_ballrampdrop", 0, 1, pan(ActiveBall)
End Sub

Sub LHelp1_Hit()
    StopSound "fx_metalrolling"
    PlaySound "fx_ballrampdrop", 0, 1, pan(ActiveBall)
End Sub


Sub Trigger1_hit()
    PlaySound "fx_metalrolling", 0, 1, pan(ActiveBall)
End Sub


'Sub Trigger2_hit()
'    PlaySound "fx_metalrolling", 0, 1, pan(ActiveBall)
'End Sub

' *********************************************************************
'                        User Defined Script Events
' *********************************************************************

' Initialise the Table for a new Game
'

Sub StopGameOverSong
    PlaySong "mu_end"
    StopSound Song:Song = ""
    StopAllSounds
End Sub








'******
' Keys
'******

Sub Table1_KeyDown(ByVal Keycode)

  If BootE = True Then Exit Sub
    If Keycode = AddCreditKey Then
        Credits = Credits + 1
		DOF 126, DOFOn
        If(Tilted = False) Then
            PlaySound "fx_coin"
          	startB2S (31)
            DisplayB2SText2 " CREDITS " &credits
            hdisplay1.Text = " CREDITS " &credits
            PlaySound "go"
       '     If NOT bGameInPlay Then ShowTableInfo:
        End If
    End If

    If keycode = PlungerKey Then
        PlungerIM.AutoFire
       If bBallInPlungerLane Then DOF 125, DOFPulse: DOF 114, DOFPulse
    End If

    If bGameInPlay AND NOT Tilted Then
        If keycode = LeftTiltKey Then Nudge 90, 8:PlaySound "fx_nudge", 0, 1, -0.1, 0.25:CheckTilt
        If keycode = RightTiltKey Then Nudge 270, 8:PlaySound "fx_nudge", 0, 1, 0.1, 0.25:CheckTilt
        If keycode = CenterTiltKey Then LevelAnim :Nudge 0, 9:PlaySound "fx_nudge", 0, 1, 1, 0.25:CheckTilt

        If keycode = LeftFlipperKey Then SolLFlipper 1
        If keycode = RightFlipperKey Then SolRFlipper 1


        If keycode = StartGameKey And bAttractMode = True Then
            If((PlayersPlayingGame < MaxPlayers) AND(bOnTheFirstBall = True) ) Then

                If(bFreePlay = True) Then
                    PlayersPlayingGame = PlayersPlayingGame + 1
                    TotalGamesPlayed = TotalGamesPlayed + 1
                Else

                    If(Credits > 0) then
                        PlayersPlayingGame = PlayersPlayingGame + 1
                        TotalGamesPlayed = TotalGamesPlayed + 1
                        Credits = Credits - 1
						If Credits < 1 Then DOF 126, DOFOff
                    Else
                        ' Not Enough Credits to start a game.

                        'DMD CenterLine(0, "CREDITS " & Credits), CenterLine(1, "INSERT COIN"), 0, eNone, eBlink, eNone, 500, True, ""
                    End If
                End If
            End If
        End If
        Else ' If (GameInPlay)

            If keycode = StartGameKey And bAttractMode = True Then

                If(bFreePlay = True) Then
                    If(BallsOnPlayfield = 0) Then
                        ResetForNewGame()
                    End If
                Else
                    If(Credits > 0) Then
                        If(BallsOnPlayfield = 0) Then
                            Credits = Credits - 1
							If Credits < 1 Then DOF 126, DOFOff
                            ResetForNewGame()
                        End If
                    Else
                        ' Not Enough Credits to start a game.
                        hdisplay1.Text = " CREDITS " &credits&"   INSERT COIN"
                        DisplayB2SText2 "   CREDITS " &credits &"      INSERT COIN "
                        
                    End If
                End If
            End If
    End If ' If (GameInPlay)


    If hsbModeActive Then EnterHighScoreKey(keycode)

    If SpecialhsbModeActive Then EnterSpecialHighScoreKey(keycode)

' Table specific
End Sub

Sub Table1_KeyUp(ByVal keycode)
    If bGameInPLay AND NOT Tilted Then
        If keycode = LeftFlipperKey Then SolLFlipper 0
        If keycode = RightFlipperKey Then SolRFlipper 0
    End If
End Sub


Sub InstantInfoTimer_Timer
    InstantInfoTimer.Enabled = False
    bInstantInfo = True
'    DMDFlush
'    UltraDMDTimer.Enabled = 1
End Sub

Sub InstantInfo
     hdisplay1.Text = " POW " &POWBonusCount
 '   Jackpot = 1000000 + Round(Score(CurrentPlayer) / 10, 0)
 '   DMD "black.jpg", "", "INSTANT INFO", 500
 '   DMD "black.jpg", "JACKPOT", Jackpot, 800
 '   DMD "black.jpg", "LEVEL", Level(CurrentPlayer), 800
 '   DMD "black.jpg", "BONUS MULT", BonusMultiplier(CurrentPlayer), 800
 '   DMD "black.jpg", "ORBIT BONUS", OrbitHits, 800
  '  DMD "black.jpg", "LANE BONUS", LaneBonus, 800
   ' DMD "black.jpg", "TARGET BONUS", TargetBonus, 800
  '  DMD "black.jpg", "RAMP BONUS", RampBonus, 800
 '   DMD "black.jpg", "MONSTERS KILLED", Monsters(CurrentPlayer), 800
End Sub


'*************
' Pause Table
'*************

Sub table1_Paused
End Sub

Sub table1_unPaused
End Sub

Sub table1_Exit
    Savehs
    If B2SOn Then Controller.Stop
End Sub

Sub AwardSpecial()
    'DMD " ", "EXTRA GAME", 2000
    hdisplay1.text = "EXTRA GAME"& "    CREDITS:  "& Credits
    PlaySound "fx_knocker"
    Credits = Credits + 1
    DisplayB2SText2 "   EXTRA GAME   " & "    CREDITS:  "& Credits
    LightEffect 2
    FlashEffect 2
End Sub

'*****************************
'    Load / Save / Highscore
'*****************************

Sub Loadhs
    Dim x
    x = LoadValue(TableName, "HighScore1")
    If(x <> "") Then HighScore(0) = CDbl(x) Else HighScore(0) = 900000 End If

    x = LoadValue(TableName, "HighScore1Name")
    If(x <> "") Then HighScoreName(0) = x Else HighScoreName(0) = "AAA" End If

    x = LoadValue(TableName, "HighScore2")
    If(x <> "") then HighScore(1) = CDbl(x) Else HighScore(1) = 850000 End If

    x = LoadValue(TableName, "HighScore2Name")
    If(x <> "") then HighScoreName(1) = x Else HighScoreName(1) = "BBB" End If

    x = LoadValue(TableName, "HighScore3")
    If(x <> "") then HighScore(2) = CDbl(x) Else HighScore(2) = 800000 End If

    x = LoadValue(TableName, "HighScore3Name")
    If(x <> "") then HighScoreName(2) = x Else HighScoreName(2) = "CCC" End If

    x = LoadValue(TableName, "HighScore4")
    If(x <> "") then HighScore(3) = CDbl(x) Else HighScore(3) = 750000 End If

    x = LoadValue(TableName, "HighScore4Name")
    If(x <> "") then HighScoreName(3) = x Else HighScoreName(3) = "DDD" End If



    x = LoadValue(TableName, "SpecialHighScore1")
    If(x <> "") Then SpecialHighScore(0) = CDbl(x) Else SpecialHighScore(0) = 4 End If

    x = LoadValue(TableName, "SpecialHighScore1Name")
    If(x <> "") Then SpecialHighScoreName(0) = x Else SpecialHighScoreName(0) = "AAA" End If

    x = LoadValue(TableName, "SpecialHighScore2")
    If(x <> "") then SpecialHighScore(1) = CDbl(x) Else SpecialHighScore(1) = 3 End If

    x = LoadValue(TableName, "SpecialHighScore2Name")
    If(x <> "") then SpecialHighScoreName(1) = x Else SpecialHighScoreName(1) = "BBB" End If

    x = LoadValue(TableName, "SpecialHighScore3")
    If(x <> "") then SpecialHighScore(2) = CDbl(x) Else SpecialHighScore(2) = 2 End If

    x = LoadValue(TableName, "SpecialHighScore3Name")
    If(x <> "") then SpecialHighScoreName(2) = x Else SpecialHighScoreName(2) = "CCC" End If

    x = LoadValue(TableName, "SpecialHighScore4")
    If(x <> "") then SpecialHighScore(3) = CDbl(x) Else SpecialHighScore(3) = 1 End If

    x = LoadValue(TableName, "SpecialHighScore4Name")
    If(x <> "") then SpecialHighScoreName(3) = x Else SpecialHighScoreName(3) = "DDD" End If



    x = LoadValue(TableName, "Credits")
    If(x <> "") then Credits = CInt(x) Else Credits = 0 End If

    x = LoadValue(TableName, "TotalGamesPlayed")
    If(x <> "") then TotalGamesPlayed = CInt(x) Else TotalGamesPlayed = 0 End If

  '  x = LoadValue(TableName, "Score")
  '  If(x <> "") then Score(CurrentPlayer) = CInt(x) Else Score(CurrentPlayer) = 0 End If
End Sub

Sub Savehs
    SaveValue TableName, "HighScore1", HighScore(0)
    SaveValue TableName, "HighScore1Name", HighScoreName(0)
    SaveValue TableName, "HighScore2", HighScore(1)
    SaveValue TableName, "HighScore2Name", HighScoreName(1)
    SaveValue TableName, "HighScore3", HighScore(2)
    SaveValue TableName, "HighScore3Name", HighScoreName(2)
    SaveValue TableName, "HighScore4", HighScore(3)
    SaveValue TableName, "HighScore4Name", HighScoreName(3)


    SaveValue TableName, "SpecialHighScore1", SpecialHighScore(0)
    SaveValue TableName, "SpecialHighScore1Name", SpecialHighScoreName(0)
    SaveValue TableName, "SpecialHighScore2", SpecialHighScore(1)
    SaveValue TableName, "SpecialHighScore2Name", SpecialHighScoreName(1)
    SaveValue TableName, "SpecialHighScore3", SpecialHighScore(2)
    SaveValue TableName, "SpecialHighScore3Name", SpecialHighScoreName(2)
    SaveValue TableName, "SpecialHighScore4", SpecialHighScore(3)
    SaveValue TableName, "SpecialHighScore4Name", SpecialHighScoreName(3)

    SaveValue TableName, "Credits", Credits
    SaveValue TableName, "TotalGamesPlayed", TotalGamesPlayed
   ' SaveValue TableName, "Score(CurrentPlayer)", Score(CurrentPlayer)

End Sub

Sub Reseths
    HighScoreName(0) = "AAA"
    HighScoreName(1) = "BBB"
    HighScoreName(2) = "CCC"
    HighScoreName(3) = "DDD"
    HighScore(0) = 900000
    HighScore(1) = 850000
    HighScore(2) = 800000
    HighScore(3) = 750000

    SpecialHighScoreName(0) = "AAA"
    SpecialHighScoreName(1) = "BBB"
    SpecialHighScoreName(2) = "CCC"
    SpecialHighScoreName(3) = "DDD"
    SpecialHighScore(0) = 4
    SpecialHighScore(1) = 3
    SpecialHighScore(2) = 2
    SpecialHighScore(3) = 1
    Savehs
End Sub

' ***********************************************************
'  High Score Initals Entry Functions - based on Black's code
' ***********************************************************

Dim hsbModeActive, SpecialhsbModeActive
Dim hsEnteredName, hsSpecialEnteredName
Dim hsEnteredDigits(3)
Dim hsSpecialEnteredDigits(3)
Dim hsCurrentDigit, hsSpecialCurrentDigit
Dim hsValidLetters, hsSpecialValidLetters
Dim hsCurrentLetter, hsSpecialCurrentLetter
Dim hsLetterFlash, hsSpecialLetterFlash


Sub CheckHighscore()
    DMDUpdate.enabled = 0
    display2.Text = " "
    display1.Text = " "
    DisplayB2SText " "
    Dim tmp
    tmp = Score(1)

    If Score(2)> tmp Then tmp = Score(2)
    If Score(3)> tmp Then tmp = Score(3)
    If Score(4)> tmp Then tmp = Score(4)

    If tmp> HighScore(1) Then 'add 1 credit for beating the highscore
       HighScoreReward = 1
    End If

    If tmp> HighScore(3) Then
        PlaySound "spchkittenme"
        HighScore(3) = tmp
        display1.text = "  GREAT SCORE   " & "       "
        DisplayB2SText "  GREAT SCORE   " & "       " 
        'enter player's name
        vpmtimer.addtimer 2000, "HighScoreEntryInit '"
       ' HighScoreEntryInit()
    Else
        'EndOfBallComplete()
        CheckSpecialHighscore
    End If
End Sub



Sub HighScoreEntryInit()
    hsbModeActive = True
    PlaySound "mu_jychighscore"
    hsLetterFlash = 0

    hsEnteredDigits(0) = "A"
    hsEnteredDigits(1) = "-"
    hsEnteredDigits(2) = "-"
    hsCurrentDigit = 0

    hsValidLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ<+-0123456789" ' < is used to delete the last letter
    hsCurrentLetter = 1
   ' DMDFlush
    display1.text = "YOUR NAME:" & " "
    'DMDId "hsc", "", "YOUR NAME:", " ", 999999
    HighScoreDisplayName()
End Sub


Sub EnterHighScoreKey(keycode)
    If keycode = LeftFlipperKey Then
        Playsound "jycsfx12"
        hsCurrentLetter = hsCurrentLetter - 1
        if(hsCurrentLetter = 0) then
            hsCurrentLetter = len(hsValidLetters)
        end if
        HighScoreDisplayName()
    End If

    If keycode = RightFlipperKey Then
        Playsound "jycsfx12"
        hsCurrentLetter = hsCurrentLetter + 1
        if(hsCurrentLetter> len(hsValidLetters) ) then
            hsCurrentLetter = 1
        end if
        HighScoreDisplayName()
    End If

    If keycode = StartGameKey OR keycode = PlungerKey Then
        if(mid(hsValidLetters, hsCurrentLetter, 1) <> "<") then
            playsound "jycsfx9"
            hsEnteredDigits(hsCurrentDigit) = mid(hsValidLetters, hsCurrentLetter, 1)
            hsCurrentDigit = hsCurrentDigit + 1
            if(hsCurrentDigit = 3) then
                HighScoreCommitName()
            else
                HighScoreDisplayName()
            end if
        else
            playsound "fx_Esc"
            hsEnteredDigits(hsCurrentDigit) = " "
            if(hsCurrentDigit> 0) then
                hsCurrentDigit = hsCurrentDigit - 1
            end if
            HighScoreDisplayName()
        end if
    end if
End Sub

Sub HighScoreDisplayName()
    DMDUpdate.enabled = 0
    Dim i, TempStr
    display1.text = TempStr
    DisplayB2SText "" & TempStr
    TempStr = " >"
    if(hsCurrentDigit> 0) then TempStr = TempStr & hsEnteredDigits(0)
    if(hsCurrentDigit> 1) then TempStr = TempStr & hsEnteredDigits(1)
    if(hsCurrentDigit> 2) then TempStr = TempStr & hsEnteredDigits(2)

    if(hsCurrentDigit <> 3) then
        if(hsLetterFlash <> 0) then
            TempStr = TempStr & "_"
            DisplayB2SText TempStr & "_"
            display2.TEXT = TempStr & "_"
        else
            TempStr = TempStr & mid(hsValidLetters, hsCurrentLetter, 1)
            DisplayB2SText TempStr & mid(hsValidLetters, hsCurrentLetter, 1)
            display2.TEXT = TempStr & mid(hsValidLetters, hsCurrentLetter, 1)
        end if
    end if

    if(hsCurrentDigit <1) then TempStr = TempStr & hsEnteredDigits(1)
    if(hsCurrentDigit <2) then TempStr = TempStr & hsEnteredDigits(2)

    TempStr = TempStr & "< "
   ' DMDMod "hsc", "YOUR NAME:", Mid(TempStr, 2, 5), 999999
    DisplayB2SText "ENTER HIGHSCORE NAME " & Mid(TempStr, 2, 5)
    display1.TEXT = "ENTER HIGHSCORE NAME "
    display2.TEXT = "    " & Mid(TempStr, 2, 5)
End Sub

Sub HighScoreCommitName()
    hsbModeActive = False
    'PlaySong "m_end"
    hsEnteredName = hsEnteredDigits(0) & hsEnteredDigits(1) & hsEnteredDigits(2)
    if(hsEnteredName = "   ") then
        hsEnteredName = "YOU"
    end if

    HighScoreName(3) = hsEnteredName
    SortHighscore
   ' DMDFlush
    DMDUpdate.enabled = 1
    'EndOfBallComplete()
    CheckSpecialHighscore()
End Sub

Sub SortHighscore
    Dim tmp, tmp2, i, j
    For i = 0 to 3
        For j = 0 to 2
            If HighScore(j) <HighScore(j + 1) Then
                tmp = HighScore(j + 1)
                tmp2 = HighScoreName(j + 1)
                HighScore(j + 1) = HighScore(j)
                HighScoreName(j + 1) = HighScoreName(j)
                HighScore(j) = tmp
                HighScoreName(j) = tmp2
            End If
        Next
    Next
End Sub



'*****************
' Claw Special HighScore
'*****************


Sub CheckSpecialHighscore()

    DMDUpdate.enabled = 0
    display1.Text = " "
    display2.Text = " "
    DisplayB2SText " "
    Dim tmp
    tmp = SpecialScore(1)

    If SpecialScore(2)> tmp Then tmp = SpecialScore(2)
    If SpecialScore(3)> tmp Then tmp = SpecialScore(3)
    If SpecialScore(4)> tmp Then tmp = SpecialScore(4)

    If tmp> SpecialHighScore(1) Then 'add 1 credit for beating the highscore
       SpecialHighScoreReward = 1
    End If

    If tmp> SpecialHighscore(3) Then
        SpecialHighscore(3) = tmp
        'enter player's name
        PlaySound "spchnotoveryet"
        display1.text = "  GOOD GAME  "
        display2.text = " ASH WILLIAMS  "
        DisplayB2SText "    GOOD GAME   " & "   ASH WILLIAMS    " 
        vpmtimer.addtimer 2000, "SpecialHighScoreEntryInit '"  
        'SpecialHighScoreEntryInit()
    Else
        CreditsHighScoreReward.Enabled = 1
        'EndOfBallComplete()
    End If
End Sub


Sub SpecialHighScoreEntryInit()
    SpecialhsbModeActive = True
    StopSound "mu_jychighscore"
    PlaySound "mu_jychighscore"
    hsSpecialLetterFlash = 0


    hsSpecialEnteredDigits(0) = "A"
    hsSpecialEnteredDigits(1) = "-"
    hsSpecialEnteredDigits(2) = "-"
    hsSpecialCurrentDigit = 0

    hsSpecialValidLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ<+-0123456789" ' < is used to delete the last letter
    hsSpecialCurrentLetter = 1
   ' DMDFlush
    'display1.text = "YOUR NAME:" & " "
    'DMDId "hsc", "", "YOUR NAME:", " ", 999999
    SpecialHighScoreDisplayName()
End Sub


Sub EnterSpecialHighScoreKey(keycode)
    If keycode = LeftFlipperKey Then
        Playsound "jycsfx12"
        hsSpecialCurrentLetter = hsSpecialCurrentLetter - 1
        if(hsSpecialCurrentLetter = 0) then
            hsSpecialCurrentLetter = len(hsSpecialValidLetters)
        end if
        SpecialHighScoreDisplayName()
    End If

    If keycode = RightFlipperKey Then
        Playsound "jycsfx12"
        hsSpecialCurrentLetter = hsSpecialCurrentLetter + 1
        if(hsSpecialCurrentLetter> len(hsSpecialValidLetters) ) then
            hsSpecialCurrentLetter = 1
        end if
        SpecialHighScoreDisplayName()
    End If

    If keycode = StartGameKey OR keycode = PlungerKey Then
        if(mid(hsSpecialValidLetters, hsSpecialCurrentLetter, 1) <> "<") then
            playsound "jycsfx9"
            hsSpecialEnteredDigits(hsSpecialCurrentDigit) = mid(hsSpecialValidLetters, hsSpecialCurrentLetter, 1)
            hsSpecialCurrentDigit = hsSpecialCurrentDigit + 1
            if(hsSpecialCurrentDigit = 3) then
                SpecialHighScoreCommitName()
            else
                SpecialHighScoreDisplayName()
            end if
        else
            playsound "fx_Esc"
            hsSpecialEnteredDigits(hsSpecialCurrentDigit) = " "
            if(hsSpecialCurrentDigit> 0) then
                hsSpecialCurrentDigit = hsSpecialCurrentDigit - 1
            end if
            SpecialHighScoreDisplayName()
        end if
    end if
End Sub

Sub SpecialHighScoreDisplayName()
    DMDUpdate.enabled = 0
    Dim i, TempStr
    display2.text = TempStr
    DisplayB2SText "" & TempStr
    TempStr = " >"
    if(hsSpecialCurrentDigit> 0) then TempStr = TempStr & hsSpecialEnteredDigits(0)
    if(hsSpecialCurrentDigit> 1) then TempStr = TempStr & hsSpecialEnteredDigits(1)
    if(hsSpecialCurrentDigit> 2) then TempStr = TempStr & hsSpecialEnteredDigits(2)

    if(hsSpecialCurrentDigit <> 3) then
        if(hsSpecialLetterFlash <> 0) then
            TempStr = TempStr & "_"
            DisplayB2SText TempStr & "_"
            display2.TEXT = TempStr & "_"
        else
            TempStr = TempStr & mid(hsSpecialValidLetters, hsSpecialCurrentLetter, 1)
            DisplayB2SText TempStr & mid(hsSpecialValidLetters, hsSpecialCurrentLetter, 1)
            display2.TEXT = TempStr & mid(hsSpecialValidLetters, hsSpecialCurrentLetter, 1)
        end if
    end if

    if(hsSpecialCurrentDigit <1) then TempStr = TempStr & hsSpecialEnteredDigits(1)
    if(hsSpecialCurrentDigit <2) then TempStr = TempStr & hsSpecialEnteredDigits(2)

    TempStr = TempStr & "< "
   ' DMDMod "hsc", "YOUR NAME:", Mid(TempStr, 2, 5), 999999
    DisplayB2SText "BOOK MASTER NAME: " & Mid(TempStr, 2, 5)
    display1.TEXT = "BOOK MASTER NAME: "
    display2.TEXT = "    " & Mid(TempStr, 2, 5)
End Sub

Sub SpecialHighScoreCommitName()
    SpecialhsbModeActive = False
    'PlaySong "m_end"
    hsSpecialEnteredName = hsSpecialEnteredDigits(0) & hsSpecialEnteredDigits(1) & hsSpecialEnteredDigits(2)
    if(hsSpecialEnteredName = "   ") then
        hsSpecialEnteredName = "YOU"
    end if

    SpecialHighScoreName(3) = hsSpecialEnteredName
    SortSpecialHighscore
    DMDUpdate.enabled = 1
    PussyCatReward = True
    CreditsHighScoreReward.Enabled = True
    'EndOfBallComplete()
End Sub

Sub SortSpecialHighscore
    Dim tmp, tmp2, i, j
    For i = 0 to 3
        For j = 0 to 2
            If SpecialHighScore(j) <SpecialHighScore(j + 1) Then
                tmp = SpecialHighScore(j + 1)
                tmp2 = SpecialHighScoreName(j + 1)
                SpecialHighScore(j + 1) = SpecialHighScore(j)
                SpecialHighScoreName(j + 1) = SpecialHighScoreName(j)
                SpecialHighScore(j) = tmp
                SpecialHighScoreName(j) = tmp2
            End If
        Next
    Next
End Sub



Dim PussyCatReward
Sub CreditsHighScoreReward_Timer()
    CreditsHighScoreReward.Enabled = False

 If PussyCatReward = True Then 
    PussyCatReward = False              

  If HighScoreReward = 1 And SpecialHighScoreReward = 1  Then
     Credits = Credits + 1
     PlaySound SoundFXDOF("fx_knocker",124,DOFPulse,DOFKnocker)
     display1.text = "     CREDITS" & "  "&(Credits) &"  " & "      "
     HighScoreReward = 0: SpecialHighScoreReward = 0
     DisplayB2SText "     CREDITS" & "  "&(Credits) &"  " & "      "
     vpmtimer.addtimer 1000, "UnCreditoMas '"
  End If


   If HighScoreReward = 1 And SpecialHighScoreReward = 0 Then
      Credits = Credits + 1
      PlaySound SoundFXDOF("fx_knocker",124,DOFPulse,DOFKnocker)
      display1.text = "     CREDITS" & "  "&(Credits) &"  " & "      "
      HighScoreReward = 0:   DisplayB2SText "     CREDITS" & "  "&(Credits) &"  " & "      "
     vpmtimer.addtimer 1000, "EndOfBallComplete() '"
   End If

   If HighScoreReward = 0 And SpecialHighScoreReward = 1 Then
      Credits = Credits + 1
      PlaySound SoundFXDOF("fx_knocker",124,DOFPulse,DOFKnocker)
      display1.text = "     CREDITS" & "  "&(Credits) &"  " & "      "
      SpecialHighScoreReward = 0:   DisplayB2SText "     CREDITS" & "  "&(Credits) &"  " & "      "
      vpmtimer.addtimer 1000, "EndOfBallComplete() '"
   End If

 ' If HighScoreReward = 0 And SpecialHighScoreReward = 0 Then

 ' End If

 End If
     Playsound "spchyeahthatsit"
     EndOfBallComplete()
End Sub
  
Sub UnCreditoMas
    Credits = Credits + 1
    display1.text = "     CREDITS" & "  "&(Credits) &"  " & "      "
    DisplayB2SText "     CREDITS" & "  "&(Credits) &"  " & "      "
    vpmtimer.addtimer 2000, "EndOfBallComplete() '"
End Sub


'********************
' Music as wav sounds
'********************

Dim SongMS
SongMS = ""

Sub PlaySong(name)
    If bMusicOn Then
        If SongMS <> name Then
            StopSound SongMS
            SongMS = name
            If SongMS = "mu_end" Then
                PlaySound SongMS, 0, 0.1  'this last number is the volume, from 0 to 1
            Else
                PlaySound SongMS, -1, 0.1 'this last number is the volume, from 0 to 1
            End If
        End If
    End If
End Sub






'-----------------------------
'-----  FS Display Code  -----
'-----------------------------

'If You want to hide a display, set the reel value of every reel to 44. This picture is transparent
'This is best done using collection:
'
'	If HideDisplay then 
'		For Each obj in ReelsCollection:obj.setvalue(44):next
'	end if
 

 Dim Char(32),i,TempText                    'increase dimension if You need larger displays



'-----------------------------------------------
'-----  B2S section, not used in the demo  -----
'-----------------------------------------------

Sub DisplayB2SText(TextPar)							'Procedure to display Text on a 32 digit B2S LED reel. Assuming that it is display 1 with internal digit numbers 1-32
  If B2SOn Then
	TempText = TextPar		
	for i = 1 to 32
		if i <= len(TextPar) then
			Char(i) = left(TempText,1)
			TempText = right(Temptext,len(TempText)-1)		
		else
			Char(i) = " "
		end if
	next
	if B2SOn Then
	for i = 1 to 32
		controller.B2SSetLED i,B2SLEDValue(Char(i))
	next
	end if
  End If
End Sub


Sub DisplayB2SText2(TextPar)							'Procedure to display Text on a 30 digit B2S LED reel. Assuming that it is display 1 with internal digit numbers 1-32
 If B2SOn Then
	TempText = TextPar		
	for i = 1 to 32
		if i <= len(TextPar) then
			Char(i) = left(TempText,1)
			TempText = right(Temptext,len(TempText)-1)		
		else
			Char(i) = " "
		end if
	next

	for i = 1 to 32
		controller.B2SSetLED i,B2SLEDValue(Char(i))

	next
End If

DMDUpdate.interval = 2000
DMDUpdate.enabled = 1

End Sub



Function B2SLEDValue(CharPar)						'to be used with dB2S 15-segments-LED used in Herweh's Designer
	B2SLEDValue = 0									'default for unknown characters
	select case CharPar
		Case "","":	B2SLEDValue = 0
		Case "0":	B2SLEDValue = 63	
		Case "1":	B2SLEDValue = 8704
		Case "2":	B2SLEDValue = 2139
		Case "3":	B2SLEDValue = 2127	
		Case "4":	B2SLEDValue = 2150
		Case "5":	B2SLEDValue = 2157
		Case "6":	B2SLEDValue = 2172
		Case "7":	B2SLEDValue = 7
		Case "8":	B2SLEDValue = 2175
		Case "9":	B2SLEDValue = 2159
		Case "A":	B2SLEDValue = 2167
		Case "B":	B2SLEDValue = 10767
		Case "C":	B2SLEDValue = 57
		Case "D":	B2SLEDValue = 8719
		Case "E":	B2SLEDValue = 121
		Case "F":	B2SLEDValue = 2161
		Case "G":	B2SLEDValue = 2109
		Case "H":	B2SLEDValue = 2166
		Case "I":	B2SLEDValue = 8713
		Case "J":	B2SLEDValue = 31
		Case "K":	B2SLEDValue = 5232
		Case "L":	B2SLEDValue = 56
		Case "M":	B2SLEDValue = 1334
		Case "N":	B2SLEDValue = 4406
		Case "O":	B2SLEDValue = 63
		Case "P":	B2SLEDValue = 2163
		Case "Q":	B2SLEDValue = 4287
		Case "R":	B2SLEDValue = 6259
		Case "S":	B2SLEDValue = 2157
		Case "T":	B2SLEDValue = 8705
		Case "U":	B2SLEDValue = 62
		Case "V":	B2SLEDValue = 17456
		Case "W":	B2SLEDValue = 20534
		Case "X":	B2SLEDValue = 21760
		Case "Y":	B2SLEDValue = 9472
		Case "Z":	B2SLEDValue = 17417
		Case "<":	B2SLEDValue = 5120
		Case ">":	B2SLEDValue = 16640
		Case "^":	B2SLEDValue = 17414
		Case ".":	B2SLEDValue = 8
		Case "!":	B2SLEDValue = 0
		Case ".":	B2SLEDValue = 128
		Case "*":	B2SLEDValue = 32576
		Case "/":	B2SLEDValue = 17408
		Case "\":	B2SLEDValue = 4352
		Case "|":	B2SLEDValue = 8704
		Case "=":	B2SLEDValue = 2120
		Case "+":	B2SLEDValue = 10816
		Case "-":	B2SLEDValue = 2112
	end select			
	B2SLEDValue = cint(B2SLEDValue)
End Function










Sub DMDScore
	 DisplayB2SText Score(1) & "" & "                  BALL " & Ball & " "
     display1.text = Score(CurrentPlayer) &"                "                   
     display2.text = "           BALL " & Ball 
     DMDUpdate.enabled = 1
End Sub





Sub DMDUpdate_Timer
    DMDUpdate.enabled = 0
 If PlayersPlayingGame = 1 And BallsOnPlayfield >= 1 Then
    DisplayB2SText " "
    display1.text = " "
    display2.text = " "
    DMDScore 
    AddScore (0)
    DMDUpdate.interval = 1000
    DMDUpdate.enabled = 1
  Else
    DisplayB2SText " "
    display1.text = " "
    display2.text = " "
    DMDUpdate.interval = 1500
    DMDUpdate.enabled = 1
 End If
End Sub











Sub FlashersUpdate()
   If strobe1.state = 1 Then
      strobe1A.state = 1 
    Else
      strobe1A.state = 0
   End If

   If strobe2.state = 1 Then
      strobe2A.state = 1 
    Else
      strobe2A.state = 0
   End If

   If strobe3.state = 1 Then
      strobe3A.state = 1 
    Else
      strobe3A.state = 0
   End If

   If strobe4.state = 1 Then
      strobe4A.state = 1 
    Else
      strobe4A.state = 0
   End If

   If strobe5.state = 1 Then
      strobe5A.state = 1 
    Else
      strobe5A.state = 0
   End If

   If strobe6.state = 1 Then
      strobe6A.state = 1 
    Else
      strobe6A.state = 0
   End If

   If strobe7.state = 1 Then
      strobe7A.state = 1 
    Else
      strobe7A.state = 0
   End If

   If strobe8.state = 1 Then
      strobe8A.state = 1 
    Else
      strobe8A.state = 0
   End If

   If strobe9.state = 1 Then
      strobe9A.state = 1 
    Else
      strobe9A.state = 0
   End If

   If strobe10.state = 1 Then
      strobe10A.state = 1 
    Else
      strobe10A.state = 0
   End If
End Sub












Sub StartAttractMode()
	bAttractMode = true

	attractphase = attractphase - attractphase

	message = message - message
	attractmessage()

	checkblackout()

    StartLightSeq
End Sub

Sub StopAttractMode()
    bAttractMode = False
    LightSeqAttract.StopPlay
    LightSeqFlasher.StopPlay
End Sub

Sub StartLightSeq()
    'lights sequences
    LightSeqFlasher.UpdateInterval = 150
    LightSeqFlasher.Play SeqRandom, 10, , 50000
    LightSeqAttract.Play SeqBlinking, , 5, 150
    LightSeqAttract.Play SeqRandom, 40, , 4000
    LightSeqAttract.Play SeqAllOff
    LightSeqAttract.UpdateInterval = 8
    LightSeqAttract.Play SeqUpOn, 50, 1
    LightSeqAttract.UpdateInterval = 8
    LightSeqAttract.Play SeqDownOn, 25, 1
    LightSeqAttract.UpdateInterval = 8
    LightSeqAttract.Play SeqCircleOutOn, 15, 2
    LightSeqAttract.UpdateInterval = 8
    LightSeqAttract.Play SeqUpOn, 25, 1
    LightSeqAttract.UpdateInterval = 8
    LightSeqAttract.Play SeqDownOn, 25, 1
    LightSeqAttract.UpdateInterval = 8
    LightSeqAttract.Play SeqUpOn, 25, 1
    LightSeqAttract.UpdateInterval = 8
    LightSeqAttract.Play SeqDownOn, 25, 1
    LightSeqAttract.UpdateInterval = 10
    LightSeqAttract.Play SeqCircleOutOn, 15, 3
    LightSeqAttract.UpdateInterval = 5
    LightSeqAttract.Play SeqRightOn, 50, 1
    LightSeqAttract.UpdateInterval = 5
    LightSeqAttract.Play SeqLeftOn, 50, 1
    LightSeqAttract.UpdateInterval = 8
    LightSeqAttract.Play SeqRightOn, 50, 1
    LightSeqAttract.UpdateInterval = 8
    LightSeqAttract.Play SeqLeftOn, 50, 1
    LightSeqAttract.UpdateInterval = 8
    LightSeqAttract.Play SeqRightOn, 40, 1
    LightSeqAttract.UpdateInterval = 8
    LightSeqAttract.Play SeqLeftOn, 40, 1
    LightSeqAttract.UpdateInterval = 10
    LightSeqAttract.Play SeqRightOn, 30, 1
    LightSeqAttract.UpdateInterval = 10
    LightSeqAttract.Play SeqLeftOn, 30, 1
    LightSeqAttract.UpdateInterval = 8
    LightSeqAttract.Play SeqRightOn, 25, 1
    LightSeqAttract.UpdateInterval = 8
    LightSeqAttract.Play SeqLeftOn, 25, 1
    LightSeqAttract.UpdateInterval = 8
    LightSeqAttract.Play SeqRightOn, 15, 1
    LightSeqAttract.UpdateInterval = 8
    LightSeqAttract.Play SeqLeftOn, 15, 1
    LightSeqAttract.UpdateInterval = 10
    LightSeqAttract.Play SeqCircleOutOn, 15, 3
    LightSeqAttract.UpdateInterval = 8
    LightSeqAttract.Play SeqLeftOn, 25, 1
    LightSeqAttract.UpdateInterval = 8
    LightSeqAttract.Play SeqRightOn, 25, 1
    LightSeqAttract.UpdateInterval = 8
    LightSeqAttract.Play SeqLeftOn, 25, 1
    LightSeqAttract.UpdateInterval = 8
    LightSeqAttract.Play SeqUpOn, 25, 1
    LightSeqAttract.UpdateInterval = 8
    LightSeqAttract.Play SeqDownOn, 25, 1
    LightSeqAttract.UpdateInterval = 8
    LightSeqAttract.Play SeqUpOn, 25, 1
    LightSeqAttract.UpdateInterval = 8
    LightSeqAttract.Play SeqDownOn, 25, 1
    LightSeqAttract.UpdateInterval = 5
    LightSeqAttract.Play SeqStripe1VertOn, 50, 2
    LightSeqAttract.UpdateInterval = 8
    LightSeqAttract.Play SeqCircleOutOn, 15, 2
    LightSeqAttract.UpdateInterval = 8
    LightSeqAttract.Play SeqStripe1VertOn, 50, 3
    LightSeqAttract.UpdateInterval = 8
    LightSeqAttract.Play SeqLeftOn, 25, 1
    LightSeqAttract.UpdateInterval = 8
    LightSeqAttract.Play SeqRightOn, 25, 1
    LightSeqAttract.UpdateInterval = 8
    LightSeqAttract.Play SeqLeftOn, 25, 1
    LightSeqAttract.UpdateInterval = 8
    LightSeqAttract.Play SeqUpOn, 25, 1
    LightSeqAttract.UpdateInterval = 8
    LightSeqAttract.Play SeqDownOn, 25, 1
    LightSeqAttract.UpdateInterval = 8
    LightSeqAttract.Play SeqCircleOutOn, 15, 2
    LightSeqAttract.UpdateInterval = 8
    LightSeqAttract.Play SeqStripe2VertOn, 50, 3

End Sub

Sub LightSeqAttract_PlayDone()
    StartLightSeq()
End Sub

Sub LightSeqTilt_PlayDone()
    LightSeqTilt.Play SeqAllOff
End Sub



