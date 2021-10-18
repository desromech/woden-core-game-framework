"
A WDGFActorTest is a test class for testing the behavior of WDGFActor
"
Class {
	#name : #WDGFActorTest,
	#superclass : #TestCase,
	#category : #'WodenGameFramework-Core-Tests'
}

{ #category : #tests }
WDGFActorTest >> testNew [
	| actor |
	actor := WDGFActor new.
	self assert: actor handle isNotNil.
	self assert: actor handle actor equals: actor.
	self assert: actor world isNil.
]

{ #category : #tests }
WDGFActorTest >> testOnMessageDo [
	| actor gotMessage |
	actor := WDGFActor new.
	gotMessage := false.
	actor onMessage: #testMessage do: [ gotMessage := true ].
	self deny: gotMessage.
	actor processMessage: #testMessage withArguments: #().
	self assert: gotMessage
]
