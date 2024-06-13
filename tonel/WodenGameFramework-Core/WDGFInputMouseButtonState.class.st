"
I hold the states for the different mouse buttons.
"
Class {
	#name : 'WDGFInputMouseButtonState',
	#superclass : 'Object',
	#instVars : [
		'leftButton',
		'middleButton',
		'rightButton',
		'extraButton',
		'extraButton2'
	],
	#category : 'WodenGameFramework-Core-Events',
	#package : 'WodenGameFramework-Core',
	#tag : 'Events'
}

{ #category : 'converting' }
WDGFInputMouseButtonState >> asMask [
	| mask |
	mask := 0.
	leftButton ifTrue: [ mask := mask bitOr: 1 ].
	middleButton ifTrue: [ mask := mask bitOr: 2 ].
	rightButton ifTrue: [ mask := mask bitOr: 4 ].
	extraButton ifTrue: [ mask := mask bitOr: 8 ].
	extraButton2 ifTrue: [ mask := mask bitOr: 16 ].
	^ mask
]

{ #category : 'accessing' }
WDGFInputMouseButtonState >> extraButton [

	^ extraButton
]

{ #category : 'accessing' }
WDGFInputMouseButtonState >> extraButton2 [

	^ extraButton2
]

{ #category : 'accessing' }
WDGFInputMouseButtonState >> extraButton2: anObject [

	extraButton2 := anObject
]

{ #category : 'accessing' }
WDGFInputMouseButtonState >> extraButton: anObject [

	extraButton := anObject
]

{ #category : 'initialization' }
WDGFInputMouseButtonState >> initialize [
	super initialize.
	leftButton := false.
	middleButton := false.
	rightButton := false.
	extraButton := false.
	extraButton2 := false.
	
]

{ #category : 'accessing' }
WDGFInputMouseButtonState >> leftButton [

	^ leftButton
]

{ #category : 'accessing' }
WDGFInputMouseButtonState >> leftButton: anObject [

	leftButton := anObject
]

{ #category : 'accessing' }
WDGFInputMouseButtonState >> middleButton [

	^ middleButton
]

{ #category : 'accessing' }
WDGFInputMouseButtonState >> middleButton: anObject [

	middleButton := anObject
]

{ #category : 'accessing' }
WDGFInputMouseButtonState >> rightButton [

	^ rightButton
]

{ #category : 'accessing' }
WDGFInputMouseButtonState >> rightButton: anObject [

	rightButton := anObject
]

{ #category : 'converting' }
WDGFInputMouseButtonState >> setFromMask: aMask [
	leftButton := aMask anyMask: 1.
	middleButton := aMask anyMask: 2.
	rightButton := aMask anyMask: 4.
	extraButton := aMask anyMask: 8.
	extraButton2 := aMask anyMask: 16.
	

]
