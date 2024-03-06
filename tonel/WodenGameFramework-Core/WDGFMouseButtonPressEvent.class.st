"
I am a game framework mouse button press event.
"
Class {
	#name : #WDGFMouseButtonPressEvent,
	#superclass : #WDGFMouseButtonEvent,
	#category : #'WodenGameFramework-Core-Events'
}

{ #category : #'message name' }
WDGFMouseButtonPressEvent class >> inputEventMessageName [
	^ #mouseButtonPressEvent:
]
