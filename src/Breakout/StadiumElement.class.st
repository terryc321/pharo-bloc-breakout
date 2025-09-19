Class {
	#name : 'StadiumElement',
	#superclass : 'BlElement',
	#instVars : [
		'vx',
		'vy',
		'delta'
	],
	#category : 'Breakout',
	#package : 'Breakout'
}

{ #category : 'initialization' }
StadiumElement >> delta:  n [
 delta := n . 

]

{ #category : 'initialization' }
StadiumElement >> initialize [ 
 super initialize.
 self  background: Color random;
		        geometry: BlStadiumGeometry new;
		        position: 400 @ 500;
		        extent: 20 @ 20.
		
		
		       
		
	
]

{ #category : 'initialization' }
StadiumElement >> updateBall: anExtent [
	| pos x y board wid hgt |

 "in order to bounce ball has to know size of the playfield"

  pos := self position.
  x := pos x. 
  y := pos y.

  board := anExtent . 
  wid := board x . 
  hgt := board y . 

  x := x + vx . 
  y := y + vy .

  x < 0 ifTrue: [ vx := 0 - vx ].
  y < 0 ifTrue: [ vy := 0 - vy ].
  x > wid ifTrue: [ vx := 0 - vx . x := wid - delta ].
  y > hgt ifTrue: [ vy := 0 - vy . y := hgt - delta ].

  self position: x @ y . 

]

{ #category : 'initialization' }
StadiumElement >> velocity: aVelocity [
	vx := aVelocity x.
	vy := aVelocity y.
	
]
