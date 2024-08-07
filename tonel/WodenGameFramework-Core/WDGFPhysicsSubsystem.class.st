"
I am a subsystem that provides collision detection and physics simulation facilities.
"
Class {
	#name : 'WDGFPhysicsSubsystem',
	#superclass : 'WDGFSubsystem',
	#instVars : [
		'physicsWorld'
	],
	#category : 'WodenGameFramework-Core-Subsystem',
	#package : 'WodenGameFramework-Core',
	#tag : 'Subsystem'
}

{ #category : 'default' }
WDGFPhysicsSubsystem class >> defaultGravity [
	^ Vector3 y: -9.8
]

{ #category : 'queries' }
WDGFPhysicsSubsystem >> findActorsIntersectingBox: box transform: transform suchThat: aPredicate [
	^ (physicsWorld findObjectsIntersectingBox: box transform: transform suchThat: [ :element |
		element model notNil and: [aPredicate value: element model owner]
	]) collect: [:eachCollisionObject | eachCollisionObject model owner]
]

{ #category : 'queries' }
WDGFPhysicsSubsystem >> findActorsIntersectingSphere: sphere suchThat: aPredicate [
	^ (physicsWorld findObjectsIntersectingSphere: sphere suchThat: [ :element |
		element model notNil and: [aPredicate value: element model owner]
	]) collect: [:eachCollisionObject | eachCollisionObject model owner]
]

{ #category : 'queries' }
WDGFPhysicsSubsystem >> findActorsIntersectingSphere: sphere transform: transform suchThat: aPredicate [
	^ (physicsWorld findObjectsIntersectingSphere: sphere transform: transform suchThat: [ :element |
		element model notNil and: [aPredicate value: element model owner]
	]) collect: [:eachCollisionObject | eachCollisionObject model owner]
]

{ #category : 'initialization' }
WDGFPhysicsSubsystem >> initialize [
	super initialize.
	physicsWorld := WDPDiscreteDynamicPhysicsWorld new.
	physicsWorld gravity: self class defaultGravity.
]

{ #category : 'accessing' }
WDGFPhysicsSubsystem >> physicsWorld [

	^ physicsWorld
]

{ #category : 'queries' }
WDGFPhysicsSubsystem >> rayCast: ray excludingActors: exclusionSet forFirstActorSuchThat: aPredicate [
	| physicsResult actor |
	physicsResult := physicsWorld rayCast: ray forFirstSuchThat: [ :element |
		element model notNil and: [
			(exclusionSet includes: element model owner) not and: [
				aPredicate value: element model owner
			]
		]
	].
	physicsResult ifNil: [ ^ nil ].
	
	actor := physicsResult collisionObject model owner.
	^ WDGFActorRayCastingResult new
		actor: actor;
		ray: ray;
		distance: physicsResult distance;
		normal: physicsResult normal;
		yourself
]

{ #category : 'accessing' }
WDGFPhysicsSubsystem >> updatePriority [
	^ PhysicsUpdatePriority
]

{ #category : 'initialization' }
WDGFPhysicsSubsystem >> updateSingleTimeStep: delta [
	ownerWorld isPlaying ifFalse: [ ^ self ].
	
	physicsWorld
		loadCollisionStateFromModelsWithDeltaTime: delta;
		updateWithDeltaTime: delta;
		saveCollisionStateIntoModels
]
