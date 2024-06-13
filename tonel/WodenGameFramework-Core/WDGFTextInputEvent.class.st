"
I am a game framework text input event.
"
Class {
	#name : 'WDGFTextInputEvent',
	#superclass : 'WDGFInputEvent',
	#instVars : [
		'modifiers',
		'text'
	],
	#category : 'WodenGameFramework-Core-Events',
	#package : 'WodenGameFramework-Core',
	#tag : 'Events'
}

{ #category : 'message name' }
WDGFTextInputEvent class >> inputEventMessageName [
	^ #textInputEvent:
]

{ #category : 'accessing' }
WDGFTextInputEvent >> modifiers [

	^ modifiers
]

{ #category : 'accessing' }
WDGFTextInputEvent >> modifiers: anObject [

	modifiers := anObject
]

{ #category : 'accessing' }
WDGFTextInputEvent >> text [

	^ text
]

{ #category : 'accessing' }
WDGFTextInputEvent >> text: anObject [

	text := anObject
]
