"
I am a subsystem in the game framework.
"
Class {
	#name : #WDGFSubsystem,
	#superclass : #Object,
	#instVars : [
		'ownerWorld'
	],
	#classVars : [
		'DefaultUpdatePriority',
		'InputUpdatePriority',
		'PhysicsUpdatePriority',
		'SceneUpdatePriority',
		'TickUpdatePriority'
	],
	#category : #'WodenGameFramework-Core-Subsystem'
}

{ #category : #'class initialization' }
WDGFSubsystem class >> initialize [
	InputUpdatePriority := 1.
	TickUpdatePriority := 2.
	PhysicsUpdatePriority := 3.
	
	DefaultUpdatePriority := 10.
	SceneUpdatePriority := 100.

]

{ #category : #notifying }
WDGFSubsystem >> beginPlay [
]

{ #category : #notifying }
WDGFSubsystem >> createdInWorld: newOwnerWorld [
	self assert: ownerWorld isNil.
	ownerWorld := newOwnerWorld
]

{ #category : #accessing }
WDGFSubsystem >> ownerWorld [
	^ ownerWorld
]

{ #category : #update }
WDGFSubsystem >> postActorMessagesUpdateSingleTimeStep: delta [
]

{ #category : #update }
WDGFSubsystem >> prePhysicsUpdateSingleTimeStep: delta [
]

{ #category : #accessing }
WDGFSubsystem >> updatePriority [
	^ DefaultUpdatePriority
]

{ #category : #update }
WDGFSubsystem >> updateSingleTimeStep: delta [
]
