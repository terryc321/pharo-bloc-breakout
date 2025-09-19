Class {
	#name : 'BallElement',
	#superclass : 'BlElement',
	#instVars : [
		'vx',
		'vy'
	],
	#category : 'Breakout',
	#package : 'Breakout'
}

{ #category : 'initialization' }
BallElement >> initialize [ 
 super initialize.
 self  background: Color red;
		        geometry: BlCircleGeometry new;
		        position: 400 @ 500;
		        extent: 20 @ 20.
		
		
		       
		
	
]
