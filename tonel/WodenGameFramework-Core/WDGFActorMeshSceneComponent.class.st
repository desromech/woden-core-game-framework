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
WDGFActorMeshSceneComponent >> mesh: anObject [

	mesh := anObject
]

{ #category : #hooks }
WDGFActorMeshSceneComponent >> privateRegisterInWorld [
	super privateRegisterInWorld.
	mesh ifNotNil: [ 
		sceneNode renderables: { mesh }
	].

]
