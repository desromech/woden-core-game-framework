"
I am a subsystem that provides collision detection and physics simulation facilities.
"
Class {
	#name : #WDGFPhysicsSubsystem,
	#superclass : #WDGFSubsystem,
	#instVars : [
		'physicsWorld'
	],
	#category : #'WodenGameFramework-Core-Subsystem'
}

{ #category : #default }
WDGFPhysicsSubsystem class >> defaultGravity [
	^ Vector3 y: -9.8
]

{ #category : #initialization }
WDGFPhysicsSubsystem >> initialize [
	super initialize.
	physicsWorld := WDPDiscreteDynamicPhysicsWorld new.
	physicsWorld gravity: self class defaultGravity.
]

{ #category : #accessing }
WDGFPhysicsSubsystem >> physicsWorld [

	^ physicsWorld
]

{ #category : #initialization }
WDGFPhysicsSubsystem >> updateSingleTimeStep: delta [
	ownerWorld isPlaying ifFalse: [ ^ self ].
	
	physicsWorld
		loadCollisionStateFromModels;
		updateWithDeltaTime: delta;
		saveCollisionStateIntoModels
]
