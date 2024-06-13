Class {
	#name : 'WDGFActorMessageSubscriptions',
	#superclass : 'Object',
	#instVars : [
		'dictionary'
	],
	#category : 'WodenGameFramework-Core-Messages',
	#package : 'WodenGameFramework-Core',
	#tag : 'Messages'
}

{ #category : 'adding' }
WDGFActorMessageSubscriptions >> addFor: selector doing: aBlock [
	(dictionary at: selector ifAbsentPut: [ OrderedCollection new ])
		add: aBlock
]

{ #category : 'initialization' }
WDGFActorMessageSubscriptions >> initialize [
	super initialize.
	dictionary := IdentityDictionary new.
]

{ #category : 'message' }
WDGFActorMessageSubscriptions >> processMessage: selector withArguments: arguments [
	| subscriptions |
	subscriptions := dictionary at: selector ifAbsent: [ nil ].
	subscriptions ifNotNil: [ 
		subscriptions do: [ :each |
			each valueWithArguments: arguments
		]
	]
]
