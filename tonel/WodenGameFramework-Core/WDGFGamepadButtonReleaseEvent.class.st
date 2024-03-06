"
I am a game framework gamepad button release event.
"
Class {
	#name : #WDGFGamepadButtonReleaseEvent,
	#superclass : #WDGFGamepadButtonEvent,
	#category : #'WodenGameFramework-Core-Events'
}

{ #category : #'message name' }
WDGFGamepadButtonReleaseEvent class >> inputEventMessageName [
	^ #gamepadButtonReleaseEvent:
]
