"
I hold a specific OpenAL buffer handle along with a model used for updating its state.
"
Class {
	#name : #WDGFOpenALSoundBuffer,
	#superclass : #Object,
	#instVars : [
		'model',
		'handle'
	],
	#classVars : [
		'OpenALFormatMap'
	],
	#pools : [
		'OpenALConstants'
	],
	#category : #'WodenGameFramework-Core-Sound'
}

{ #category : #'class initialization' }
WDGFOpenALSoundBuffer class >> initialize [
	OpenALFormatMap := IdentityDictionary newFromPairs: { 
		WDSoundSampleFormatMono8UNorm asSoundSampleFormat . AL_FORMAT_MONO8.
		WDSoundSampleFormatMono16SNorm asSoundSampleFormat . AL_FORMAT_MONO16.
		WDSoundSampleFormatStereo8UNorm asSoundSampleFormat . AL_FORMAT_STEREO8.
		WDSoundSampleFormatStereo16SNorm asSoundSampleFormat . AL_FORMAT_STEREO16.
	}
	
]

{ #category : #accessing }
WDGFOpenALSoundBuffer >> handle [

	^ handle
]

{ #category : #accessing }
WDGFOpenALSoundBuffer >> handle: anObject [

	handle := anObject
]

{ #category : #accessing }
WDGFOpenALSoundBuffer >> model [

	^ model
]

{ #category : #accessing }
WDGFOpenALSoundBuffer >> model: anObject [

	model := anObject
]

{ #category : #updating }
WDGFOpenALSoundBuffer >> update [
	OpenAL bufferData: handle format: (OpenALFormatMap at: model format) data: model data size: model data size freq: model sampleRate.
]
