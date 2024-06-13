Trait {
	#name : 'TWDGFBlEventConverter',
	#category : 'WodenGameFramework-Bloc',
	#package : 'WodenGameFramework-Bloc'
}

{ #category : 'converting' }
TWDGFBlEventConverter >> convertButton: osButton [
	<return: #BlMouseButton>

	osButton = 1 ifTrue: [ ^ BlMouseButton primary ].
	osButton = 2 ifTrue: [ ^ BlMouseButton middle ].
	osButton = 3 ifTrue: [ ^ BlMouseButton secondary ].

	^ BlMouseButton code: osButton
]

{ #category : 'converting' }
TWDGFBlEventConverter >> convertKeyModifiers: modifiers [
	<return: #BlKeyModifiers>

	^ BlKeyModifiers
		shift: modifiers shift
		ctrl: modifiers ctrl
		alt: modifiers alt
		cmd: modifiers cmd
]

{ #category : 'converting' }
TWDGFBlEventConverter >> convertMousePosition: aPoint [
	^ self convertScreenPosition: aPoint
]

{ #category : 'converting' }
TWDGFBlEventConverter >> convertScreenPosition: aPoint [
	^ aPoint
]

{ #category : 'actions' }
TWDGFBlEventConverter >> enqueue: anEvent [
	self explicitRequirement
]

{ #category : 'mouse handlers' }
TWDGFBlEventConverter >> mouseButtonPressEvent: anEvent [
	| aBlocEvent button |
	button := self convertButton: anEvent button.
	aBlocEvent := button mouseDownEventClass new
		position: (self convertMousePosition: anEvent position asPoint);
		screenPosition: (self convertScreenPosition: anEvent position asPoint);
		button: button;
		modifiers: (self convertKeyModifiers: anEvent modifiers);
		timestamp: self time now;
		yourself.

	self enqueue: aBlocEvent
]

{ #category : 'mouse handlers' }
TWDGFBlEventConverter >> mouseButtonReleaseEvent: anEvent [
	| aBlocEvent button |
	button := self convertButton: anEvent button.
	aBlocEvent := button mouseUpEventClass new
		position: (self convertMousePosition: anEvent position asPoint);
		screenPosition: (self convertScreenPosition: anEvent position asPoint);
		button: button;
		modifiers: (self convertKeyModifiers: anEvent modifiers);
		timestamp: self time now;
		yourself.

	self enqueue: aBlocEvent
]

{ #category : 'mouse handlers' }
TWDGFBlEventConverter >> mouseEntered [
	| aBlocEvent |

	aBlocEvent := BlSpaceMouseEnterEvent new
		timestamp: DateAndTime now;
		yourself.
		
	self enqueue: aBlocEvent
]

{ #category : 'mouse handlers' }
TWDGFBlEventConverter >> mouseLeft [
	| aBlocEvent |

	aBlocEvent := BlSpaceMouseLeaveEvent new
		timestamp: DateAndTime now;
		yourself.
		
	self enqueue: aBlocEvent
]

{ #category : 'mouse handlers' }
TWDGFBlEventConverter >> mouseMoveEvent: anEvent [
	| aBlocEvent |
	aBlocEvent := BlMouseMoveEvent new
		position: (self convertMousePosition: anEvent position asPoint);
		screenPosition: (self convertScreenPosition: anEvent position asPoint);
		delta: anEvent delta asPoint;
		modifiers: (self convertKeyModifiers: anEvent modifiers);
		timestamp: self time now;
		yourself.
		
	self enqueue: aBlocEvent
]

{ #category : 'mouse handlers' }
TWDGFBlEventConverter >> mouseWheelEvent: anEvent [
	Transcript show: anEvent; cr.
]
