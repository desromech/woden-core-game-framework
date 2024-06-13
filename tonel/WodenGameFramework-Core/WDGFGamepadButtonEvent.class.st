"
I am a game framework gamepad button event.
"
Class {
	#name : 'WDGFGamepadButtonEvent',
	#superclass : 'WDGFInputEvent',
	#instVars : [
		'id',
		'button'
	],
	#category : 'WodenGameFramework-Core-Events',
	#package : 'WodenGameFramework-Core',
	#tag : 'Events'
}

{ #category : 'testing' }
WDGFGamepadButtonEvent class >> isAbstract [
	^ self == WDGFGamepadButtonEvent
]

{ #category : 'accessing' }
WDGFGamepadButtonEvent >> button [

	^ button
]

{ #category : 'accessing' }
WDGFGamepadButtonEvent >> button: anObject [

	button := anObject
]

{ #category : 'accessing' }
WDGFGamepadButtonEvent >> id [

	^ id
]

{ #category : 'accessing' }
WDGFGamepadButtonEvent >> id: anObject [

	id := anObject
]
