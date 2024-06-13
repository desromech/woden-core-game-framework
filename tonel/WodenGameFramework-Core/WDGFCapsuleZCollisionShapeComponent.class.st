Class {
	#name : 'WDGFCapsuleZCollisionShapeComponent',
	#superclass : 'WDGFAbstractCapsuleCollisionShapeComponent',
	#category : 'WodenGameFramework-Core-Components-Physics',
	#package : 'WodenGameFramework-Core',
	#tag : 'Components-Physics'
}

{ #category : 'converting' }
WDGFCapsuleZCollisionShapeComponent >> asValidCollisionShapeWithoutTransform [
	^ WDCapsuleZCollisionShape height: height radius: radius
]

{ #category : 'accessing' }
WDGFCapsuleZCollisionShapeComponent >> localBoundingBox [
	^ AABox halfExtent: (Vector3 x: radius y: radius z: height/2 + radius)
]
