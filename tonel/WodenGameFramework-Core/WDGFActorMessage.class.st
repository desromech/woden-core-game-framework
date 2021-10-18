"
I am an asynchronous message that is sent to an actor.
"
Class {
	#name : #WDGFActorMessage,
	#superclass : #Object,
	#instVars : [
		'nextMessage',
		'target',
		'selector',
		'arguments'
	],
	#category : #'WodenGameFramework-Core'
}

{ #category : #accessing }
WDGFActorMessage >> arguments [

	^ arguments
]

{ #category : #accessing }
WDGFActorMessage >> arguments: anObject [

	arguments := anObject
]

{ #category : #'as yet unclassified' }
WDGFActorMessage >> enqueue [
	target world ifNotNil: [ :world | world enqueueMessage: self ]
]

{ #category : #accessing }
WDGFActorMessage >> nextMessage [

	^ nextMessage
]

{ #category : #accessing }
WDGFActorMessage >> nextMessage: anObject [

	nextMessage := anObject
]

{ #category : #accessing }
WDGFActorMessage >> process [
	target actor ifNotNil: [ :actor |
		actor processMessage: self
	]
]

{ #category : #accessing }
WDGFActorMessage >> selector [

	^ selector
]

{ #category : #accessing }
WDGFActorMessage >> selector: anObject [

	selector := anObject
]

{ #category : #accessing }
WDGFActorMessage >> target [

	^ target
]

{ #category : #accessing }
WDGFActorMessage >> target: anObject [

	target := anObject
]
