Class {
	#name : #WDGFCapsuleZCollisionShapeComponent,
	#superclass : #WDGFAbstractCapsuleCollisionShapeComponent,
	#category : #'WodenGameFramework-Core-Components-Physics'
}

{ #category : #converting }
WDGFCapsuleZCollisionShapeComponent >> asValidCollisionShape [
	^ WDPCapsuleZCollisionShape height: height radius: radius
]

{ #category : #accessing }
WDGFCapsuleZCollisionShapeComponent >> localBoundingBox [
	^ AABox halfExtent: (Vector3 x: radius y: radius z: height/2 + radius)
]
