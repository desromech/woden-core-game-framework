Class {
	#name : 'WDGFVRTrackedDeviceComponent',
	#superclass : 'WDGFActorComponent',
	#instVars : [
		'deviceClass',
		'deviceRole',
		'deviceTransform',
		'device',
		'deviceLinearVelocity',
		'deviceAngularVelocity',
		'analogButtonPressedState',
		'lastAnalogButtonPressedState',
		'lastAnalogButtonTouchedState',
		'analogButtonTouchedState'
	],
	#classVars : [
		'AnalogFirstTriggerPressed',
		'AnalogJoystickButtonDown',
		'AnalogJoystickButtonLeft',
		'AnalogJoystickButtonRight',
		'AnalogJoystickButtonUp',
		'AnalogSecondTriggerPressed',
		'AxisPressedThreshold',
		'AxisTouchedThreshold'
	],
	#category : 'WodenGameFramework-Core-Components-VR',
	#package : 'WodenGameFramework-Core',
	#tag : 'Components-VR'
}

{ #category : 'class initialization' }
WDGFVRTrackedDeviceComponent class >> initialize [
	AnalogJoystickButtonLeft := 1<<0.
	AnalogJoystickButtonRight := 1<<1.
	AnalogJoystickButtonDown := 1<<2.
	AnalogJoystickButtonUp := 1<<3.
	AnalogFirstTriggerPressed := 1<<4.
	AnalogSecondTriggerPressed := 1<<5.
	AxisTouchedThreshold := 0.15.
	AxisPressedThreshold := 0.5.

]

{ #category : 'accessing' }
WDGFVRTrackedDeviceComponent >> deviceAngularVelocity [
	^ deviceAngularVelocity
]

{ #category : 'accessing' }
WDGFVRTrackedDeviceComponent >> deviceClass [

	^ deviceClass
]

{ #category : 'accessing' }
WDGFVRTrackedDeviceComponent >> deviceClass: anObject [

	deviceClass := anObject
]

{ #category : 'accessing' }
WDGFVRTrackedDeviceComponent >> deviceLinearVelocity [
	^ deviceLinearVelocity
]

{ #category : 'accessing' }
WDGFVRTrackedDeviceComponent >> deviceRole [

	^ deviceRole
]

{ #category : 'accessing' }
WDGFVRTrackedDeviceComponent >> deviceRole: aTrackedDeviceRole [
	deviceRole := aTrackedDeviceRole asVRTrackedDeviceRole
]

{ #category : 'accessing' }
WDGFVRTrackedDeviceComponent >> deviceTransform [

	^ deviceTransform
]

{ #category : 'as yet unclassified' }
WDGFVRTrackedDeviceComponent >> dispatchAnalogButtonEvent [
	| touchedButtonMask untouchedButtonMask pressedButtonMask releasedButtonMask |
	touchedButtonMask := lastAnalogButtonTouchedState bitInvert & analogButtonTouchedState.
	untouchedButtonMask := lastAnalogButtonTouchedState & analogButtonTouchedState bitInvert.

	pressedButtonMask := lastAnalogButtonPressedState bitInvert & analogButtonPressedState.
	releasedButtonMask := lastAnalogButtonPressedState & analogButtonPressedState bitInvert.
	
	releasedButtonMask ~= 0 ifTrue: [ 
		self onVRTrackedDeviceAnalogButtonReleased: releasedButtonMask
	].

	untouchedButtonMask ~= 0 ifTrue: [ 
		self onVRTrackedDeviceAnalogButtonUntouched: releasedButtonMask
	].

	touchedButtonMask ~= 0 ifTrue: [ 
		self onVRTrackedDeviceAnalogButtonTouched: touchedButtonMask
	].

	pressedButtonMask ~= 0 ifTrue: [ 
		self onVRTrackedDeviceAnalogButtonPressed: pressedButtonMask
	].

]

{ #category : 'hooks' }
WDGFVRTrackedDeviceComponent >> gotTrackedDevice [
	owner ifNotNil: [ owner send: #gotVRTrackedDevice: with: self ].
	analogButtonPressedState := 0.
	self updateAnalogButtonStates.
	self onGotTrackedDevice.
	self dispatchAnalogButtonEvent.
]

{ #category : 'event handling' }
WDGFVRTrackedDeviceComponent >> handleVREvent: vrEvent [
	owner ifNotNil: [ owner send: vrEvent class gameFrameworkVREventMessageName with: vrEvent with: self ].
	vrEvent accept: self.
]

{ #category : 'initialization' }
WDGFVRTrackedDeviceComponent >> initialize [
	super initialize.
	deviceTransform := ReversibleAffineTransform3D identity.
	lastAnalogButtonPressedState := 0.
	lastAnalogButtonTouchedState := 0.
	analogButtonPressedState := 0.
	analogButtonTouchedState := 0.
]

{ #category : 'hooks' }
WDGFVRTrackedDeviceComponent >> lostTrackedDevice [
	owner ifNotNil: [ owner send: #lostVRTrackedDevice: with: self ].
	analogButtonPressedState := 0.
	self onLostTrackedDevice.
	self dispatchAnalogButtonEvent.
]

{ #category : 'as yet unclassified' }
WDGFVRTrackedDeviceComponent >> lostTrackedDeviceForThisCycle [
	device ifNotNil: [
		device := nil.
		deviceTransform := ReversibleAffineTransform3D identity.
		self lostTrackedDevice.
	].
]

{ #category : 'hooks' }
WDGFVRTrackedDeviceComponent >> onGotTrackedDevice [
]

{ #category : 'hooks' }
WDGFVRTrackedDeviceComponent >> onLostTrackedDevice [
]

{ #category : 'hooks' }
WDGFVRTrackedDeviceComponent >> onUpdatedTrackedDevice [
]

{ #category : 'event handling' }
WDGFVRTrackedDeviceComponent >> onVRTrackedDeviceActivatedEvent: event [
]

{ #category : 'as yet unclassified' }
WDGFVRTrackedDeviceComponent >> onVRTrackedDeviceAnalogButtonPressed: mask [
]

{ #category : 'as yet unclassified' }
WDGFVRTrackedDeviceComponent >> onVRTrackedDeviceAnalogButtonReleased: mask [
]

{ #category : 'as yet unclassified' }
WDGFVRTrackedDeviceComponent >> onVRTrackedDeviceAnalogButtonTouched: mask [
]

{ #category : 'as yet unclassified' }
WDGFVRTrackedDeviceComponent >> onVRTrackedDeviceAnalogButtonUntouched: mask [
]

{ #category : 'event handling' }
WDGFVRTrackedDeviceComponent >> onVRTrackedDeviceButtonPressedEvent: event [
]

{ #category : 'event handling' }
WDGFVRTrackedDeviceComponent >> onVRTrackedDeviceButtonReleasedEvent: event [
]

{ #category : 'event handling' }
WDGFVRTrackedDeviceComponent >> onVRTrackedDeviceButtonTouchEvent: event [
]

{ #category : 'event handling' }
WDGFVRTrackedDeviceComponent >> onVRTrackedDeviceButtonUntouchEvent: event [
]

{ #category : 'event handling' }
WDGFVRTrackedDeviceComponent >> onVRTrackedDeviceDeactivatedEvent: event [
]

{ #category : 'event handling' }
WDGFVRTrackedDeviceComponent >> onVRTrackedDeviceDualAnalogModeCancelEvent: event [
]

{ #category : 'event handling' }
WDGFVRTrackedDeviceComponent >> onVRTrackedDeviceDualAnalogModeSwitch1Event: event [
]

{ #category : 'event handling' }
WDGFVRTrackedDeviceComponent >> onVRTrackedDeviceDualAnalogModeSwitch2Event: event [
]

{ #category : 'event handling' }
WDGFVRTrackedDeviceComponent >> onVRTrackedDeviceDualAnalogMoveEvent: event [
]

{ #category : 'event handling' }
WDGFVRTrackedDeviceComponent >> onVRTrackedDeviceDualAnalogPressedEvent: event [
]

{ #category : 'event handling' }
WDGFVRTrackedDeviceComponent >> onVRTrackedDeviceDualAnalogReleasedEvent: event [
]

{ #category : 'event handling' }
WDGFVRTrackedDeviceComponent >> onVRTrackedDeviceDualAnalogTouchEvent: event [
]

{ #category : 'event handling' }
WDGFVRTrackedDeviceComponent >> onVRTrackedDeviceDualAnalogUntouchEvent: event [
]

{ #category : 'event handling' }
WDGFVRTrackedDeviceComponent >> onVRTrackedDeviceUpdatedEvent: event [
]

{ #category : 'event handling' }
WDGFVRTrackedDeviceComponent >> onVRTrackedDeviceUserInteractionEndedEvent: event [
]

{ #category : 'event handling' }
WDGFVRTrackedDeviceComponent >> onVRTrackedDeviceUserInteractionStartedEvent: event [
]

{ #category : 'hooks' }
WDGFVRTrackedDeviceComponent >> privateRegisterInWorld [
	ownerWorld vrSubsystem registerTrackedDeviceComponent: self

]

{ #category : 'hooks' }
WDGFVRTrackedDeviceComponent >> privateUnregisterFromWorld [
	ownerWorld vrSubsystem unregisterTrackedDeviceComponent: self

]

{ #category : 'as yet unclassified' }
WDGFVRTrackedDeviceComponent >> setupForLeftHand [
	self deviceClass: WDVRTrackedDeviceController.
	self deviceRole: WDVRTrackedDeviceRoleLeftHand.
]

{ #category : 'as yet unclassified' }
WDGFVRTrackedDeviceComponent >> setupForRightHand [
	self deviceClass: WDVRTrackedDeviceController.
	self deviceRole: WDVRTrackedDeviceRoleRightHand.
]

{ #category : 'hooks' }
WDGFVRTrackedDeviceComponent >> updateAnalogButtonStates [
	| controllerState setJoysticButtons |
	controllerState := device controllerState.
	controllerState ifNil: [ ^ self ].
	
	lastAnalogButtonPressedState := analogButtonPressedState.
	lastAnalogButtonTouchedState := analogButtonTouchedState.
	analogButtonPressedState := 0.
	analogButtonTouchedState := 0.
	
	setJoysticButtons := [ :axis |
		axis x <= AxisTouchedThreshold negated ifTrue: [
			analogButtonTouchedState := analogButtonTouchedState | AnalogJoystickButtonLeft.
		].
		axis x >= AxisTouchedThreshold ifTrue: [
			analogButtonTouchedState := analogButtonTouchedState | AnalogJoystickButtonRight.
		].
		axis y <= AxisTouchedThreshold negated ifTrue: [
			analogButtonTouchedState := analogButtonTouchedState | AnalogJoystickButtonDown.
		].
		axis y >= AxisTouchedThreshold ifTrue: [
			analogButtonTouchedState := analogButtonTouchedState | AnalogJoystickButtonUp.
		].

		axis x <= AxisPressedThreshold negated ifTrue: [
			analogButtonPressedState := analogButtonPressedState | AnalogJoystickButtonLeft.
		].
		axis x >= AxisPressedThreshold ifTrue: [
			analogButtonPressedState := analogButtonPressedState | AnalogJoystickButtonRight.
		].
		axis y <= AxisPressedThreshold negated ifTrue: [
			analogButtonPressedState := analogButtonPressedState | AnalogJoystickButtonDown.
		].
		axis y >= AxisPressedThreshold ifTrue: [
			analogButtonPressedState := analogButtonPressedState | AnalogJoystickButtonUp.
		].
	].
	
	controllerState joysticks isEmpty ifFalse: [
		setJoysticButtons value: controllerState joysticks first.
	].

	controllerState trackpads isEmpty ifFalse: [
		setJoysticButtons value: controllerState trackpads first.
	].

	controllerState triggers size >= 1 ifTrue: [
		(controllerState triggers first x >= AxisTouchedThreshold) ifTrue: [
			analogButtonTouchedState := analogButtonTouchedState | AnalogFirstTriggerPressed
		].

		(controllerState triggers first x >= AxisPressedThreshold) ifTrue: [
			analogButtonPressedState := analogButtonPressedState | AnalogFirstTriggerPressed
		]
	].

	controllerState triggers size >= 2 ifTrue: [
		(controllerState triggers second x >= AxisTouchedThreshold) ifTrue: [
			analogButtonTouchedState := analogButtonTouchedState | AnalogSecondTriggerPressed
		].
	
		(controllerState triggers second x >= AxisPressedThreshold) ifTrue: [
			analogButtonPressedState := analogButtonPressedState | AnalogSecondTriggerPressed
		]
	].

]

{ #category : 'hooks' }
WDGFVRTrackedDeviceComponent >> updatedTrackedDevice [
	owner ifNotNil: [ owner send: #updatedVRTrackedDevice: with: self ].
	self updateAnalogButtonStates.
	self dispatchAnalogButtonEvent.
	self onUpdatedTrackedDevice
]

{ #category : 'as yet unclassified' }
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
