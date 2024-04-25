"
I am an actor in the Woden Game Framework. I am a concurrent entity in a world than can receive and send messages to other actors.
"
Class {
	#name : #WDGFActor,
	#superclass : #WDGFWorldElement,
	#instVars : [
		'handle',
		'subscriptions',
		'messageSubscriptions',
		'components',
		'rootSceneComponent',
		'collisionShapeComponent',
		'collisionObjectComponent',
		'wantsToTick',
		'isRegisteredInWorld'
	],
	#classVars : [
		'ZeroTransform'
	],
	#category : #'WodenGameFramework-Core-Actor'
}

{ #category : #converting }
WDGFActor class >> asGameFrameworkActor [
	^ self new
]

{ #category : #serialization }
WDGFActor class >> editorCategoryPath [
	^ 'Base Actors'
]

{ #category : #serialization }
WDGFActor class >> editorName [
	^ self jsonObjectTypeName
]

{ #category : #initialization }
WDGFActor class >> initialize [
	ZeroTransform := TRSTransform3D identity.
]

{ #category : #serialization }
WDGFActor class >> jsonObjectTypeName [
	^ self name withoutPrefix: 'WDGF'
]

{ #category : #adding }
WDGFActor >> addComponent: anObjectConvertibleToComponent [
	| aComponent |
	aComponent := anObjectConvertibleToComponent asGameFrameworkComponent.
	self assert: (self components includes: aComponent) not.
	components ifNil: [ components := OrderedCollection new ].
	components add: aComponent.
	
	aComponent addedDirectlyToActor: self.
	^ aComponent
]

{ #category : #adding }
WDGFActor >> addComponent: anObjectConvertibleToComponent noCheckBefore: oldComponent [
	| aComponent |
	aComponent := anObjectConvertibleToComponent asGameFrameworkComponent.
	self assert: (self components includes: aComponent) not.
	components add: aComponent before: oldComponent.
	^ aComponent
]

{ #category : #accessing }
WDGFActor >> angularVelocity [
	^ collisionObjectComponent
		ifNil: [ Vector3 zeros ]
		ifNotNil: [ collisionObjectComponent angularVelocity ]
]

{ #category : #accessing }
WDGFActor >> angularVelocity: aVector3 [
	collisionObjectComponent ifNotNil: [ collisionObjectComponent angularVelocity: aVector3 ]
]

{ #category : #utility }
WDGFActor >> applyForce: force [
	collisionObjectComponent ifNotNil: [ collisionObjectComponent applyForce: force ]
]

{ #category : #utility }
WDGFActor >> applyForce: force inPosition: position [
	collisionObjectComponent ifNotNil: [ collisionObjectComponent applyForce: force inPosition: position ]
]

{ #category : #utility }
WDGFActor >> applyTorque: torque [
	collisionObjectComponent ifNotNil: [ collisionObjectComponent applyTorque: torque ]
]

{ #category : #converting }
WDGFActor >> asGameFrameworkActor [
	^ self
]

{ #category : #'game events' }
WDGFActor >> beginPlay [
	"This message is sent at the beginning of a level"
]

{ #category : #accessing }
WDGFActor >> boundingBox [
	^ self localBoundingBox transformedWith: self transform
]

{ #category : #'as yet unclassified' }
WDGFActor >> collisionActorExclusionSet: aSetOfActors [
	collisionObjectComponent ifNotNil: [ collisionObjectComponent collisionActorExclusionSet: aSetOfActors ]
]

{ #category : #accessing }
WDGFActor >> collisionObjectComponent [

	^ collisionObjectComponent
]

{ #category : #accessing }
WDGFActor >> collisionObjectComponent: anObject [

	collisionObjectComponent := anObject
]

{ #category : #accessing }
WDGFActor >> collisionShapeComponent [

	^ collisionShapeComponent
]

{ #category : #accessing }
WDGFActor >> collisionShapeComponent: anObject [

	collisionShapeComponent := anObject
]

{ #category : #accessing }
WDGFActor >> components [
	^ components ifNil: [ #() ]
]

{ #category : #deleting }
WDGFActor >> destroy [
	self world ifNotNil: [ :world | world destroyActor: self ]
]

{ #category : #'game events' }
WDGFActor >> endPlay [
	"This message is sent at the end of a level"
]

{ #category : #utility }
WDGFActor >> findActorsIntersectingBox: box transform: boxTransform suchThat: aPredicate [
	^ self world findActorsIntersectingBox: box transform: boxTransform suchThat: aPredicate
]

{ #category : #utility }
WDGFActor >> findActorsIntersectingSphere: sphere suchThat: aPredicate [
	^ self world findActorsIntersectingSphere: sphere suchThat: aPredicate
]

{ #category : #utility }
WDGFActor >> findActorsIntersectingSphere: sphere transform: boxTransform suchThat: aPredicate [
	^ self world findActorsIntersectingSphere: sphere transform: boxTransform suchThat: aPredicate
]

{ #category : #'input events' }
WDGFActor >> gamepadAxisEvent: anEvent [
]

{ #category : #'input events' }
WDGFActor >> gamepadButtonPressEvent: anEvent [
]

{ #category : #'input events' }
WDGFActor >> gamepadButtonReleaseEvent: anEvent [
]

{ #category : #accessing }
WDGFActor >> handle [
	^ handle
]

{ #category : #testing }
WDGFActor >> hasRigidBody [
	^ collisionObjectComponent isNotNil and: [ collisionObjectComponent isRigidBodyComponent ]
]

{ #category : #testing }
WDGFActor >> hasSolidCollision [
	^ collisionObjectComponent isNotNil and: [ collisionObjectComponent isSolidCollision ]
]

{ #category : #initialization }
WDGFActor >> initialize [
	super initialize.
	handle := WDGFActorHandle for: self.
	isRegisteredInWorld := false.
	wantsToTick := false.
	self setupComponents
]

{ #category : #'input events' }
WDGFActor >> keyDownEvent: anEvent [
]

{ #category : #'input events' }
WDGFActor >> keyUpEvent: anEvent [
]

{ #category : #accessing }
WDGFActor >> linearVelocity [
	^ collisionObjectComponent
		ifNil: [ Vector3 zeros ]
		ifNotNil: [ collisionObjectComponent linearVelocity ]
]

{ #category : #accessing }
WDGFActor >> linearVelocity: aVector3 [
	collisionObjectComponent ifNotNil: [ collisionObjectComponent linearVelocity: aVector3 ]
]

{ #category : #accessing }
WDGFActor >> localBoundingBox [
	^ collisionShapeComponent
		ifNil: [ AABox originPoint ]
		ifNotNil: [ collisionShapeComponent localBoundingBox ]
]

{ #category : #accessing }
WDGFActor >> mass [
	^ collisionObjectComponent mass
]

{ #category : #message }
WDGFActor >> messageSubscriptions [
	^ messageSubscriptions ifNil: [ messageSubscriptions := WDGFActorMessageSubscriptions new ]
]

{ #category : #'input events' }
WDGFActor >> mouseButtonPressEvent: anEvent [
]

{ #category : #'input events' }
WDGFActor >> mouseButtonReleaseEvent: anEvent [
]

{ #category : #'input events' }
WDGFActor >> mouseMoveEvent: anEvent [
]

{ #category : #'input events' }
WDGFActor >> mouseWheelEvent: anEvent [
]

{ #category : #'game events' }
WDGFActor >> onBeginPlayDo: aBlock [
	^ self onMessage: #beginPlay do: aBlock
]

{ #category : #'game events' }
WDGFActor >> onEndPlayDo: aBlock [
	^ self onMessage: #endPlay do: aBlock
]

{ #category : #'input events' }
WDGFActor >> onGamepadAxisEventDo: aBlock [
	^ self onMessage: #gamepadAxisEvent: do: aBlock
]

{ #category : #'input events' }
WDGFActor >> onGamepadButtonPressEventDo: aBlock [
	^ self onMessage: #gamepadButtonPressEvent: do: aBlock
]

{ #category : #'input events' }
WDGFActor >> onGamepadButtonReleaseEventDo: aBlock [
	^ self onMessage: #gamepadButtonReleaseEvent: do: aBlock
]

{ #category : #'input events' }
WDGFActor >> onKeyDownEventDo: aBlock [
	^ self onMessage: #keyDownEvent: do: aBlock
]

{ #category : #'input events' }
WDGFActor >> onKeyUpEventDo: aBlock [
	^ self onMessage: #keyUpEvent: do: aBlock
]

{ #category : #message }
WDGFActor >> onMessage: selector do: aBlock [
	^ self messageSubscriptions addFor: selector doing: aBlock
]

{ #category : #'input events' }
WDGFActor >> onMouseButtonPressEventDo: aBlock [
	^ self onMessage: #mouseButtonPressEvent: do: aBlock
]

{ #category : #'input events' }
WDGFActor >> onMouseButtonReleaseEventDo: aBlock [
	^ self onMessage: #mouseButtonReleaseEvent: do: aBlock
]

{ #category : #'input events' }
WDGFActor >> onMouseMoveEventDo: aBlock [
	^ self onMessage: #mouseMoveEvent: do: aBlock
]

{ #category : #'input events' }
WDGFActor >> onMouseWheelEventDo: aBlock [
	^ self onMessage: #mouseWheelEvent: do: aBlock
]

{ #category : #'input events' }
WDGFActor >> onTextInputEventDo: aBlock [
	^ self onMessage: #textInputEvent: do: aBlock
]

{ #category : #'game events' }
WDGFActor >> onTickDo: aBlock [
	^ self onMessage: #tick: do: aBlock
]

{ #category : #accessing }
WDGFActor >> orientation [
	^ self transform rotation
]

{ #category : #accessing }
WDGFActor >> orientation: newOrientation [
	rootSceneComponent ifNotNil: [ rootSceneComponent orientation: newOrientation ]
]

{ #category : #accessing }
WDGFActor >> position [
	^ self transform translation
]

{ #category : #accessing }
WDGFActor >> position: newPosition [
	rootSceneComponent ifNotNil: [ rootSceneComponent position: newPosition ]
]

{ #category : #copying }
WDGFActor >> postCopy [
	super postCopy.
	handle := WDGFActorHandle for: self.
]

{ #category : #message }
WDGFActor >> processMessage: message [
	^ self processMessage: message selector withArguments: message arguments
]

{ #category : #message }
WDGFActor >> processMessage: selector withArguments: arguments [
	(self respondsTo: selector) ifTrue: [
		self perform: selector withArguments: arguments
	].

	messageSubscriptions ifNotNil: [
		messageSubscriptions processMessage: selector withArguments: arguments
	].

]

{ #category : #utility }
WDGFActor >> rayCast: ray forFirstActorSuchThat: aPredicate [
	^ self world rayCast: ray excludingActors: { self } forFirstActorSuchThat: aPredicate
]

{ #category : #'component registration' }
WDGFActor >> registerWithSubsystemsInWorld: theWorld [
	isRegisteredInWorld ifTrue: [ ^ self ].
	isRegisteredInWorld := true.
	wantsToTick ifTrue: [ self subscribeForTicking ].
	rootSceneComponent ifNotNil: [ rootSceneComponent registerInWorld: theWorld ].
	self components do: [ :each | each registerInWorld: theWorld ]
]

{ #category : #accessing }
WDGFActor >> rootSceneComponent [

	^ rootSceneComponent
]

{ #category : #accessing }
WDGFActor >> rootSceneComponent: anObject [

	rootSceneComponent := anObject
]

{ #category : #accessing }
WDGFActor >> scale [
	^ self transform scale
]

{ #category : #accessing }
WDGFActor >> scale: newScale [
	rootSceneComponent ifNotNil: [ rootSceneComponent scale: newScale ]
]

{ #category : #message }
WDGFActor >> send: selector [
	^ self send: selector withArguments: #()
]

{ #category : #message }
WDGFActor >> send: selector with: arg1 [ 
	^ self send: selector withArguments: { arg1 }
]

{ #category : #message }
WDGFActor >> send: selector with: arg1 with: arg2 [
	^ self send: selector withArguments: { arg1 . arg2 }
]

{ #category : #message }
WDGFActor >> send: selector with: arg1 with: arg2 with: arg3 [
	^ self send: selector withArguments: { arg1 . arg2 . arg3 }
]

{ #category : #message }
WDGFActor >> send: selector with: arg1 with: arg2 with: arg3 with: arg4 [
	^ self send: selector withArguments: { arg1 . arg2 . arg3 . arg4 }
]

{ #category : #message }
WDGFActor >> send: selector withArguments: arguments [
	^ WDGFActorMessage new
		target: handle;
		selector: selector;
		arguments: arguments;
		enqueue
]

{ #category : #initialization }
WDGFActor >> setupComponents [
	"This is a place for setting up different actor components."
]

{ #category : #'system subscriptions' }
WDGFActor >> subscribeForTicking [
	(self world getOrCreateSubsystemWithClass: WDGFActorTickSubsystem) subscribe: self
]

{ #category : #utility }
WDGFActor >> teleportTo: targetPosition [
	self flag: 'TODO: Suppress movement interpolation.'.
	self position: targetPosition
]

{ #category : #'input events' }
WDGFActor >> textInputEvent: anEvent [
]

{ #category : #'game events' }
WDGFActor >> tick: deltaSeconds [
	"This message is sent when the actor wants to receive a tick."
]

{ #category : #accessing }
WDGFActor >> transform [
	^ rootSceneComponent ifNil: [ ZeroTransform ] ifNotNil: [ rootSceneComponent transform ]
]

{ #category : #accessing }
WDGFActor >> transform: newTransform [
	rootSceneComponent ifNotNil: [ rootSceneComponent transform: newTransform ]
]

{ #category : #utility }
WDGFActor >> transformLocalPosition: localPosition [
	^ self transform transformPosition: localPosition 
	
]

{ #category : #utility }
WDGFActor >> transformOrientationToWorld: orientation [
	^ self transform rotation * orientation
	
]

{ #category : #utility }
WDGFActor >> transformPositionToWorld: localPosition [
	^ self transform transformPosition: localPosition 
	
]

{ #category : #utility }
WDGFActor >> transformVectorToWorld: localVector [
	^ self transform transformVector3: localVector
	
]

{ #category : #utility }
WDGFActor >> transformWorldOrientationToLocal: orientation [
	^ self transform inverseRotation * orientation
	
]

{ #category : #utility }
WDGFActor >> transformWorldPositionToLocal: localPosition [
	^ self transform inverseTransformPosition: localPosition 
	
]

{ #category : #'component registration' }
WDGFActor >> unregisterFromSubsystemsInWorld: theWorld [
	isRegisteredInWorld ifFalse: [ ^ self ].
	wantsToTick ifTrue: [ self unsubscribeForTicking ].
	rootSceneComponent ifNotNil: [ rootSceneComponent unregisterFromWorld: theWorld ].
	self components do: [ :each | each unregisterFromWorld: theWorld ].
	isRegisteredInWorld := false.
]

{ #category : #'system subscriptions' }
WDGFActor >> unsubscribeForTicking [
	(self world getOrCreateSubsystemWithClass: WDGFActorTickSubsystem) unsubscribe: self
]

{ #category : #'vr events' }
WDGFActor >> vrTrackedDeviceActivatedEvent: event from: trackedDeviceComponent [
]

{ #category : #'vr events' }
WDGFActor >> vrTrackedDeviceButtonPressedEvent: event from: trackedDeviceComponent [
]

{ #category : #'vr events' }
WDGFActor >> vrTrackedDeviceButtonReleasedEvent: event from: trackedDeviceComponent [
]

{ #category : #'vr events' }
WDGFActor >> vrTrackedDeviceButtonTouchEvent: event from: trackedDeviceComponent [
]

{ #category : #'vr events' }
WDGFActor >> vrTrackedDeviceButtonUntouchEvent: event from: trackedDeviceComponent [
]

{ #category : #'vr events' }
WDGFActor >> vrTrackedDeviceDeactivatedEvent: event from: trackedDeviceComponent [
]

{ #category : #'vr events' }
WDGFActor >> vrTrackedDeviceDualAnalogModeCancelEvent: event from: trackedDeviceComponent [
]

{ #category : #'vr events' }
WDGFActor >> vrTrackedDeviceDualAnalogModeSwitch1Event: event from: trackedDeviceComponent [
]

{ #category : #'vr events' }
WDGFActor >> vrTrackedDeviceDualAnalogModeSwitch2Event: event from: trackedDeviceComponent [
]

{ #category : #'vr events' }
WDGFActor >> vrTrackedDeviceDualAnalogMoveEvent: event from: trackedDeviceComponent [
]

{ #category : #'vr events' }
WDGFActor >> vrTrackedDeviceDualAnalogPressedEvent: event from: trackedDeviceComponent [
]

{ #category : #'vr events' }
WDGFActor >> vrTrackedDeviceDualAnalogReleasedEvent: event from: trackedDeviceComponent [
]

{ #category : #'vr events' }
WDGFActor >> vrTrackedDeviceDualAnalogTouchEvent: event from: trackedDeviceComponent [
]

{ #category : #'vr events' }
WDGFActor >> vrTrackedDeviceDualAnalogUntouchEvent: event from: trackedDeviceComponent [
]

{ #category : #'vr events' }
WDGFActor >> vrTrackedDeviceUpdatedEvent: event from: trackedDeviceComponent [
]

{ #category : #'vr events' }
WDGFActor >> vrTrackedDeviceUserInteractionEndedEvent: event from: trackedDeviceComponent [
]

{ #category : #'vr events' }
WDGFActor >> vrTrackedDeviceUserInteractionStartedEvent: event from: trackedDeviceComponent [
]

{ #category : #accessing }
WDGFActor >> wantsToTick [

	^ wantsToTick
]

{ #category : #accessing }
WDGFActor >> wantsToTick: aBoolean [
	wantsToTick := aBoolean.
	isRegisteredInWorld ifTrue: [ 
		wantsToTick ifTrue: [
			self subscribeForTicking
		] ifFalse: [ 
			self unsubscribeForTicking
		].
	].

]

{ #category : #accessing }
WDGFActor >> world [
	^ handle world
]

{ #category : #accessing }
WDGFActor >> worldInertiaTensor [
	^ collisionObjectComponent worldInertiaTensor
]
