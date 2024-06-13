"
I am a component that provides a collision object which is also a rigid object.
"
Class {
	#name : 'WDGFRigidBodyObjectComponent',
	#superclass : 'WDGFCollisionObjectComponent',
	#instVars : [
		'mass',
		'noTorque'
	],
	#category : 'WodenGameFramework-Core-Components-Physics',
	#package : 'WodenGameFramework-Core',
	#tag : 'Components-Physics'
}

{ #category : 'accessing' }
WDGFRigidBodyObjectComponent class >> mass: mass [
	^ self new mass: mass; yourself
]

{ #category : 'initialization' }
WDGFRigidBodyObjectComponent >> initialize [
	super initialize.
	mass := 0.0.
	noTorque := false.
]

{ #category : 'testing' }
WDGFRigidBodyObjectComponent >> isRigidBodyComponent [
	^ true
]

{ #category : 'accessing' }
WDGFRigidBodyObjectComponent >> mass [

	^ mass
]

{ #category : 'accessing' }
WDGFRigidBodyObjectComponent >> mass: anObject [

	mass := anObject
]

{ #category : 'accessing' }
WDGFRigidBodyObjectComponent >> noTorque [

	^ noTorque
]

{ #category : 'accessing' }
WDGFRigidBodyObjectComponent >> noTorque: anObject [

	noTorque := anObject
]

{ #category : 'physics setup' }
WDGFRigidBodyObjectComponent >> privateMakeCollisionObjectInstance [
	^ WDPRigidBody new
]

{ #category : 'physics setup' }
WDGFRigidBodyObjectComponent >> setupCollisionObject [
	super setupCollisionObject.
	collisionObject mass: mass.
	
	noTorque ifTrue: [ 
		collisionObject inertiaTensor: Matrix3x3 zeros
	] ifFalse: [ 
		collisionObject computeMassDistribution
	].
	 
]

{ #category : 'as yet unclassified' }
WDGFRigidBodyObjectComponent >> withoutTorque [
	self noTorque: true
]

{ #category : 'accessing' }
WDGFRigidBodyObjectComponent >> worldInertiaTensor [
	^ collisionObject worldInertiaTensor
]
