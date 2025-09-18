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
		'animation',
		'stopMe'
	],
	#category : 'Breakout',
	#package : 'Breakout'
}

{ #category : 'initialization' }
Breakout >> gameHalt [
 stopMe := true . 

]

{ #category : 'initialization' }
Breakout >> gameLoop [ 
  [ 
    [ 
        [  self updateGame . 
          (Delay forMilliseconds: 16) wait.
           "some way to escape game loop"
          stopMe ifTrue: [ ^ true ].
        ] repeat 
    ] on: Error do: [ :ex | Transcript cr; show: ex description ] 
] forkNamed: 'Game Loop'.


]

{ #category : 'initialization' }
Breakout >> initialize [

	super initialize. "make some bricks all random colours "
   delta := 10 . 
   isMovingLeft := false. 
   isMovingRight := false. 


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
	delta := 0.
	scanCode := anEvent scanCode . 
	({ 4 . 80 } includes: scanCode)  "Left arrow"
		ifTrue: [ Transcript show: 'left arrow down ' ; cr . 
			       isMovingLeft := true. 
			       isMovingRight := false.
			 ].
	({ 7 } includes: scanCode)  "Right arrow"
		ifTrue: [ Transcript show: 'right arrow down' ; cr . 
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
		ifTrue: [ Transcript show: 'left arrow up' ; cr . 
			     isMovingLeft := false.			     
			       ].
	({ 7 } includes: scanCode)  "Right arrow"
		ifTrue: [ Transcript show: 'right arrow up' ; cr . 
			    isMovingRight := false.   
			 ].
	"show the key that was pressed"
	Transcript show: 'key scancode = ' ; show: anEvent scanCode ; cr . 
	
	anEvent consumed: true  "Prevent event bubbling".
	

]

{ #category : 'initialization' }
Breakout >> updateGame [
	 | newPosition |
  newPosition := bat position.
        isMovingLeft ifTrue: [ newPosition := newPosition - (delta @ 0) ].
        isMovingRight ifTrue: [ newPosition := newPosition + (delta @ 0) ].
        
        "Boundary checks"
        newPosition x < 0 ifTrue: [ newPosition := 0 @ newPosition y ].
        newPosition x > (aSpace extent x - bat size x) ifTrue: [ 
            newPosition := (aSpace extent x - bat size x) @ newPosition y ].        
        bat position: newPosition.
 
 "do we need to tell somebody the bat has moved ? "   
 
]
