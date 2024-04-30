Class {
	#name : #WDGFCollisionShapeComponent,
	#superclass : #WDGFAbstractCollisionShapeComponent,
	#instVars : [
		'shape'
	],
	#category : #'WodenGameFramework-Core-Components-Physics'
}

{ #category : #'instance creation' }
WDGFCollisionShapeComponent class >> with: aShape [
	^ self new shape: aShape; yourself
]

{ #category : #converting }
WDGFCollisionShapeComponent >> asValidCollisionShapeWithoutTransform [
	^ shape
]

{ #category : #accessing }
WDGFCollisionShapeComponent >> localBoundingBox [
	^ shape localBoundingBox
]

{ #category : #accessing }
WDGFCollisionShapeComponent >> shape [

	^ shape
]

{ #category : #accessing }
WDGFCollisionShapeComponent >> shape: anObject [

	shape := anObject
]
