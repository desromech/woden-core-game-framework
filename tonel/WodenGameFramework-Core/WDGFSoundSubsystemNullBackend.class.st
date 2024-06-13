"
I am a null sound subsystem.
"
Class {
	#name : 'WDGFSoundSubsystemNullBackend',
	#superclass : 'WDGFSoundSubsystemBackend',
	#category : 'WodenGameFramework-Core-Sound',
	#package : 'WodenGameFramework-Core',
	#tag : 'Sound'
}

{ #category : 'testing' }
WDGFSoundSubsystemNullBackend class >> isAvailable [
	^ true
]

{ #category : 'testing' }
WDGFSoundSubsystemNullBackend class >> priority [
	^ 100
]

{ #category : 'initialization' }
WDGFSoundSubsystemNullBackend >> initializeForSubsystem: subsystem [
	"Nothing is required here"
]

{ #category : 'initialization' }
WDGFSoundSubsystemNullBackend >> registerSoundSourceComponent: sourceComponent [
	"Nothing is required here"
]

{ #category : 'initialization' }
WDGFSoundSubsystemNullBackend >> unregisterSoundSourceComponent: sourceComponent [
	"Nothing is required here"
]

{ #category : 'updating' }
WDGFSoundSubsystemNullBackend >> updateForSubsystem: subsystem timeStep: delta [
	"Do nothing in this backend."
]
