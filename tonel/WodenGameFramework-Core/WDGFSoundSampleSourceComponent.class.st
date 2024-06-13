Class {
	#name : 'WDGFSoundSampleSourceComponent',
	#superclass : 'WDGFAbstractSoundSourceComponent',
	#instVars : [
		'sample',
		'looped'
	],
	#category : 'WodenGameFramework-Core-Components-SoundSource',
	#package : 'WodenGameFramework-Core',
	#tag : 'Components-SoundSource'
}

{ #category : 'construction' }
WDGFSoundSampleSourceComponent class >> sample: sample gain: gain pitch: pitch looped: looped [
	^ self new
		sample: sample;
		gain: gain;
		pitch: pitch;
		looped: looped;
		yourself
]

{ #category : 'initialization' }
WDGFSoundSampleSourceComponent >> initialize [
	super initialize.
	looped := false.
	
]

{ #category : 'accessing' }
WDGFSoundSampleSourceComponent >> looped [

	^ looped
]

{ #category : 'accessing' }
WDGFSoundSampleSourceComponent >> looped: anObject [

	looped := anObject
]

{ #category : 'accessing' }
WDGFSoundSampleSourceComponent >> sample [

	^ sample
]

{ #category : 'accessing' }
WDGFSoundSampleSourceComponent >> sample: anObject [

	sample := anObject
]
