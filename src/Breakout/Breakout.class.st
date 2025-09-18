Class {
	#name : 'Breakout',
	#superclass : 'Object',
	#instVars : [
		'aSpace',
		'root',
		'bat',
		'ball',
		'rectangle',
		'circle'
	],
	#category : 'Breakout',
	#package : 'Breakout'
}

{ #category : 'initialization' }
Breakout >> initialize [

	super initialize. "make some bricks all random colours "

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

	aSpace show
]

{ #category : 'initialization' }
Breakout >> keyDownEvent: anEvent [
	| delta scanCode |
	delta := 0.
	scanCode := anEvent scanCode . 
	({ 4 . 80 } includes: scanCode)  "Left arrow"
		ifTrue: [ Transcript show: 'left arrow pressed' ; cr . 
			       delta := -10 ].
	({ 7 } includes: scanCode)  "Right arrow"
		ifTrue: [ Transcript show: 'right arrow pressed' ; cr . 
			       delta := 10 ].
	"show the key that was pressed"
	Transcript show: 'key scancode = ' ; show: anEvent scanCode ; cr . 
	"track how far left or right"
	delta ~= 0
		ifTrue: [
	 	   "move bat"
			bat position: (bat position + (delta@0)).
			"move ball"
			ball position: (ball position + (delta@0)).
			 "Trigger relayout for visual update"
			"aSpace ifNotNil: [ :s | s requestLayout ] " 
			].
	anEvent consumed: true  "Prevent event bubbling".
	

]
