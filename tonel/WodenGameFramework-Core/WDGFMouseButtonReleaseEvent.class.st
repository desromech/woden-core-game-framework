"
I am a game framework mouse button release event.
"
Class {
	#name : 'WDGFMouseButtonReleaseEvent',
	#superclass : 'WDGFMouseButtonEvent',
	#category : 'WodenGameFramework-Core-Events',
	#package : 'WodenGameFramework-Core',
	#tag : 'Events'
}

{ #category : 'message name' }
WDGFMouseButtonReleaseEvent class >> inputEventMessageName [
	^ #mouseButtonReleaseEvent:
]

{ #category : 'as yet unclassified' }
WDGFMouseButtonReleaseEvent >> accept: anEventHandler [
	^ anEventHandler mouseButtonReleaseEvent: self
]
