"
I am a game framework gamepad button press event.
"
Class {
	#name : #WDGFGamepadButtonPressEvent,
	#superclass : #WDGFGamepadButtonEvent,
	#category : #'WodenGameFramework-Core-Events'
}

{ #category : #'message name' }
WDGFGamepadButtonPressEvent class >> inputEventMessageName [
	^ #gamepadButtonPressEvent:
]
