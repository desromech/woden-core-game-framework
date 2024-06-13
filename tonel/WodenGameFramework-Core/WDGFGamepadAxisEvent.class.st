"
I am a game framework gamepad axis event.
"
Class {
	#name : 'WDGFGamepadAxisEvent',
	#superclass : 'WDGFInputEvent',
	#instVars : [
		'id',
		'axis',
		'value'
	],
	#category : 'WodenGameFramework-Core-Events',
	#package : 'WodenGameFramework-Core',
	#tag : 'Events'
}

{ #category : 'message name' }
WDGFGamepadAxisEvent class >> inputEventMessageName [
	^ #gamepadAxisEvent:
]

{ #category : 'accessing' }
WDGFGamepadAxisEvent >> axis [

	^ axis
]

{ #category : 'accessing' }
WDGFGamepadAxisEvent >> axis: anObject [

	axis := anObject
]

{ #category : 'accessing' }
WDGFGamepadAxisEvent >> id [

	^ id
]

{ #category : 'accessing' }
WDGFGamepadAxisEvent >> id: anObject [

	id := anObject
]

{ #category : 'accessing' }
WDGFGamepadAxisEvent >> value [
	^ value
]

{ #category : 'accessing' }
WDGFGamepadAxisEvent >> value: anObject [

	value := anObject
]
