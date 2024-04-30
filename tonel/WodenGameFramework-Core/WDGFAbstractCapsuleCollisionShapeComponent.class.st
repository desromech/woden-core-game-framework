"
I am a compound collision shape component.
"
Class {
	#name : #WDGFAbstractCapsuleCollisionShapeComponent,
	#superclass : #WDGFAbstractCollisionShapeComponent,
	#instVars : [
		'height',
		'radius'
	],
	#category : #'WodenGameFramework-Core-Components-Physics'
}

{ #category : #construction }
WDGFAbstractCapsuleCollisionShapeComponent class >> height: height radius: radius [
	^ self new height: height; radius: radius; yourself
]

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
