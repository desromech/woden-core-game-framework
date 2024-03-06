Class {
	#name : #WDGFCharacterBodyObjectComponent,
	#superclass : #WDGFRigidBodyObjectComponent,
	#instVars : [
		'walkingVelocity',
		'jumpVelocity',
		'walkAccelerationTime'
	],
	#category : #'WodenGameFramework-Core-Components-Physics'
}

{ #category : #initialization }
WDGFCharacterBodyObjectComponent >> initialize [
	super initialize.
	walkingVelocity := Vector3 zeros.
	jumpVelocity := Vector3 zeros.
	walkAccelerationTime := 0.05.
]

{ #category : #controlling }
WDGFCharacterBodyObjectComponent >> jump [
]

{ #category : #accessing }
WDGFCharacterBodyObjectComponent >> jumpVelocity [

	^ jumpVelocity
]

{ #category : #accessing }
WDGFCharacterBodyObjectComponent >> jumpVelocity: anObject [

	jumpVelocity := anObject
]

{ #category : #'model updates' }
WDGFCharacterBodyObjectComponent >> loadCollisionStateInto: aCollisionObject deltaTime: deltaTime [
	| targetVelocity gravityMask currentWalkingVelocity walkingVelocityDelta walkingAcceleration |
	super loadCollisionStateInto: aCollisionObject deltaTime: deltaTime.
	
	owner ifNil: [ ^ self ].
	
	targetVelocity := owner orientation transformVector3: walkingVelocity.
	gravityMask := Vector3 ones - aCollisionObject owner gravity normalized abs.
	currentWalkingVelocity := aCollisionObject linearVelocity  * gravityMask.
	walkingVelocityDelta := targetVelocity - currentWalkingVelocity.
	walkingAcceleration := walkingVelocityDelta / walkAccelerationTime.
	Transcript show: '----------------------------------'; cr.
	Transcript show: 'tar '; show: targetVelocity; cr.
	Transcript show: 'cur '; show: currentWalkingVelocity; cr.
	Transcript show: 'acc '; show: walkingAcceleration; cr.

	aCollisionObject internalAcceleration: walkingAcceleration.
]

{ #category : #accessing }
WDGFCharacterBodyObjectComponent >> walkingVelocity [

	^ walkingVelocity
]

{ #category : #accessing }
WDGFCharacterBodyObjectComponent >> walkingVelocity: anObject [

	walkingVelocity := anObject
]
