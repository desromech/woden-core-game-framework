"
I am a subsystem that is used for receiving different UI inputs.
"
Class {
	#name : #WDGFInputSubsystem,
	#superclass : #WDGFSubsystem,
	#instVars : [
		'inputListeners'
	],
	#category : #'WodenGameFramework-Core-Subsystem'
}

{ #category : #'events-processing' }
WDGFInputSubsystem >> dispatchEvent: anEventToDispatch [
	inputListeners do: [ :each |
		each dispatchInputEvent: anEventToDispatch
	].
	
]

{ #category : #initialization }
WDGFInputSubsystem >> initialize [
	super initialize.
	inputListeners := OrderedCollection new.
]

{ #category : #initialization }
WDGFInputSubsystem >> registerInputListener: anInputListener [
	inputListeners add: anInputListener
]

{ #category : #accessing }
WDGFInputSubsystem >> updatePriority [
	^ InputUpdatePriority
]
