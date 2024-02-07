Class {
	#name : #WDGFCapsuleXCollisionShapeComponent,
	#superclass : #WDGFAbstractCapsuleCollisionShapeComponent,
	#category : #'WodenGameFramework-Core-Components-Physics'
}

{ #category : #converting }
WDGFCapsuleXCollisionShapeComponent >> asValidCollisionShape [
	^ WDPCapsuleXCollisionShape height: height radius: radius
]
