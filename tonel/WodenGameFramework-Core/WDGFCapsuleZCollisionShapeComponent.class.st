Class {
	#name : #WDGFCapsuleZCollisionShapeComponent,
	#superclass : #WDGFAbstractCapsuleCollisionShapeComponent,
	#category : #'WodenGameFramework-Core-Components-Physics'
}

{ #category : #converting }
WDGFCapsuleZCollisionShapeComponent >> asValidCollisionShape [
	^ WDPCapsuleZCollisionShape height: height radius: radius
]
