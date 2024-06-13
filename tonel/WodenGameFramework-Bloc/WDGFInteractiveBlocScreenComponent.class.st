Class {
	#name : 'WDGFInteractiveBlocScreenComponent',
	#superclass : 'WDGFAbstractInteractiveScreenComponent',
	#instVars : [
		'space',
		'time'
	],
	#category : 'WodenGameFramework-Bloc',
	#package : 'WodenGameFramework-Bloc'
}

{ #category : 'construction' }
WDGFInteractiveBlocScreenComponent class >> boundingBox: aBoundingBox space: space [
	^ self new boundingBox: aBoundingBox; space: space; yourself
]

{ #category : 'construction' }
WDGFInteractiveBlocScreenComponent class >> boundingBoxHalfExtent: aHalfExtent space: texture [
	^ self boundingBox: (AABox halfExtent: aHalfExtent) space: texture
]

{ #category : 'converting' }
WDGFInteractiveBlocScreenComponent >> convertButton: osButton [
	<return: #BlMouseButton>

	osButton = 1 ifTrue: [ ^ BlMouseButton primary ].
	osButton = 2 ifTrue: [ ^ BlMouseButton middle ].
	osButton = 3 ifTrue: [ ^ BlMouseButton secondary ].

	^ BlMouseButton code: osButton
]

{ #category : 'converting' }
WDGFInteractiveBlocScreenComponent >> convertKeyModifiers: modifiers [
	<return: #BlKeyModifiers>

	^ BlKeyModifiers
		shift: modifiers shift
		ctrl: modifiers ctrl
		alt: modifiers alt
		cmd: modifiers cmd
]

{ #category : 'event management' }
WDGFInteractiveBlocScreenComponent >> dispatchEvent: anInputEvent [
	super dispatchEvent: anInputEvent.
	anInputEvent accept: self
]

{ #category : 'mouse handlers' }
WDGFInteractiveBlocScreenComponent >> enqueue: anEvent [
	space ifNil: [ ^ self ].
	space hostSpace ifNil: [ ^ self ].
	space hostSpace enqueueEvent: anEvent
]

{ #category : 'mouse handlers' }
WDGFInteractiveBlocScreenComponent >> initialize [
	super initialize.
	time := BlTime real.
]

{ #category : 'mouse handlers' }
WDGFInteractiveBlocScreenComponent >> mouseButtonPressEvent: anEvent [
	| aBlocEvent button |
	button := self convertButton: anEvent button.
	aBlocEvent := button mouseDownEventClass new
		position: anEvent position asPoint;
		screenPosition: anEvent position asPoint;
		button: button;
		modifiers: (self convertKeyModifiers: anEvent modifiers);
		timestamp: time now;
		yourself.

	self enqueue: aBlocEvent
]

{ #category : 'mouse handlers' }
WDGFInteractiveBlocScreenComponent >> mouseButtonReleaseEvent: anEvent [
	| aBlocEvent button |
	button := self convertButton: anEvent button.
	aBlocEvent := button mouseUpEventClass new
		position: anEvent position asPoint;
		screenPosition: anEvent position asPoint;
		button: button;
		modifiers: (self convertKeyModifiers: anEvent modifiers);
		timestamp: time now;
		yourself.

	self enqueue: aBlocEvent
]

{ #category : 'mouse handlers' }
WDGFInteractiveBlocScreenComponent >> mouseEntered [
	| aBlocEvent |

	aBlocEvent := BlSpaceMouseEnterEvent new
		timestamp: DateAndTime now;
		yourself.
		
	self enqueue: aBlocEvent
]

{ #category : 'mouse handlers' }
WDGFInteractiveBlocScreenComponent >> mouseLeft [
	| aBlocEvent |

	aBlocEvent := BlSpaceMouseLeaveEvent new
		timestamp: DateAndTime now;
		yourself.
		
	self enqueue: aBlocEvent
]

{ #category : 'mouse handlers' }
WDGFInteractiveBlocScreenComponent >> mouseMoveEvent: anEvent [
	| aBlocEvent |
	aBlocEvent := BlMouseMoveEvent new
		position: anEvent position asPoint;
		screenPosition: anEvent position asPoint;
		delta: anEvent delta asPoint;
		modifiers: (self convertKeyModifiers: anEvent modifiers);
		timestamp: time now;
		yourself.
		
	self enqueue: aBlocEvent
]

{ #category : 'mouse handlers' }
WDGFInteractiveBlocScreenComponent >> mouseWheelEvent: anEvent [
	Transcript show: anEvent; cr.
]

{ #category : 'accessing' }
WDGFInteractiveBlocScreenComponent >> screenExtent [
	^ space extent asPoint
]

{ #category : 'accessing' }
WDGFInteractiveBlocScreenComponent >> space [

	^ space
]

{ #category : 'accessing' }
WDGFInteractiveBlocScreenComponent >> space: anObject [

	space := anObject
]

{ #category : 'accessing' }
WDGFInteractiveBlocScreenComponent >> time [

	^ time
]

{ #category : 'accessing' }
WDGFInteractiveBlocScreenComponent >> time: anObject [

	time := anObject
]
