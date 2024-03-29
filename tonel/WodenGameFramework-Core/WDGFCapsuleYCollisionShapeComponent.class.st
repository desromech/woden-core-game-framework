Class {
	#name : #WDGFCapsuleYCollisionShapeComponent,
	#superclass : #WDGFAbstractCapsuleCollisionShapeComponent,
	#category : #'WodenGameFramework-Core-Components-Physics'
}

{ #category : #converting }
WDGFCapsuleYCollisionShapeComponent >> asValidCollisionShape [
	^ WDPCapsuleYCollisionShape height: height radius: radius
]

{ #category : #accessing }
WDGFCapsuleYCollisionShapeComponent >> localBoundingBox [
	^ AABox halfExtent: (Vector3 x: radius y: height/2 + radius z: radius)
]
