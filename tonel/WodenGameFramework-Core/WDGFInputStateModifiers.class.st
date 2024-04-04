"
I hold a set of different flags that are used for modifying different input actions.
"
Class {
	#name : #WDGFInputStateModifiers,
	#superclass : #Object,
	#instVars : [
		'leftShift',
		'rightShift',
		'leftAlt',
		'rightAlt',
		'leftCtrl',
		'rightCtrl',
		'leftCmd',
		'rightCmd',
		'capsLock',
		'numLock'
	],
	#category : #'WodenGameFramework-Core-Events'
}

{ #category : #combining }
WDGFInputStateModifiers >> alt [
	^ leftAlt or: [  rightAlt ]
]

{ #category : #accessing }
WDGFInputStateModifiers >> capsLock [

	^ capsLock
]

{ #category : #accessing }
WDGFInputStateModifiers >> capsLock: anObject [

	capsLock := anObject
]

{ #category : #accessing }
WDGFInputStateModifiers >> cmd [
	^ leftCmd or: [  rightCmd ]
]

{ #category : #combining }
WDGFInputStateModifiers >> ctrl [
	^ leftCtrl or: [  rightCtrl ]
]

{ #category : #initialization }
WDGFInputStateModifiers >> initialize [
	super initialize.
	
	leftShift := false.
	rightShift := false.
	leftAlt := false.
	rightAlt := false.
	leftCtrl := false.
	rightCtrl := false.
	leftCmd := false.
	rightCmd := false.
	capsLock := false.
	numLock := false.
	
]

{ #category : #accessing }
WDGFInputStateModifiers >> leftAlt [

	^ leftAlt
]

{ #category : #accessing }
WDGFInputStateModifiers >> leftAlt: anObject [

	leftAlt := anObject
]

{ #category : #accessing }
WDGFInputStateModifiers >> leftCmd [

	^ leftCmd
]

{ #category : #accessing }
WDGFInputStateModifiers >> leftCmd: anObject [

	leftCmd := anObject
]

{ #category : #accessing }
WDGFInputStateModifiers >> leftCtrl [

	^ leftCtrl
]

{ #category : #accessing }
WDGFInputStateModifiers >> leftCtrl: anObject [

	leftCtrl := anObject
]

{ #category : #accessing }
WDGFInputStateModifiers >> leftShift [

	^ leftShift
]

{ #category : #accessing }
WDGFInputStateModifiers >> leftShift: anObject [

	leftShift := anObject
]

{ #category : #accessing }
WDGFInputStateModifiers >> numLock [

	^ numLock
]

{ #category : #accessing }
WDGFInputStateModifiers >> numLock: anObject [

	numLock := anObject
]

{ #category : #accessing }
WDGFInputStateModifiers >> rightAlt [

	^ rightAlt
]

{ #category : #accessing }
WDGFInputStateModifiers >> rightAlt: anObject [

	rightAlt := anObject
]

{ #category : #accessing }
WDGFInputStateModifiers >> rightCmd [

	^ rightCmd
]

{ #category : #accessing }
WDGFInputStateModifiers >> rightCmd: anObject [

	rightCmd := anObject
]

{ #category : #accessing }
WDGFInputStateModifiers >> rightCtrl [

	^ rightCtrl
]

{ #category : #accessing }
WDGFInputStateModifiers >> rightCtrl: anObject [

	rightCtrl := anObject
]

{ #category : #accessing }
WDGFInputStateModifiers >> rightShift [

	^ rightShift
]

{ #category : #accessing }
WDGFInputStateModifiers >> rightShift: anObject [

	rightShift := anObject
]

{ #category : #combining }
WDGFInputStateModifiers >> shift [
	^ leftShift or: [  rightShift ]
]
