Class {
	#name : #WDGFVRTrackedDeviceComponent,
	#superclass : #WDGFActorComponent,
	#instVars : [
		'deviceClass',
		'deviceRole',
		'deviceTransform',
		'trackedDevice',
		'device',
		'deviceLinearVelocity',
		'deviceAngularVelocity'
	],
	#category : #'WodenGameFramework-Core-Components-VR'
}

{ #category : #accessing }
WDGFVRTrackedDeviceComponent >> deviceAngularVelocity [
	^ deviceAngularVelocity
]

{ #category : #accessing }
WDGFVRTrackedDeviceComponent >> deviceClass [

	^ deviceClass
]

{ #category : #accessing }
WDGFVRTrackedDeviceComponent >> deviceClass: anObject [

	deviceClass := anObject
]

{ #category : #accessing }
WDGFVRTrackedDeviceComponent >> deviceLinearVelocity [
	^ deviceLinearVelocity
]

{ #category : #accessing }
WDGFVRTrackedDeviceComponent >> deviceRole [

	^ deviceRole
]

{ #category : #accessing }
WDGFVRTrackedDeviceComponent >> deviceRole: aTrackedDeviceRole [
	deviceRole := aTrackedDeviceRole asVRTrackedDeviceRole
]

{ #category : #accessing }
WDGFVRTrackedDeviceComponent >> deviceTransform [

	^ deviceTransform
]

{ #category : #hooks }
WDGFVRTrackedDeviceComponent >> gotTrackedDevice [
	owner ifNotNil: [ owner send: #gotVRTrackedDevice: with: self ].
	self onGotTrackedDevice
]

{ #category : #'event handling' }
WDGFVRTrackedDeviceComponent >> handleVREvent: vrEvent [
	owner ifNotNil: [ owner send: vrEvent class gameFrameworkVREventMessageName with: vrEvent with: self ].
	vrEvent accept: self.
]

{ #category : #initialization }
WDGFVRTrackedDeviceComponent >> initialize [
	super initialize.
	deviceTransform := ReversibleAffineTransform3D identity.
]

{ #category : #hooks }
WDGFVRTrackedDeviceComponent >> lostTrackedDevice [
	owner ifNotNil: [ owner send: #lostVRTrackedDevice: with: self ].
	self onLostTrackedDevice.
]

{ #category : #'as yet unclassified' }
WDGFVRTrackedDeviceComponent >> lostTrackedDeviceForThisCycle [
	device ifNotNil: [
		device := nil.
		deviceTransform := ReversibleAffineTransform3D identity.
		self lostTrackedDevice.
	].
]

{ #category : #hooks }
WDGFVRTrackedDeviceComponent >> onGotTrackedDevice [
]

{ #category : #hooks }
WDGFVRTrackedDeviceComponent >> onLostTrackedDevice [
]

{ #category : #hooks }
WDGFVRTrackedDeviceComponent >> onUpdatedTrackedDevice [
]

{ #category : #'event handling' }
WDGFVRTrackedDeviceComponent >> onVRTrackedDeviceActivatedEvent: event [
]

{ #category : #'event handling' }
WDGFVRTrackedDeviceComponent >> onVRTrackedDeviceButtonPressedEvent: event [
]

{ #category : #'event handling' }
WDGFVRTrackedDeviceComponent >> onVRTrackedDeviceButtonReleasedEvent: event [
]

{ #category : #'event handling' }
WDGFVRTrackedDeviceComponent >> onVRTrackedDeviceButtonTouchEvent: event [
]

{ #category : #'event handling' }
WDGFVRTrackedDeviceComponent >> onVRTrackedDeviceButtonUntouchEvent: event [
]

{ #category : #'event handling' }
WDGFVRTrackedDeviceComponent >> onVRTrackedDeviceDeactivatedEvent: event [
]

{ #category : #'event handling' }
WDGFVRTrackedDeviceComponent >> onVRTrackedDeviceDualAnalogModeCancelEvent: event [
]

{ #category : #'event handling' }
WDGFVRTrackedDeviceComponent >> onVRTrackedDeviceDualAnalogModeSwitch1Event: event [
]

{ #category : #'event handling' }
WDGFVRTrackedDeviceComponent >> onVRTrackedDeviceDualAnalogModeSwitch2Event: event [
]

{ #category : #'event handling' }
WDGFVRTrackedDeviceComponent >> onVRTrackedDeviceDualAnalogMoveEvent: event [
]

{ #category : #'event handling' }
WDGFVRTrackedDeviceComponent >> onVRTrackedDeviceDualAnalogPressedEvent: event [
]

{ #category : #'event handling' }
WDGFVRTrackedDeviceComponent >> onVRTrackedDeviceDualAnalogReleasedEvent: event [
]

{ #category : #'event handling' }
WDGFVRTrackedDeviceComponent >> onVRTrackedDeviceDualAnalogTouchEvent: event [
]

{ #category : #'event handling' }
WDGFVRTrackedDeviceComponent >> onVRTrackedDeviceDualAnalogUntouchEvent: event [
]

{ #category : #'event handling' }
WDGFVRTrackedDeviceComponent >> onVRTrackedDeviceUpdatedEvent: event [
]

{ #category : #'event handling' }
WDGFVRTrackedDeviceComponent >> onVRTrackedDeviceUserInteractionEndedEvent: event [
]

{ #category : #'event handling' }
WDGFVRTrackedDeviceComponent >> onVRTrackedDeviceUserInteractionStartedEvent: event [
]

{ #category : #hooks }
WDGFVRTrackedDeviceComponent >> privateRegisterInWorld [
	ownerWorld vrSubsystem registerTrackedDeviceComponent: self

]

{ #category : #hooks }
WDGFVRTrackedDeviceComponent >> privateUnregisterFromWorld [
	ownerWorld vrSubsystem unregisterTrackedDeviceComponent: self

]

{ #category : #'as yet unclassified' }
WDGFVRTrackedDeviceComponent >> setupForLeftHand [
	self deviceClass: WDVRTrackedDeviceController.
	self deviceRole: WDVRTrackedDeviceRoleLeftHand.
]

{ #category : #'as yet unclassified' }
WDGFVRTrackedDeviceComponent >> setupForRightHand [
	self deviceClass: WDVRTrackedDeviceController.
	self deviceRole: WDVRTrackedDeviceRoleRightHand.
]

{ #category : #hooks }
WDGFVRTrackedDeviceComponent >> updatedTrackedDevice [
	owner ifNotNil: [ owner send: #updatedVRTrackedDevice: with: self ].
	self onUpdatedTrackedDevice
]

{ #category : #'as yet unclassified' }
WDGFVRTrackedDeviceComponent >> useTrackedDeviceForThisCycle: trackedDeviceForCycle [
	| isNewDevice pose |
	isNewDevice := device ~~ trackedDeviceForCycle.
	device := trackedDeviceForCycle.
	pose := device currentPose.
	deviceTransform := pose deviceToAbsoluteTransform.
	deviceLinearVelocity := pose linearVelocity.
	deviceAngularVelocity := pose angularVelocity.
	device eventHandler: self.
	isNewDevice ifTrue: [ self gotTrackedDevice ].
	self updatedTrackedDevice.
]
