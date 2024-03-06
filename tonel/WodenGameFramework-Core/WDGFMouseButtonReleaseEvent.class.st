"
I am a game framework mouse button release event.
"
Class {
	#name : #WDGFMouseButtonReleaseEvent,
	#superclass : #WDGFMouseButtonEvent,
	#category : #'WodenGameFramework-Core-Events'
}

{ #category : #'message name' }
WDGFMouseButtonReleaseEvent class >> inputEventMessageName [
	^ #mouseButtonReleaseEvent:
]
