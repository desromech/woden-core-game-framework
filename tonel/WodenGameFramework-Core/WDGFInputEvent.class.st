"
I represent a specific input event.
"
Class {
	#name : #WDGFInputEvent,
	#superclass : #Object,
	#category : #'WodenGameFramework-Core-Events'
}

{ #category : #'message name' }
WDGFInputEvent class >> inputEventMessageName [
	^ self subclassResponsibility
]

{ #category : #testing }
WDGFInputEvent class >> isAbstract [
	^ self == WDGFInputEvent
]

{ #category : #'as yet unclassified' }
WDGFInputEvent >> accept: anEventHandler [
	^ self subclassResponsibility
]

{ #category : #'message name' }
WDGFInputEvent >> inputEventMessageName [
	^ self class inputEventMessageName
]
