Class {
	#name : #WDGFActorStaticMeshSceneComponent,
	#superclass : #WDGFActorSceneComponent,
	#instVars : [
		'mesh'
	],
	#category : #'WodenGameFramework-Core'
}

{ #category : #'instance creation' }
WDGFActorStaticMeshSceneComponent class >> with: aMesh [
	^ self new mesh: aMesh; yourself
]

{ #category : #accessing }
WDGFActorStaticMeshSceneComponent >> mesh [

	^ mesh
]

{ #category : #accessing }
WDGFActorStaticMeshSceneComponent >> mesh: anObject [

	mesh := anObject
]

{ #category : #hooks }
WDGFActorStaticMeshSceneComponent >> privateRegisterInWorld [
	super privateRegisterInWorld.
	sceneNode renderables: { mesh }
]
