"
I am a game framework mouse button press event.
"
Class {
	#name : 'WDGFMouseButtonPressEvent',
	#superclass : 'WDGFMouseButtonEvent',
	#category : 'WodenGameFramework-Core-Events',
	#package : 'WodenGameFramework-Core',
	#tag : 'Events'
}

{ #category : 'message name' }
WDGFMouseButtonPressEvent class >> inputEventMessageName [
	^ #mouseButtonPressEvent:
]

{ #category : 'as yet unclassified' }
WDGFMouseButtonPressEvent >> accept: anEventHandler [
	^ anEventHandler mouseButtonPressEvent: self
]
