"
I am a component in an actor.
"
Class {
	#name : #WDGFActorComponent,
	#superclass : #WDGFWorldElement,
	#instVars : [
		'owner',
		'ownerWorld'
	],
	#category : #'WodenGameFramework-Core-Actor'
}

{ #category : #converting }
WDGFActorComponent class >> asGameFrameworkActor [
	^ self asGameFrameworkComponent asGameFrameworkActor
]

{ #category : #converting }
WDGFActorComponent class >> asGameFrameworkComponent [
	^ self new
]

{ #category : #notifications }
WDGFActorComponent >> addedDirectlyToActor: anActor [
	self addedToActor: anActor
]

{ #category : #notifications }
WDGFActorComponent >> addedToActor: anActor [
	self assert: owner isNil.
	owner := anActor.
]

{ #category : #converting }
WDGFActorComponent >> asGameFrameworkActor [
	^ WDGFActor new
		addComponent: self;
		yourself
]

{ #category : #converting }
WDGFActorComponent >> asGameFrameworkComponent [
	^ self
]

{ #category : #accessing }
WDGFActorComponent >> children [
	^ #()
]

{ #category : #testing }
WDGFActorComponent >> isInteractiveScreenComponent [
	^ false
]

{ #category : #testing }
WDGFActorComponent >> isRigidBodyComponent [
	^ false
]

{ #category : #accessing }
WDGFActorComponent >> owner [

	^ owner
]

{ #category : #accessing }
WDGFActorComponent >> owner: anObject [

	owner := anObject
]

{ #category : #hooks }
WDGFActorComponent >> privateRegisterChildrenInWorld [
	self children do: [ :each | each registerInWorld: ownerWorld ]
]

{ #category : #hooks }
WDGFActorComponent >> privateRegisterInWorld [
	"Hook for component registration with a subsystem in the world."
]

{ #category : #hooks }
WDGFActorComponent >> privateUnregisterChildrenFromWorld [
	self children do: [ :each | each unregisterFromWorld: ownerWorld ]
]

{ #category : #hooks }
WDGFActorComponent >> privateUnregisterFromWorld [
	"Hook for component registration with a subsystem in the world."
]

{ #category : #'component registration' }
WDGFActorComponent >> registerInWorld: aWorld [
	ownerWorld == aWorld ifTrue: [ ^ self ].
	ownerWorld := aWorld.
	self
		privateRegisterInWorld;
		privateRegisterChildrenInWorld.
	
]

{ #category : #notifications }
WDGFActorComponent >> removedFromActor: anActor [
	self assert: owner == anActor.
	owner := nil.
]

{ #category : #'component registration' }
WDGFActorComponent >> unregisterFromWorld: aWorld [
	ownerWorld == aWorld ifFalse: [ ^ self ].
	self
		privateUnregisterChildrenFromWorld;
		privateUnregisterFromWorld.
	ownerWorld := nil.
	
]
