"
I am a sound subsystem that uses OpenAL.
"
Class {
	#name : #WDGFSoundSubsystemOpenALBackend,
	#superclass : #WDGFSoundSubsystemBackend,
	#instVars : [
		'context',
		'device',
		'contextSession',
		'soundBuffers',
		'soundSources'
	],
	#pools : [
		'OpenALConstants'
	],
	#category : #'WodenGameFramework-OpenAL'
}

{ #category : #testing }
WDGFSoundSubsystemOpenALBackend class >> isAvailable [
	^ ([OpenAL loadLibrary] on: Error do: [ :e | ^ false ]) notNil
]

{ #category : #testing }
WDGFSoundSubsystemOpenALBackend class >> priority [
	^ 10
]

{ #category : #deleting }
WDGFSoundSubsystemOpenALBackend >> destroy [
	(context notNil and: [contextSession == AGPU session]) ifTrue: [
		context destroy.
		device close.
	].

	context := nil.
	contextSession := nil.
	device := nil.
]

{ #category : #deleting }
WDGFSoundSubsystemOpenALBackend >> ensureValidOpenALContext [
	| contextAttributes |
	(context notNil and: [contextSession == AGPU session]) ifTrue: [ ^ self ].
	
	soundBuffers := IdentityDictionary new.
	soundSources := IdentityDictionary new.
	
	contextAttributes := ALContextAttributes new.
	device := OpenALC openDefaultDevice.
	context := device createContext: contextAttributes asList.
	contextSession := AGPU session

]

{ #category : #initialization }
WDGFSoundSubsystemOpenALBackend >> initializeForSubsystem: subsystem [
	self ensureValidOpenALContext.
	context currentDuring: [ 
		subsystem soundSourceComponents do: [ :each |
			self registerSoundSourceComponent: each.
			self updateSoundSourceComponent: each.
		].
		
		self updateListenerWithCameraComponent: subsystem findActiveCameraComponent.
	]
	
]

{ #category : #initialization }
WDGFSoundSubsystemOpenALBackend >> registerSoundSourceComponent: sourceComponent [
	| source buffer |
	(soundSources includesKey: sourceComponent) ifTrue: [ ^ self ].
	
	buffer := self validBufferOrNilForSample: sourceComponent sample.

	context currentDuring: [
		source := WDGFOpenALSoundSource new
			model: sourceComponent;
			handle: OpenAL genSource;
			useBuffer: buffer;
			updateState;
			yourself.

		soundSources at: sourceComponent put: source.		
	].

]

{ #category : #initialization }
WDGFSoundSubsystemOpenALBackend >> unregisterSoundSourceComponent: sourceComponent [
	| source |
	(soundSources includesKey: sourceComponent) ifFalse: [ ^ self ].
	
	source := soundSources at: sourceComponent.
	soundSources removeAt: sourceComponent.
	context useDuring: [
		OpenAL deleteSource: source handle
	].
	
]

{ #category : #deleting }
WDGFSoundSubsystemOpenALBackend >> updateForSubsystem: subsystem timeStep: delta [
	self ensureValidOpenALContext.
	
	context currentDuring: [
		subsystem soundSourceComponents do: [ :each |
			self updateSoundSourceComponent: each.
		].
		
		self updateListenerWithCameraComponent: subsystem findActiveCameraComponent.
	].

	subsystem isPlaying ifTrue: [ 
		context process.
	] ifFalse: [ 
		context suspend.
	].

]

{ #category : #deleting }
WDGFSoundSubsystemOpenALBackend >> updateListenerWithCameraComponent: listenerCamera [
	| position linearVelocity forward up orientation |
	position := Vector3 zeros.
	linearVelocity := Vector3 zeros.
	forward := Vector3 z: -1.0.
	up := Vector3 y: 1.0.
	
	listenerCamera ifNotNil: [ 
		position := listenerCamera transformPositionToWorld: position.
		linearVelocity := listenerCamera owner linearVelocity.
		forward := listenerCamera transformVectorToWorld: forward.
		up := listenerCamera transformVectorToWorld: up.
	].

	orientation := (ByteArray new: 4*6)
		floatAt: 1 put: forward x asFloat;
		floatAt: 5 put: forward y asFloat;
		floatAt: 9 put: forward z asFloat;
		floatAt: 13 put: up x asFloat;
		floatAt: 17 put: up y asFloat;
		floatAt: 21 put: up z asFloat;
		yourself.

	OpenAL
		listener3f: AL_POSITION value: position x asFloat value: position y asFloat value: position z asFloat;
		listener3f: AL_VELOCITY value: linearVelocity x asFloat value: linearVelocity y asFloat value: linearVelocity z asFloat;
		listenerfv: AL_ORIENTATION values: orientation
]

{ #category : #deleting }
WDGFSoundSubsystemOpenALBackend >> updateSoundSourceComponent: sourceComponent [
	soundSources at: sourceComponent ifPresent: [ :source |
		source
			useBuffer: (self validBufferOrNilForSample: sourceComponent sample);
			updateState
	]
]

{ #category : #deleting }
WDGFSoundSubsystemOpenALBackend >> validBufferOrNilForSample: sample [
	sample ifNil: [ ^ nil ].

	^ soundBuffers at: sample ifAbsentPut: [ 
		context currentDuring: [
			WDGFOpenALSoundBuffer new
				model: sample;
				handle: OpenAL genBuffer;
				update;
				yourself
		]
	]
]
