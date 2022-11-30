Class {
	#name : #WDGFGamepadButtonEvent,
	#superclass : #WDGFInputEvent,
	#instVars : [
		'id',
		'button'
	],
	#category : #'WodenGameFramework-Core-Events'
}

{ #category : #accessing }
WDGFGamepadButtonEvent >> button [

	^ button
]

{ #category : #accessing }
WDGFGamepadButtonEvent >> button: anObject [

	button := anObject
]

{ #category : #accessing }
WDGFGamepadButtonEvent >> id [

	^ id
]

{ #category : #accessing }
WDGFGamepadButtonEvent >> id: anObject [

	id := anObject
]
