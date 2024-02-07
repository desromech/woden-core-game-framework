Class {
	#name : #WDGFCapsuleYCollisionShapeComponent,
	#superclass : #WDGFAbstractCapsuleCollisionShapeComponent,
	#category : #'WodenGameFramework-Core-Components-Physics'
}

{ #category : #converting }
WDGFCapsuleYCollisionShapeComponent >> asValidCollisionShape [
	^ WDPCapsuleYCollisionShape height: height radius: radius
]
