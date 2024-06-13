"
I am a game framework mouse event.
"
Class {
	#name : 'WDGFMouseEvent',
	#superclass : 'WDGFInputEvent',
	#instVars : [
		'modifiers',
		'buttons',
		'position'
	],
	#category : 'WodenGameFramework-Core-Events',
	#package : 'WodenGameFramework-Core',
	#tag : 'Events'
}

{ #category : 'testing' }
WDGFMouseEvent class >> isAbstract [
	^ self == WDGFMouseEvent
]

{ #category : 'accessing' }
WDGFMouseEvent >> buttons [

	^ buttons
]

{ #category : 'accessing' }
WDGFMouseEvent >> buttons: anObject [

	buttons := anObject
]

{ #category : 'initialization' }
WDGFMouseEvent >> initialize [
	super initialize.
	modifiers := WDGFInputStateModifiers new.
	buttons := WDGFInputMouseButtonState new.
]

{ #category : 'accessing' }
WDGFMouseEvent >> modifiers [

	^ modifiers
]

{ #category : 'accessing' }
WDGFMouseEvent >> modifiers: anObject [

	modifiers := anObject
]

{ #category : 'accessing' }
WDGFMouseEvent >> position [

	^ position
]

{ #category : 'accessing' }
WDGFMouseEvent >> position: anObject [

	position := anObject
]
