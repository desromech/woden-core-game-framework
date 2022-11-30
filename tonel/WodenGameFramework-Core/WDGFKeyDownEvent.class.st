"
I am a game framework key down event.
"
Class {
	#name : #WDGFKeyDownEvent,
	#superclass : #WDGFKeyboardEvent,
	#category : #'WodenGameFramework-Core-Events'
}

{ #category : #'message name' }
WDGFKeyDownEvent class >> inputEventMessageName [
	^ #keyDownEvent:
]
