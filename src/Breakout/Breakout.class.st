Class {
	#name : 'Breakout',
	#superclass : 'Object',
	#instVars : [
		'aSpace',
		'root',
		'bat',
		'ball',
		'rectangle',
		'circle',
		'delta',
		'isMovingLeft',
		'isMovingRight',
		'isRunning',
		'duration'
	],
	#category : 'Breakout',
	#package : 'Breakout'
}

{ #category : 'initialization' }
Breakout >> animateLeft [
    | animation pos | 
    pos := bat position.         

#(     
    animation := BlTransformAnimation new
         duration: duration milliSeconds;
        easing: BlLinearInterpolator default;
        absolute;
     "Move 30 pixels left"
        transformDo: [ :aBuilder | aBuilder translateBy: (0 - delta) @ 0 ];  
        onFinishedDo: [ bat position: pos - (0 - delta)@0. 
	                  "bounds checks"
	                     (bat position x) - (delta max: 0). 
	                  " ifTrue: [ bat position: 0@(bat position y) ] ."
	                     bat extent: 100 @ 20 .  
	                    "Transcript show: 'Animation done at: ', (bat position asString); cr "
	                     ].
    bat addAnimation: animation.
).

     pos := pos - (delta@0).
     bat position: pos . 

]

{ #category : 'initialization' }
Breakout >> animateRight [
    | animation pos |

  animation := BlTransformAnimation new        
        duration: duration milliSeconds;
        easing: BlLinearInterpolator default;
        absolute;
     "Move 300 pixels right"
        transformDo: [ :aBuilder | aBuilder translateBy: ( delta @ 0) ];  
        onFinishedDo: [ Transcript show: 'Animation done at: ', bat position asString; cr. 
	                     "bat position: (bat position x + delta)@(bat position y). "
	                   ].
    bat addAnimation: animation.

    "self listAnimations ."




#(
    pos := bat position . 

    animation := BlTransformAnimation new        
        duration: duration milliSeconds;
        easing: BlLinearInterpolator default;
        absolute;
     "Move 300 pixels right"
        transformDo: [ :aBuilder | aBuilder translateBy: (delta @ 0) ];  
        onFinishedDo: [ bat position: pos + (delta@0).  
		                     bat extent: 100 @ 20 .  
	                    "Transcript show: 'Animation done at: ', bat position asString; cr "
	    ].
    bat addAnimation: animation.

     pos := pos + (delta@0).
     bat position: pos . 

).



]

{ #category : 'initialization' }
Breakout >> animateStop [
 "remove all animations from bat"
  #(  bat removeAnimations. ).
 ^ nil . 





]

{ #category : 'initialization' }
Breakout >> gameHalt [
 isRunning := false . 
 [ Processor terminateActiveProcessNamed: 'GameLoop' ]
    on: Error do: [ :ex | Transcript show: 'No Game Loop process found'; cr ].

"close the window"
 aSpace close.
 



]

{ #category : 'initialization' }
Breakout >> gameLoop [ 
  [ 
    [ 
        [  self updateGame . 
	        "request next pulse"
			 aSpace requestNextPulse.
	
          "(Delay forMilliseconds: 16) wait."
           #(Transcript show: 'tick' ; cr . ).
 	       "wait one second "
          "(Delay forMilliseconds: 1000) wait."          
 	       "wait 16 milliseconds second "
          (Delay forMilliseconds: 600) wait.

          isRunning.  ] whileTrue. 
       "keep looping while last thing evald is true "
    ] on: Error do: [ :ex | Transcript cr; show: ex description ] 
] forkNamed: 'GameLoop'.



]

{ #category : 'initialization' }
Breakout >> initialize [

	super initialize. "make some bricks all random colours "

   "how far bat moves"
   delta := 100 . 
   "animated over what duration"
   duration := 400. 

   isMovingLeft := false. 
   isMovingRight := false. 
   isRunning := true. 

	aSpace := BlSpace new. "make a window "
	root := aSpace root. "access root element"
	Transcript
		show: 'aSpace width = ';
		show: aSpace width;
		cr. "show width height"
	Transcript
		show: 'aSpace height = ';
		show: aSpace height;
		cr. "how do we know if accurate?"

	aSpace extent: 1024 @ 768. "Set window size to 1024x768 pixels"
	Transcript
		show: 'aSpace width = ';
		show: aSpace width;
		cr. "show width height"
	Transcript
		show: 'aSpace height = ';
		show: aSpace height;
		cr. "how do we know if accurate?"
	aSpace resizable: false. "thats just mean no?"
	aSpace resizable: true. "surely a more dynamic be better"
	aSpace root background: Color blue.
	aSpace title: 'Breakout'. " extent: 500@500 . "

	1 to: 20 do: [ :x |
			1 to: 20 do: [ :y |
					| rectangle |
					rectangle := BlElement new
						             background: Color random;
						             position: 40 * x @ (20 * y);
						             extent: 40 @ 20;
						             yourself.
					root addChild: rectangle ] ].

	bat := BlElement new
		       background: Color red;
		       position: 400 @ 600;
		       extent: 120 @ 20;
		       yourself.
	root addChild: bat.

	ball := BlElement new
		        background: Color red;
		        geometry: BlCircleGeometry new;
		        position: 400 @ 500;
		        extent: 20 @ 20;
		        yourself.
	root addChild: ball.
   "aSpace root focus: true.  "
   "Request keyboard focus for the root (enables key events)"
  "Make element focusable"
   "root focusability: BlFocusability focusable;  "
	root addEventHandler: (BlEventHandler on: BlKeyDownEvent do: [ :anEvent | self keyDownEvent: anEvent ]).
	root addEventHandler: (BlEventHandler on: BlKeyUpEvent do: [ :anEvent | self keyUpEvent: anEvent ]).
	"Request focus when initialized"
	"root requestFocus  "
	root focused: true . 
	
"aSpace root addEventHandler: (BlEventHandler on: BlKeyDownEvent do: [ :anEvent | bat keyDownEvent: anEvent ])."
aSpace root addEventHandler: (BlEventHandler on: BlKeyDownEvent do: [ :anEvent | self keyDownEvent: anEvent ]).

"finally show window "
	aSpace show.
	
"start a background process for game loop"
self gameLoop.	
	

]

{ #category : 'initialization' }
Breakout >> keyDownEvent: anEvent [
	| scanCode |
	
	scanCode := anEvent scanCode . 
	({ 4 . 80 } includes: scanCode)  
	"Left arrow"
		ifTrue: [ Transcript show: 'left arrow down ' ; show: bat position ; cr . 
			       isMovingLeft := true. 
			       isMovingRight := false.
			 ].
	({ 7 . 79 } includes: scanCode)  
	"Right arrow"
		ifTrue: [ Transcript show: 'right arrow down' ; show: bat position ; cr . 
			       isMovingRight := true.
			       isMovingLeft := false.
			].
	"show the key that was pressed"
	"track how far left or right"	
	Transcript show: 'key scancode = ' ; show: anEvent scanCode ; cr.
	anEvent consumed: true  "Prevent event bubbling".
	

]

{ #category : 'initialization' }
Breakout >> keyUpEvent: anEvent [
	| scanCode |	
	scanCode := anEvent scanCode . 
	({ 4 . 80 } includes: scanCode)  "Left arrow"
		ifTrue: [ Transcript show: 'left arrow up' ; show: bat position ; cr . 
			     isMovingLeft := false.			     
			       ].
	({ 7 . 79 } includes: scanCode)  "Right arrow"
		ifTrue: [ Transcript show: 'right arrow up' ; show: bat position ; cr . 
			    isMovingRight := false.   
			 ].
	"show the key that was pressed"
	Transcript show: 'key scancode = ' ; show: anEvent scanCode ; cr . 
	
	anEvent consumed: true  "Prevent event bubbling".
	

]

{ #category : 'initialization' }
Breakout >> listAnimations [
    | animationList |
   "get all the bat animations - may be accumulating , stop animations , keep adding more animations , result in jerky flow"
    animationList := bat animations.
    Transcript show: 'Animations on ', self asString, ': ', animationList size asString; cr.
    animationList do: [ :anAnimation | 
        Transcript show: ' - Animation: ', anAnimation class name, 
                        ', Duration: ', anAnimation duration asString,
                        ', Is running: ', anAnimation isRunning asString; cr ].
    ^ animationList
]

{ #category : 'initialization' }
Breakout >> updateGame [
	
	isMovingLeft ifTrue: [ self animateLeft ].
	isMovingRight ifTrue: [ self animateRight ]. 
	isMovingLeft not and: [ isMovingRight not ifTrue:[ self animateStop ]].

]
