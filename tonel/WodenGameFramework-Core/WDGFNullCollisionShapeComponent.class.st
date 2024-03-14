Class {
	#name : #WDGFNullCollisionShapeComponent,
	#superclass : #WDGFCollisionShapeComponent,
	#category : #'WodenGameFramework-Core-Components-Physics'
}

{ #category : #converting }
WDGFNullCollisionShapeComponent >> asValidCollisionShape [
	^ WDPNullCollisionShape uniqueInstance
]

{ #category : #accessing }
WDGFNullCollisionShapeComponent >> localBoundingBox [
	^ AABox originPoint
]
