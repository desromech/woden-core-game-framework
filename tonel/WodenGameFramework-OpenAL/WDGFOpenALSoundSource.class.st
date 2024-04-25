"
I hold a specific OpenAL source handle along with a model used for updating its state.
"
Class {
	#name : #WDGFOpenALSoundSource,
	#superclass : #Object,
	#instVars : [
		'model',
		'handle',
		'currentBuffer'
	],
	#pools : [
		'OpenALConstants'
	],
	#category : #'WodenGameFramework-OpenAL'
}

{ #category : #accessing }
WDGFOpenALSoundSource >> handle [

	^ handle
]

{ #category : #accessing }
WDGFOpenALSoundSource >> handle: anObject [

	handle := anObject
]

{ #category : #accessing }
WDGFOpenALSoundSource >> model [

	^ model
]

{ #category : #accessing }
WDGFOpenALSoundSource >> model: anObject [

	model := anObject
]

{ #category : #updating }
WDGFOpenALSoundSource >> updateState [
	| position linearVelocity |
	position := model worldPosition.
	linearVelocity := model worldLinearVelocity.
	OpenAL
		source3f: handle param: AL_POSITION value: position x asFloat value: position y asFloat value: position z asFloat;
		source3f: handle param: AL_VELOCITY value: linearVelocity x asFloat value: linearVelocity y asFloat value: linearVelocity z asFloat;
		sourcef: handle param: AL_GAIN value: model gain;
		sourcef: handle param: AL_PITCH value: model pitch;
		sourcei: handle param: AL_LOOPING value: (model looped ifTrue: [AL_TRUE] ifFalse: [AL_FALSE]).
]

{ #category : #updating }
WDGFOpenALSoundSource >> useBuffer: buffer [
	currentBuffer == buffer ifTrue: [ ^ self ].
	OpenAL sourcei: handle param: AL_BUFFER
		value: (buffer
			ifNil: [ 0 ]
			ifNotNil: [ buffer handle ]).
	OpenAL sourcePlay: handle.
	currentBuffer := buffer.
]
