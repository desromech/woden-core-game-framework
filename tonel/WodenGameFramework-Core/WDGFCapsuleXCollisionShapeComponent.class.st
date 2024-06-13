Class {
	#name : 'WDGFCapsuleXCollisionShapeComponent',
	#superclass : 'WDGFAbstractCapsuleCollisionShapeComponent',
	#category : 'WodenGameFramework-Core-Components-Physics',
	#package : 'WodenGameFramework-Core',
	#tag : 'Components-Physics'
}

{ #category : 'converting' }
WDGFCapsuleXCollisionShapeComponent >> asValidCollisionShapeWithoutTransform [
	^ WDCapsuleXCollisionShape height: height radius: radius
]

{ #category : 'accessing' }
WDGFCapsuleXCollisionShapeComponent >> localBoundingBox [
	^ AABox halfExtent: (Vector3 x: height/2 + radius y: radius z: radius)
]
