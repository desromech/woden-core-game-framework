"
I am a component which is used to express an interactive screen element inside the actor.
"
Class {
	#name : #WDGFAbstractInteractiveScreenComponent,
	#superclass : #WDGFActorSceneComponent,
	#instVars : [
		'boundingBox',
		'currentPointerPosition',
		'currentPressedButtonMask',
		'currentPressedButtonState'
	],
	#category : #'WodenGameFramework-Core-Components-Scene'
}

{ #category : #accessing }
WDGFAbstractInteractiveScreenComponent >> boundingBox [

	^ boundingBox
]

{ #category : #accessing }
WDGFAbstractInteractiveScreenComponent >> boundingBox: anObject [

	boundingBox := anObject
]

{ #category : #'pointer dispatching' }
WDGFAbstractInteractiveScreenComponent >> containsPointInWorld: aPointInWorld [
	| localPoint |
	localPoint := self transformWorldPositionToLocal: aPointInWorld.
	^ boundingBox min x <= localPoint x and: [ localPoint x <= boundingBox max x and: [
	  boundingBox min y <= localPoint y and: [ localPoint y <= boundingBox max y ]]]
	
]

{ #category : #'event management' }
WDGFAbstractInteractiveScreenComponent >> dispatchEvent: anInputEvent [
	owner ifNotNil: [ owner send: anInputEvent inputEventMessageName with: anInputEvent ]
]

{ #category : #'pointer dispatching' }
WDGFAbstractInteractiveScreenComponent >> dispatchPointer: pointer atWorld: worldPoint withPressedButtons: buttonPressedMask [
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

{ #category : #'pointer dispatching' }
WDGFAbstractInteractiveScreenComponent >> dispatchPointer: pointer pressedButtonEventFor: button position: position [
	self dispatchEvent: (WDGFMouseButtonPressEvent new
		buttons: currentPressedButtonState copy;
		position: position;
		button: button;
		yourself)
]

{ #category : #'pointer dispatching' }
WDGFAbstractInteractiveScreenComponent >> dispatchPointer: pointer pressedButtonEventsFor: newButtonPressedMask position: position [
	| releasedButtonMask pressedButtonMask |
	releasedButtonMask := currentPressedButtonMask bitAnd: newButtonPressedMask bitInvert.
	pressedButtonMask := currentPressedButtonMask bitInvert bitAnd: newButtonPressedMask.
	currentPressedButtonMask := newButtonPressedMask.
	currentPressedButtonState setFromMask: currentPressedButtonMask.

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

{ #category : #'pointer dispatching' }
WDGFAbstractInteractiveScreenComponent >> dispatchPointer: pointer releasedButtonEventFor: button position: position [
	self dispatchEvent: (WDGFMouseButtonReleaseEvent new
		buttons: currentPressedButtonState copy;
		position: position;
		button: button;
		yourself)

]

{ #category : #'pointer dispatching' }
WDGFAbstractInteractiveScreenComponent >> dispatchPointerEnter: pointer atWorld: worldPoint withPressedButtons: buttonPressedMask [
	currentPointerPosition := self transformWorldPointToScreen: worldPoint.
	self dispatchPointer: pointer pressedButtonEventsFor: buttonPressedMask position: currentPointerPosition.
	self mouseEntered
]

{ #category : #'pointer dispatching' }
WDGFAbstractInteractiveScreenComponent >> dispatchPointerLeave: pointer atWorld: worldPoint withPressedButtons: buttonPressedMask [
	self dispatchPointer: pointer pressedButtonEventsFor: buttonPressedMask position: currentPointerPosition.
	currentPointerPosition := self transformWorldPointToScreen: worldPoint.
	self mouseLeft
]

{ #category : #initialization }
WDGFAbstractInteractiveScreenComponent >> initialize [
	super initialize.
	boundingBox := AABox unit.
	currentPointerPosition := Vector2 zeros.
	currentPressedButtonMask := 0.
	currentPressedButtonState := WDGFInputMouseButtonState new.
]

{ #category : #testing }
WDGFAbstractInteractiveScreenComponent >> isInteractiveScreenComponent [
	^ true
]

{ #category : #'as yet unclassified' }
WDGFAbstractInteractiveScreenComponent >> mouseEntered [
]

{ #category : #'as yet unclassified' }
WDGFAbstractInteractiveScreenComponent >> mouseLeft [
]

{ #category : #accessing }
WDGFAbstractInteractiveScreenComponent >> screenExtent [
	^ self subclassResponsibility
]

{ #category : #'pointer dispatching' }
WDGFAbstractInteractiveScreenComponent >> transformWorldPointToScreen: worldPoint [
	| localPoint boxNormalizedPoint screenExtent |
	localPoint := (self transformWorldPositionToLocal: worldPoint) xy.
	boxNormalizedPoint := (localPoint - boundingBox min xy) / boundingBox extent xy.
	screenExtent := self screenExtent.
	^ Vector2 x: screenExtent x * boxNormalizedPoint x y: screenExtent y * (1.0 - boxNormalizedPoint y)
]
