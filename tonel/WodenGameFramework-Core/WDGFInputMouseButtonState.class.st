Class {
	#name : #WDGFInputMouseButtonState,
	#superclass : #Object,
	#instVars : [
		'leftButton',
		'middleButton',
		'rightButton',
		'extraButton',
		'extraButton2'
	],
	#category : #'WodenGameFramework-Core-Events'
}

{ #category : #accessing }
WDGFInputMouseButtonState >> extraButton [

	^ extraButton
]

{ #category : #accessing }
WDGFInputMouseButtonState >> extraButton2 [

	^ extraButton2
]

{ #category : #accessing }
WDGFInputMouseButtonState >> extraButton2: anObject [

	extraButton2 := anObject
]

{ #category : #accessing }
WDGFInputMouseButtonState >> extraButton: anObject [

	extraButton := anObject
]

{ #category : #initialization }
WDGFInputMouseButtonState >> initialize [
	super initialize.
	leftButton := false.
	middleButton := false.
	rightButton := false.
	extraButton := false.
	extraButton2 := false.
	
]

{ #category : #accessing }
WDGFInputMouseButtonState >> leftButton [

	^ leftButton
]

{ #category : #accessing }
WDGFInputMouseButtonState >> leftButton: anObject [

	leftButton := anObject
]

{ #category : #accessing }
WDGFInputMouseButtonState >> middleButton [

	^ middleButton
]

{ #category : #accessing }
WDGFInputMouseButtonState >> middleButton: anObject [

	middleButton := anObject
]

{ #category : #accessing }
WDGFInputMouseButtonState >> rightButton [

	^ rightButton
]

{ #category : #accessing }
WDGFInputMouseButtonState >> rightButton: anObject [

	rightButton := anObject
]
