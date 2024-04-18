"
I am a subsystem that takes care of sound playback.
"
Class {
	#name : #WDGFSoundSubsystem,
	#superclass : #WDGFSubsystem,
	#instVars : [
		'cameraComponents',
		'backend',
		'soundSourceComponents',
		'backendSession'
	],
	#category : #'WodenGameFramework-Core-Subsystem'
}

{ #category : #adding }
WDGFSoundSubsystem >> addCameraComponent: aCameraComponent [
	cameraComponents add: aCameraComponent.
]

{ #category : #'connection open/close' }
WDGFSoundSubsystem >> closeAndDestroy [
	super closeAndDestroy.
	self destroyBackend.
]

{ #category : #'connection open/close' }
WDGFSoundSubsystem >> destroyBackend [
	(backend isNotNil and: [ backendSession == AGPU session ]) ifTrue: [ 
		backend destroy
	].

	backend := nil.
	backendSession := nil.
]

{ #category : #update }
WDGFSoundSubsystem >> ensureBackendIsValid [
	(backend isNotNil and: [backendSession == AGPU session]) ifTrue: [^ self].
	backend := WDGFSoundSubsystemBackend findAvailable new.
	backendSession := AGPU session.
	backend initializeForSubsystem: self.
]

{ #category : #'as yet unclassified' }
WDGFSoundSubsystem >> findActiveCameraComponent [
	cameraComponents do: [ :each |
		each isActive ifTrue: [ ^ each ]
	].
	^ nil
]

{ #category : #initialization }
WDGFSoundSubsystem >> initialize [
	super initialize.
	cameraComponents := OrderedCollection new.
	soundSourceComponents := OrderedCollection new.
]

{ #category : #testing }
WDGFSoundSubsystem >> isPlaying [
	^ true
]

{ #category : #'as yet unclassified' }
WDGFSoundSubsystem >> registerSoundSourceComponent: sourceComponent [
	soundSourceComponents add: sourceComponent.
	backend ifNotNil: [
		backend registerSoundSourceComponent: sourceComponent
	].
]

{ #category : #adding }
WDGFSoundSubsystem >> removeCameraComponent: aCameraComponent [
	cameraComponents remove: aCameraComponent.
]

{ #category : #accessing }
WDGFSoundSubsystem >> soundSourceComponents [
	^ soundSourceComponents
]

{ #category : #'as yet unclassified' }
WDGFSoundSubsystem >> unregisterSoundSourceComponent: sourceComponent [
	soundSourceComponents remove: sourceComponent.
	backend ifNotNil: [
		backend unregisterSoundSourceComponent: sourceComponent
	].
]

{ #category : #update }
WDGFSoundSubsystem >> updateSingleTimeStep: delta [
	self ensureBackendIsValid.
	backend updateForSubsystem: self timeStep: delta
]
