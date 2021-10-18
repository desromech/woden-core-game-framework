"
I am a handle that is used for identifying and sending messages actors. I am used for guaranteeing state isolation between different actors.
"
Class {
	#name : #WDGFActorHandle,
	#superclass : #WeakArray,
	#type : #weak,
	#category : #'WodenGameFramework-Core'
}

{ #category : #'instance creation' }
WDGFActorHandle class >> for: anActor [
	^ (self basicNew: 2) actor: anActor
]

{ #category : #accessing }
WDGFActorHandle >> actor [
	^ self at: 1
]

{ #category : #accessing }
WDGFActorHandle >> actor: anActor [
	self at: 1 put: anActor
]

{ #category : #accessing }
WDGFActorHandle >> world [
	^ self at: 2
]

{ #category : #accessing }
WDGFActorHandle >> world: aWorld [
	self at: 2 put: aWorld
]
