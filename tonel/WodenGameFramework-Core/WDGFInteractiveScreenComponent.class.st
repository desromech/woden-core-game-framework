"
I am a component which is used to express an interactive screen element inside the actor.
"
Class {
	#name : #WDGFInteractiveScreenComponent,
	#superclass : #WDGFActorSceneComponent,
	#instVars : [
		'boundingBox',
		'screenExtent',
		'currentPointerPosition',
		'currentPressedButtonMask',
		'currentPressedButtonState'
	],
	#category : #'WodenGameFramework-Core-Components-Scene'
}

{ #category : #accessing }
WDGFInteractiveScreenComponent class >> boundingBox: aBoundingBox screenExtent: screenExtent [
	^ self new boundingBox: aBoundingBox; screenExtent: screenExtent; yourself
]

{ #category : #accessing }
WDGFInteractiveScreenComponent class >> boundingBoxHalfExtent: aHalfExtent screenExtent: screenExtent [
	^ self boundingBox: (AABox halfExtent: aHalfExtent) screenExtent: screenExtent
]

{ #category : #accessing }
WDGFInteractiveScreenComponent >> boundingBox [

	^ boundingBox
]

{ #category : #accessing }
WDGFInteractiveScreenComponent >> boundingBox: anObject [

	boundingBox := anObject
]

{ #category : #'pointer dispatching' }
WDGFInteractiveScreenComponent >> containsPointInWorld: aPointInWorld [
	| localPoint |
	localPoint := self transformWorldPositionToLocal: aPointInWorld.
	^ boundingBox min x <= localPoint x and: [ localPoint x <= boundingBox max x and: [
	  boundingBox min y <= localPoint y and: [ localPoint y <= boundingBox max y ]]]
	
]

{ #category : #'event management' }
WDGFInteractiveScreenComponent >> dispatchEvent: anInputEvent [
	owner ifNotNil: [ owner send: anInputEvent inputEventMessageName with: anInputEvent ]
]

{ #category : #'pointer dispatching' }
WDGFInteractiveScreenComponent >> dispatchPointer: pointer atWorld: worldPoint withPressedButtons: buttonPressedMask [
	| pointerPosition delta |
	self dispatchPointer: pointer pressedButtonEventsFor: buttonPressedMask position: currentPointerPosition.
	
	pointerPosition := self transformWorldPointToScreen: worldPoint.
	delta := currentPointerPosition - pointerPosition.
	currentPointerPosition := pointerPosition.
	
	self dispatchEvent: (WDGFMouseMoveEvent new
		buttons: currentPressedButtonState copy;
		position: currentPointerPosition;
		delta: delta;
		yourself)
	
]

{ #category : #'as yet unclassified' }
WDGFInteractiveScreenComponent >> dispatchPointer: pointer pressedButtonEventFor: button position: position [
	self dispatchEvent: (WDGFMouseButtonPressEvent new
		buttons: currentPressedButtonState copy;
		position: position;
		button: button;
		yourself)
]

{ #category : #'as yet unclassified' }
WDGFInteractiveScreenComponent >> dispatchPointer: pointer pressedButtonEventsFor: newButtonPressedMask position: position [
	| releasedButtonMask pressedButtonMask |
	releasedButtonMask := currentPressedButtonMask bitAnd: newButtonPressedMask bitInvert.
	pressedButtonMask := currentPressedButtonMask bitInvert bitAnd: newButtonPressedMask.
	currentPressedButtonMask := newButtonPressedMask.
	currentPressedButtonState
		leftButton: (currentPressedButtonMask anyMask: 1);
		middleButton: (currentPressedButtonMask anyMask: 2);
		rightButton: (currentPressedButtonMask anyMask: 4).

	(releasedButtonMask anyMask: 1) ifTrue: [ 
		self dispatchPointer: pointer releasedButtonEventFor: 0 position: position
	].
	(releasedButtonMask anyMask: 2) ifTrue: [ 
		self dispatchPointer: pointer releasedButtonEventFor: 1 position: position
	].
	(releasedButtonMask anyMask: 4) ifTrue: [ 
		self dispatchPointer: pointer releasedButtonEventFor: 2 position: position
	].
	(pressedButtonMask anyMask: 1) ifTrue: [ 
		self dispatchPointer: pointer pressedButtonEventFor: 0 position: position
	].
	(pressedButtonMask anyMask: 2) ifTrue: [ 
		self dispatchPointer: pointer pressedButtonEventFor: 1 position: position
	].
	(pressedButtonMask anyMask: 4) ifTrue: [ 
		self dispatchPointer: pointer pressedButtonEventFor: 2 position: position
	].

]

{ #category : #'as yet unclassified' }
WDGFInteractiveScreenComponent >> dispatchPointer: pointer releasedButtonEventFor: button position: position [
	self dispatchEvent: (WDGFMouseButtonReleaseEvent new
		buttons: currentPressedButtonState copy;
		position: position;
		button: button;
		yourself)

]

{ #category : #'pointer dispatching' }
WDGFInteractiveScreenComponent >> dispatchPointerEnter: pointer atWorld: worldPoint withPressedButtons: buttonPressedMask [
	currentPointerPosition := self transformWorldPointToScreen: worldPoint.
	self dispatchPointer: pointer pressedButtonEventsFor: buttonPressedMask position: currentPointerPosition.
]

{ #category : #'pointer dispatching' }
WDGFInteractiveScreenComponent >> dispatchPointerLeave: pointer atWorld: worldPoint withPressedButtons: buttonPressedMask [
	self dispatchPointer: pointer pressedButtonEventsFor: buttonPressedMask position: currentPointerPosition.
	currentPointerPosition := self transformWorldPointToScreen: worldPoint.
]

{ #category : #initialization }
WDGFInteractiveScreenComponent >> initialize [
	super initialize.
	boundingBox := AABox unit.
	screenExtent := 64@64.
	currentPointerPosition := Vector2 zeros.
	currentPressedButtonMask := 0.
	currentPressedButtonState := WDGFInputMouseButtonState new.
]

{ #category : #testing }
WDGFInteractiveScreenComponent >> isInteractiveScreenComponent [
	^ true
]

{ #category : #accessing }
WDGFInteractiveScreenComponent >> screenExtent [

	^ screenExtent
]

{ #category : #accessing }
WDGFInteractiveScreenComponent >> screenExtent: anObject [

	screenExtent := anObject
]

{ #category : #'pointer dispatching' }
WDGFInteractiveScreenComponent >> transformWorldPointToScreen: worldPoint [
	| localPoint boxNormalizedPoint |
	localPoint := (self transformWorldPositionToLocal: worldPoint) xy.
	boxNormalizedPoint := (localPoint - boundingBox min xy) / boundingBox extent xy.
	^ Vector2 x: screenExtent x * boxNormalizedPoint x y: screenExtent y * (1.0 - boxNormalizedPoint y)
]
