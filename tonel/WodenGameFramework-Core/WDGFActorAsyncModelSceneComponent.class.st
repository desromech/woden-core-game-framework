"
I am a reference to a model which is asynchronously loaded.
"
Class {
	#name : #WDGFActorAsyncModelSceneComponent,
	#superclass : #WDGFActorSceneComponent,
	#instVars : [
		'uri',
		'elementSelector',
		'asyncContext'
	],
	#category : #'WodenGameFramework-Core-Components-Scene'
}

{ #category : #accessing }
WDGFActorAsyncModelSceneComponent >> asyncContext [

	^ asyncContext
]

{ #category : #accessing }
WDGFActorAsyncModelSceneComponent >> asyncContext: anObject [

	asyncContext := anObject
]

{ #category : #accessing }
WDGFActorAsyncModelSceneComponent >> elementSelector [

	^ elementSelector
]

{ #category : #accessing }
WDGFActorAsyncModelSceneComponent >> elementSelector: anObject [

	elementSelector := anObject
]

{ #category : #hooks }
WDGFActorAsyncModelSceneComponent >> privateConstructSceneNode [
	^ WDAsyncSceneNode new
]

{ #category : #hooks }
WDGFActorAsyncModelSceneComponent >> privateRegisterInWorld [
	super privateRegisterInWorld.
	sceneNode 
		uri: uri;
		elementSelector: elementSelector;
		asyncContext: asyncContext.
]

{ #category : #accessing }
WDGFActorAsyncModelSceneComponent >> uri [

	^ uri
]

{ #category : #accessing }
WDGFActorAsyncModelSceneComponent >> uri: anObject [

	uri := anObject
]
