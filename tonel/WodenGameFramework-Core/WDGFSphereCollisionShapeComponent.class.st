Class {
	#name : #WDGFSphereCollisionShapeComponent,
	#superclass : #WDGFCollisionShapeComponent,
	#instVars : [
		'radius'
	],
	#category : #'WodenGameFramework-Core-Components-Physics'
}

{ #category : #accessing }
WDGFSphereCollisionShapeComponent class >> radius: radius [
	^ self new radius: radius; yourself
]

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
WDGFSphereCollisionShapeComponent >> localBoundingBox [
	^ AABox halfExtent: radius
]

{ #category : #accessing }
WDGFSphereCollisionShapeComponent >> radius [

	^ radius
]

{ #category : #accessing }
WDGFSphereCollisionShapeComponent >> radius: anObject [

	radius := anObject
]
