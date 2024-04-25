Class {
	#name : #WDGFActorMeshSceneComponent,
	#superclass : #WDGFActorSceneComponent,
	#instVars : [
		'mesh'
	],
	#category : #'WodenGameFramework-Core-Components-Scene'
}

{ #category : #'instance creation' }
WDGFActorMeshSceneComponent class >> with: aMesh [
	^ self new mesh: aMesh; yourself
]

{ #category : #accessing }
WDGFActorMeshSceneComponent >> mesh [

	^ mesh
]

{ #category : #accessing }
WDGFActorMeshSceneComponent >> mesh: aMesh [
	| isChanged |
	isChanged := mesh ~~ aMesh.
	mesh := aMesh.
	
	(isChanged and: [sceneNode notNil]) ifTrue: [
		mesh ifNil: [ 
			sceneNode renderables: #()
		] ifNotNil: [
			sceneNode renderables: { mesh }
		]
	].
]

{ #category : #hooks }
WDGFActorMeshSceneComponent >> privateRegisterInWorld [
	super privateRegisterInWorld.
	mesh ifNotNil: [ 
		sceneNode renderables: { mesh }
	].

]
