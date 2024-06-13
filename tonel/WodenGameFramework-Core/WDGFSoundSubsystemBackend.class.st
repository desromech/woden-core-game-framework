"
I am an abstract interface for a sound subsystem backend.
"
Class {
	#name : 'WDGFSoundSubsystemBackend',
	#superclass : 'Object',
	#category : 'WodenGameFramework-Core-Sound',
	#package : 'WodenGameFramework-Core',
	#tag : 'Sound'
}

{ #category : 'menu messages' }
WDGFSoundSubsystemBackend class >> findAvailable [
	| bestFound bestFoundPriority |
	bestFound := nil.
	bestFoundPriority := Float infinity.
	self allSubclassesDo: [ :cls |
		(cls isAbstract not and: [cls isAvailable]) ifTrue: [
			(bestFound isNil or: [cls priority < bestFoundPriority]) ifTrue: [ 
				bestFound := cls.
				bestFoundPriority := cls priority
			]
		]
	].
	self assert: bestFound notNil.
	^ bestFound
]

{ #category : 'testing' }
WDGFSoundSubsystemBackend class >> isAbstract [
	^ self == WDGFSoundSubsystemBackend
]

{ #category : 'testing' }
WDGFSoundSubsystemBackend class >> isAvailable [
	^ self subclassResponsibility
]

{ #category : 'testing' }
WDGFSoundSubsystemBackend class >> priority [
	^ self subclassResponsibility
]

{ #category : 'deleting' }
WDGFSoundSubsystemBackend >> destroy [
]

{ #category : 'initialization' }
WDGFSoundSubsystemBackend >> initializeForSubsystem: subsystem [
	self subclassResponsibility
]

{ #category : 'initialization' }
WDGFSoundSubsystemBackend >> registerSoundSourceComponent: sourceComponent [
	self subclassResponsibility
]

{ #category : 'initialization' }
WDGFSoundSubsystemBackend >> unregisterSoundSourceComponent: sourceComponent [
	self subclassResponsibility
]

{ #category : 'updating' }
WDGFSoundSubsystemBackend >> updateForSubsystem: subsystem timeStep: delta [
	self subclassResponsibility
]
