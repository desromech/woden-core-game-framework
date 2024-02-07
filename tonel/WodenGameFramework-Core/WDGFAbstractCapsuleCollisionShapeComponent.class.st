Class {
	#name : #WDGFAbstractCapsuleCollisionShapeComponent,
	#superclass : #WDGFCollisionShapeComponent,
	#instVars : [
		'height',
		'radius'
	],
	#category : #'WodenGameFramework-Core-Components-Physics'
}

{ #category : #testing }
WDGFAbstractCapsuleCollisionShapeComponent class >> isAbstract [
	^ self == WDGFAbstractCapsuleCollisionShapeComponent
]

{ #category : #accessing }
WDGFAbstractCapsuleCollisionShapeComponent >> height [

	^ height
]

{ #category : #accessing }
WDGFAbstractCapsuleCollisionShapeComponent >> height: anObject [

	height := anObject
]

{ #category : #accessing }
WDGFAbstractCapsuleCollisionShapeComponent >> radius [

	^ radius
]

{ #category : #accessing }
WDGFAbstractCapsuleCollisionShapeComponent >> radius: anObject [

	radius := anObject
]
