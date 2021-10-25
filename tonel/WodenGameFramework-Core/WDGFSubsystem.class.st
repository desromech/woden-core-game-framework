"
I am a subsystem in the game framework.
"
Class {
	#name : #WDGFSubsystem,
	#superclass : #Object,
	#instVars : [
		'ownerWorld'
	],
	#category : #'WodenGameFramework-Core'
}

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

{ #category : #accessing }
WDGFSubsystem >> updatePriority [
	^ 0
]

{ #category : #update }
WDGFSubsystem >> updateSingleTimeStep: delta [
]
