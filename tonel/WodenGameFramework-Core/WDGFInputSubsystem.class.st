"
I am a subsystem that is used for receiving different UI inputs.
"
Class {
	#name : #WDGFInputSubsystem,
	#superclass : #WDGFSubsystem,
	#instVars : [
		'inputListeners',
		'supportsMouseCapture',
		'captureMouseBlock',
		'releaseMouseBlock',
		'hasMouseCaptureBlock'
	],
	#category : #'WodenGameFramework-Core-Subsystem'
}

{ #category : #'mouse capture' }
WDGFInputSubsystem >> captureMouse [
	captureMouseBlock value
]

{ #category : #'events-processing' }
WDGFInputSubsystem >> dispatchEvent: anEventToDispatch [
	inputListeners do: [ :each |
		each dispatchInputEvent: anEventToDispatch
	].
	
]

{ #category : #accessing }
WDGFInputSubsystem >> hasMouseCapture [
	^ hasMouseCaptureBlock value
]

{ #category : #accessing }
WDGFInputSubsystem >> hasMouseCaptureBlock: aBlock [
	hasMouseCaptureBlock := aBlock
]

{ #category : #initialization }
WDGFInputSubsystem >> initialize [
	super initialize.
	inputListeners := OrderedCollection new.
	supportsMouseCapture := false.
	hasMouseCaptureBlock := [false].
	captureMouseBlock := [].
	releaseMouseBlock := [].
	
]

{ #category : #enumerating }
WDGFInputSubsystem >> onCaptureMouseDo: aBlock [
	captureMouseBlock := aBlock
]

{ #category : #enumerating }
WDGFInputSubsystem >> onReleaseMouseDo: aBlock [
	releaseMouseBlock := aBlock
]

{ #category : #initialization }
WDGFInputSubsystem >> registerInputListener: anInputListener [
	inputListeners add: anInputListener
]

{ #category : #'mouse capture' }
WDGFInputSubsystem >> releaseMouse [
	releaseMouseBlock value
]

{ #category : #accessing }
WDGFInputSubsystem >> supportsMouseCapture [

	^ supportsMouseCapture
]

{ #category : #accessing }
WDGFInputSubsystem >> supportsMouseCapture: anObject [

	supportsMouseCapture := anObject
]

{ #category : #initialization }
WDGFInputSubsystem >> unregisterInputListener: anInputListener [
	inputListeners remove: anInputListener
]

{ #category : #accessing }
WDGFInputSubsystem >> updatePriority [
	^ InputUpdatePriority
]
