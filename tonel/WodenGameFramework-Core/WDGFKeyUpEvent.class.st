"
I am a game framework key up event.
"
Class {
	#name : #WDGFKeyUpEvent,
	#superclass : #WDGFKeyboardEvent,
	#category : #'WodenGameFramework-Core-Events'
}

{ #category : #'message name' }
WDGFKeyUpEvent class >> inputEventMessageName [
	^ #keyUpEvent:
]
