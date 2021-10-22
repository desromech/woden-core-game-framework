"
I am a component in an actor.
"
Class {
	#name : #WDGFActorComponent,
	#superclass : #Object,
	#instVars : [
		'owner'
	],
	#category : #'WodenGameFramework-Core'
}

{ #category : #notifications }
WDGFActorComponent >> addedToActor: anActor [
	self assert: owner isNil.
	owner := anActor.
]

{ #category : #accessing }
WDGFActorComponent >> owner [

	^ owner
]

{ #category : #accessing }
WDGFActorComponent >> owner: anObject [

	owner := anObject
]

{ #category : #notifications }
WDGFActorComponent >> removedFromActor: anActor [
	self assert: owner == anActor.
	owner := nil.
]
