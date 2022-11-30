Class {
	#name : #WDGFSkyBoxComponent,
	#superclass : #WDGFActorSceneComponent,
	#instVars : [
		'environmentMap',
		'material',
		'mesh'
	],
	#category : #'WodenGameFramework-Core-Actor'
}

{ #category : #'instance creation' }
WDGFSkyBoxComponent class >> with: anEnvironmentMap [
	^ self new environmentMap: anEnvironmentMap; yourself
]

{ #category : #accessing }
WDGFSkyBoxComponent >> environmentMap [

	^ environmentMap
]

{ #category : #accessing }
WDGFSkyBoxComponent >> environmentMap: anObject [
	environmentMap := anObject.
	material ifNotNil: [ 
		material colorTexture: environmentMap
	]
]

{ #category : #testing }
WDGFSkyBoxComponent >> isBackgroundSceneComponent [
	^ true
]

{ #category : #hooks }
WDGFSkyBoxComponent >> privateRegisterInWorld [
	super privateRegisterInWorld.
	material ifNil: [
		material := WDEnvironmentMapMaterial new
			colorTexture: environmentMap;
			background: true;
			yourself.
	].

	mesh ifNil: [
		mesh := WDMeshBuilder new
			currentMaterial: material;
			addInteriorCubeWithWidth: 1.0 height: 1.0 depth: 1.0;
			mesh
	].

	sceneNode renderables: { mesh }

]
