"
I am a component that provides a collision shape.
"
Class {
	#name : #WDGFCollisionShapeComponent,
	#superclass : #WDGFActorComponent,
	#category : #'WodenGameFramework-Core-Components-Physics'
}

{ #category : #notifications }
WDGFCollisionShapeComponent >> addedToActor: anActor [
	super addedToActor: anActor.
	anActor collisionShapeComponent ifNotNil: [ :rootComponent |
		"TODO: add as a child"
	] ifNil: [ 
		anActor collisionShapeComponent: self
	]
]

{ #category : #converting }
WDGFCollisionShapeComponent >> asValidCollisionShape [
	^ self subclassResponsibility
]

{ #category : #accessing }
WDGFCollisionShapeComponent >> localBoundingBox [
	^ self subclassResponsibility
]
