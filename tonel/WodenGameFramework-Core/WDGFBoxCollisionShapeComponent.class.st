Class {
	#name : #WDGFBoxCollisionShapeComponent,
	#superclass : #WDGFCollisionShapeComponent,
	#instVars : [
		'halfExtent'
	],
	#category : #'WodenGameFramework-Core-Components-Physics'
}

{ #category : #accessing }
WDGFBoxCollisionShapeComponent class >> halfExtent: aVector3 [
	^ self new halfExtent: aVector3; yourself
]

{ #category : #converting }
WDGFBoxCollisionShapeComponent >> asValidCollisionShape [
	^ WDPBoxCollisionShape halfExtent: halfExtent
]

{ #category : #accessing }
WDGFBoxCollisionShapeComponent >> halfExtent [

	^ halfExtent
]

{ #category : #accessing }
WDGFBoxCollisionShapeComponent >> halfExtent: anObject [
	halfExtent := anObject asVector3
]

{ #category : #initialization }
WDGFBoxCollisionShapeComponent >> initialize [
	super initialize.
	halfExtent := Vector3 ones
]

{ #category : #accessing }
WDGFBoxCollisionShapeComponent >> localBoundingBox [
	^ AABox halfExtent: halfExtent
]
