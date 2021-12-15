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
	#category : #'WodenGameFramework-Core'
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
