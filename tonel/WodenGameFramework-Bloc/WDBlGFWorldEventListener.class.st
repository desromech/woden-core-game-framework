"
I am an event listener that converts Bloc events into the events used by the Woden Game Framework.
"
Class {
	#name : 'WDBlGFWorldEventListener',
	#superclass : 'BlEventListener',
	#instVars : [
		'worldElement'
	],
	#category : 'WodenGameFramework-Bloc',
	#package : 'WodenGameFramework-Bloc'
}

{ #category : 'converting' }
WDBlGFWorldEventListener >> convertModifiers: blocModifiers [
	^ WDGFInputStateModifiers new
		leftShift: blocModifiers isShift;
		leftAlt: blocModifiers isAlt;
		leftCtrl: blocModifiers isCtrl;
		leftCmd: blocModifiers isCmd;
		capsLock: blocModifiers isCapsLock;
		numLock: blocModifiers isNumLock;
		yourself
]

{ #category : 'events' }
WDBlGFWorldEventListener >> convertMouseButtonState: blocEvent [
	^ WDGFInputMouseButtonState new
		leftButton: blocEvent primaryButtonPressed;
		middleButton: blocEvent middleButtonPressed;
		rightButton: blocEvent secondaryButtonPressed;
		yourself
]

{ #category : 'keyboard handlers' }
WDBlGFWorldEventListener >> keyDownEvent: anEvent [
	worldElement enqueueConvertedEvent: (WDGFKeyDownEvent new
		modifiers: (self convertModifiers: anEvent modifiers);
		symbol: anEvent key;
		yourself)
]

{ #category : 'keyboard handlers' }
WDBlGFWorldEventListener >> keyUpEvent: anEvent [
	worldElement enqueueConvertedEvent: (WDGFKeyUpEvent new
		modifiers: (self convertModifiers: anEvent modifiers);
		symbol: anEvent key;
		yourself)
]

{ #category : 'mouse handlers' }
WDBlGFWorldEventListener >> mouseDownEvent: anEvent [
]

{ #category : 'mouse handlers' }
WDBlGFWorldEventListener >> mouseEnterEvent: anEvent [
	anEvent consumed: true.
	worldElement requestFocus.
]

{ #category : 'mouse handlers' }
WDBlGFWorldEventListener >> mouseMoveEvent: anEvent [
	worldElement enqueueConvertedEvent: (WDGFMouseMoveEvent new
		modifiers: (self convertModifiers: anEvent modifiers);
		buttons: (self convertMouseButtonState: anEvent);
		position: (Vector2 x: anEvent position x y: anEvent position y);
		delta: (Vector2 x: anEvent delta x y: anEvent delta y);
		yourself)
]

{ #category : 'mouse handlers' }
WDBlGFWorldEventListener >> mouseUpEvent: anEvent [
]

{ #category : 'mouse handlers' }
WDBlGFWorldEventListener >> mouseWheelEvent: anEvent [
]

{ #category : 'api - hooks' }
WDBlGFWorldEventListener >> onInstalledIn: anElement [
	worldElement := anElement
]

{ #category : 'mouse handlers' }
WDBlGFWorldEventListener >> textInputEvent: anEvent [
	worldElement enqueueConvertedEvent: (WDGFTextInputEvent new
		modifiers: (self convertModifiers: anEvent modifiers);
		text: anEvent text;
		yourself)
]
