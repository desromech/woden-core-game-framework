"
I am a component that provides a collision object which is also a rigid object.
"
Class {
	#name : #WDGFRigidBodyObjectComponent,
	#superclass : #WDGFCollisionObjectComponent,
	#instVars : [
		'mass'
	],
	#category : #'WodenGameFramework-Core-Components-Physics'
}

{ #category : #accessing }
WDGFRigidBodyObjectComponent class >> mass: mass [
	^ self new mass: mass; yourself
]

{ #category : #initialization }
WDGFRigidBodyObjectComponent >> initialize [
	super initialize.
	mass := 0.0.
	
]

{ #category : #accessing }
WDGFRigidBodyObjectComponent >> mass [

	^ mass
]

{ #category : #accessing }
WDGFRigidBodyObjectComponent >> mass: anObject [

	mass := anObject
]

{ #category : #'physics setup' }
WDGFRigidBodyObjectComponent >> privateMakeCollisionObjectInstance [
	^ WDPRigidBody new
]

{ #category : #'physics setup' }
WDGFRigidBodyObjectComponent >> setupCollisionObject [
	super setupCollisionObject.
	collisionObject mass: mass
]
