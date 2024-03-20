"
I am a subsystem which is used for interacting with VR devices.
"
Class {
	#name : #WDGFVRSubsystem,
	#superclass : #WDGFSubsystem,
	#instVars : [
		'trackedDeviceComponents'
	],
	#category : #'WodenGameFramework-Core-Subsystem'
}

{ #category : #initialization }
WDGFVRSubsystem >> initialize [
	super initialize.
	trackedDeviceComponents := OrderedCollection new
]

{ #category : #initialization }
WDGFVRSubsystem >> registerTrackedDeviceComponent: aTrackedDeviceComponent [
	trackedDeviceComponents add: aTrackedDeviceComponent
]

{ #category : #initialization }
WDGFVRSubsystem >> unregisterTrackedDeviceComponent: aTrackedDeviceComponent [
	aTrackedDeviceComponent remove: aTrackedDeviceComponent
]

{ #category : #'as yet unclassified' }
WDGFVRSubsystem >> updateAndProcessEventsFor: vrSystem [
	| trackedDeviceMap |
	vrSystem resetTrackedDeviceEventHandlers.
	trackedDeviceMap := Dictionary new.
	vrSystem trackedDevicesDo: [ :eachTrackedDevice |
		trackedDeviceMap at: {eachTrackedDevice class . eachTrackedDevice role} put: eachTrackedDevice
	].

	trackedDeviceComponents do: [ :eachDeviceComponent |
		trackedDeviceMap at: {eachDeviceComponent deviceClass . eachDeviceComponent deviceRole} ifPresent: [ :foundTrackedDevice |
			eachDeviceComponent useTrackedDeviceForThisCycle: foundTrackedDevice
		] ifAbsent: [ 
			eachDeviceComponent lostTrackedDeviceForThisCycle
		]
	].

	vrSystem pollEvents.

]
