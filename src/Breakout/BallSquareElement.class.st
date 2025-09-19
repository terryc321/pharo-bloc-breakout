Class {
	#name : 'BallSquareElement',
	#superclass : 'BallElement',
	#category : 'Breakout',
	#package : 'Breakout'
}

{ #category : 'initialization' }
BallSquareElement >> initialize [ 
	super initialize.
	self geometry: BlSquareGeometry new.
	

]
