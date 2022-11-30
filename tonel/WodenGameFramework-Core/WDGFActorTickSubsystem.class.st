"
I am a subsystem that is used for ticking actors.
"
Class {
	#name : #WDGFActorTickSubsystem,
	#superclass : #WDGFSubsystem,
	#instVars : [
		'tickingActors'
	],
	#category : #'WodenGameFramework-Core-Subsystem'
}

{ #category : #initialization }
WDGFActorTickSubsystem >> initialize [
	super initialize.
	tickingActors := OrderedCollection new.
]

{ #category : #'system changes' }
WDGFActorTickSubsystem >> subscribe: actor [
	tickingActors add: actor
]

{ #category : #'system changes' }
WDGFActorTickSubsystem >> unsubscribe: actor [
	tickingActors remove: actor
]

{ #category : #update }
WDGFActorTickSubsystem >> updateSingleTimeStep: delta [
	| arguments |
	ownerWorld isPlaying ifFalse: [ ^ self ].
	arguments := { delta }.
	tickingActors do: [ :each | each send: #tick: withArguments: arguments ].
]
