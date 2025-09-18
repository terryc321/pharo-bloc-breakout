Class {
	#name : 'Breakout',
	#superclass : 'Object',
	#instVars : [
		'aSpace',
		'root'
	],
	#category : 'Breakout',
	#package : 'Breakout'
}

{ #category : 'initialization' }
Breakout >> initialize [ 
 
 aSpace := BlSpace new. "make a window "
 root := aSpace root. "access root element"
 Transcript show: 'aSpace width = ' ; show: aSpace width ; cr .   "show width height"
 Transcript show: 'aSpace height = ' ; show: aSpace height ; cr .   "how do we know if accurate?"

 aSpace extent: 1024@768.  "Set window size to 1024x768 pixels" 
 Transcript show: 'aSpace width = ' ; show: aSpace width ; cr .   "show width height"
 Transcript show: 'aSpace height = ' ; show: aSpace height ; cr .   "how do we know if accurate?"
 aSpace resizable:false .  "thats just mean no?"
 aSpace resizable:true .  "surely a more dynamic be better"
" background: Color blue;  "
" title: 'Breakout'."
" extent: 500@500 . "
 aSpace show.


 
]
