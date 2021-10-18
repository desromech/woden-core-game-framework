"
I am an actor in the Woden Game Framework. I am a concurrent entity in a world than can receive and send messages to other actors.
"
Class {
	#name : #WDGFActor,
	#superclass : #Object,
	#instVars : [
		'handle',
		'subscriptions',
		'messageSubscriptions'
	],
	#category : #'WodenGameFramework-Core'
}

{ #category : #'game events' }
WDGFActor >> beginPlay [
	"This message is sent at the beginning of a level"
]

{ #category : #'game events' }
WDGFActor >> endPlay [
	"This message is sent at the end of a level"
]

{ #category : #accessing }
WDGFActor >> handle [
	^ handle
]

{ #category : #initialization }
WDGFActor >> initialize [
	super initialize.
	handle := WDGFActorHandle for: self.
]

{ #category : #message }
WDGFActor >> messageSubscriptions [
	^ messageSubscriptions ifNil: [ messageSubscriptions := WDGFActorMessageSubscriptions new ]
]

{ #category : #'game events' }
WDGFActor >> onBeginPlayDo: aBlock [
	^ self onMessage: #beginPlay do: aBlock
]

{ #category : #'game events' }
WDGFActor >> onEndPlayDo: aBlock [
	^ self onMessage: #endPlay do: aBlock
]

{ #category : #message }
WDGFActor >> onMessage: selector do: aBlock [
	^ self messageSubscriptions addFor: selector doing: aBlock
]

{ #category : #copying }
WDGFActor >> postCopy [
	super postCopy.
	handle := WDGFActorHandle for: self.
]

{ #category : #message }
WDGFActor >> processMessage: message [
	^ self processMessage: message selector withArguments: message arguments
]

{ #category : #message }
WDGFActor >> processMessage: selector withArguments: arguments [
	(self respondsTo: selector) ifTrue: [
		self perform: selector withArguments: arguments
	].

	messageSubscriptions ifNotNil: [
		messageSubscriptions processMessage: selector withArguments: arguments
	].

]

{ #category : #message }
WDGFActor >> send: selector [
	^ self send: selector withArguments: #()
]

{ #category : #message }
WDGFActor >> send: selector withArguments: arguments [
	^ WDGFActorMessage new
		target: handle;
		selector: selector;
		arguments: arguments;
		enqueue
]

{ #category : #accessing }
WDGFActor >> world [
	^ handle world
]
