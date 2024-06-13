"
I am a game framework key down event.
"
Class {
	#name : 'WDGFKeyDownEvent',
	#superclass : 'WDGFKeyboardEvent',
	#category : 'WodenGameFramework-Core-Events',
	#package : 'WodenGameFramework-Core',
	#tag : 'Events'
}

{ #category : 'message name' }
WDGFKeyDownEvent class >> inputEventMessageName [
	^ #keyDownEvent:
]
