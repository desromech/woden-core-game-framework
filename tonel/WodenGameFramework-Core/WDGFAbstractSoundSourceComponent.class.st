Class {
	#name : #WDGFAbstractSoundSourceComponent,
	#superclass : #WDGFActorComponent,
	#instVars : [
		'gain',
		'pitch'
	],
	#category : #'WodenGameFramework-Core-Components-SoundSource'
}

{ #category : #testing }
WDGFAbstractSoundSourceComponent class >> isAbstract [
	^ self == WDGFAbstractSoundSourceComponent
]

{ #category : #accessing }
WDGFAbstractSoundSourceComponent >> gain [

	^ gain
]

{ #category : #accessing }
WDGFAbstractSoundSourceComponent >> gain: anObject [

	gain := anObject
]

{ #category : #initialization }
WDGFAbstractSoundSourceComponent >> initialize [
	super initialize.
	gain := 1.0.
	pitch := 1.0.
	
]

{ #category : #accessing }
WDGFAbstractSoundSourceComponent >> pitch [

	^ pitch
]

{ #category : #accessing }
WDGFAbstractSoundSourceComponent >> pitch: anObject [

	pitch := anObject
]

{ #category : #hooks }
WDGFAbstractSoundSourceComponent >> privateRegisterInWorld [
	super privateRegisterInWorld.
	ownerWorld soundSubsystem registerSoundSourceComponent: self
]

{ #category : #hooks }
WDGFAbstractSoundSourceComponent >> privateUnregisterFromWorld [
	super privateUnregisterFromWorld.
	ownerWorld soundSubsystem unregisterSoundSourceComponent: self

]

{ #category : #'as yet unclassified' }
WDGFAbstractSoundSourceComponent >> worldLinearVelocity [
	^ owner linearVelocity
]

{ #category : #'as yet unclassified' }
WDGFAbstractSoundSourceComponent >> worldPosition [
	^ owner position
]
