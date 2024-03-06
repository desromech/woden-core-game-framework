"
I am a game framework keyboard event.
"
Class {
	#name : #WDGFKeyboardEvent,
	#superclass : #WDGFInputEvent,
	#instVars : [
		'symbol',
		'modifiers'
	],
	#category : #'WodenGameFramework-Core-Events'
}

{ #category : #testing }
WDGFKeyboardEvent class >> isAbstract [
	^ self == WDGFKeyboardEvent
]

{ #category : #initialization }
WDGFKeyboardEvent >> initialize [
	super initialize.
	modifiers := WDGFInputStateModifiers new.

]

{ #category : #accessing }
WDGFKeyboardEvent >> modifiers [

	^ modifiers
]

{ #category : #accessing }
WDGFKeyboardEvent >> modifiers: anObject [

	modifiers := anObject
]

{ #category : #accessing }
WDGFKeyboardEvent >> symbol [

	^ symbol
]

{ #category : #accessing }
WDGFKeyboardEvent >> symbol: anObject [

	symbol := anObject
]
