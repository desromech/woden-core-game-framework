Class {
	#name : #WDGFSphereCollisionShapeComponent,
	#superclass : #WDGFCollisionShapeComponent,
	#instVars : [
		'radius'
	],
	#category : #'WodenGameFramework-Core-Components-Physics'
}

{ #category : #converting }
WDGFSphereCollisionShapeComponent >> asValidCollisionShape [
	^ WDPSphereCollisionShape radius: radius
]

{ #category : #initialization }
WDGFSphereCollisionShapeComponent >> initialize [
	super initialize.
	radius := 1.0.
	
]

{ #category : #accessing }
WDGFSphereCollisionShapeComponent >> radius [

	^ radius
]

{ #category : #accessing }
WDGFSphereCollisionShapeComponent >> radius: anObject [

	radius := anObject
]
