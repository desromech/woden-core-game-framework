"
I am used for implementing 3D pointer devices.
"
Class {
	#name : #WDGF3DPointerDevice,
	#superclass : #Object,
	#instVars : [
		'activeOnlyWhenTouched',
		'pointerButtonTouchMask',
		'pointerButtonPressedMask',
		'currentPointedScreenComponents',
		'owner'
	],
	#category : #'WodenGameFramework-Core-Actor-Character'
}

{ #category : #'instance creation' }
WDGF3DPointerDevice class >> for: anActor [
	^ self new owner: anActor; yourself
]

{ #category : #accessing }
WDGF3DPointerDevice >> activeOnlyWhenTouched [

	^ activeOnlyWhenTouched
]

{ #category : #accessing }
WDGF3DPointerDevice >> activeOnlyWhenTouched: anObject [

	activeOnlyWhenTouched := anObject
]

{ #category : #initialization }
WDGF3DPointerDevice >> initialize [
	super initialize.
	activeOnlyWhenTouched := false.
	pointerButtonTouchMask := 0.
	pointerButtonPressedMask := 0.
	currentPointedScreenComponents := #().
]

{ #category : #testing }
WDGF3DPointerDevice >> isActive [
	^ activeOnlyWhenTouched not or: [(pointerButtonTouchMask bitOr: pointerButtonPressedMask) ~= 0]
]

{ #category : #accessing }
WDGF3DPointerDevice >> owner [

	^ owner
]

{ #category : #accessing }
WDGF3DPointerDevice >> owner: anObject [

	owner := anObject
]

{ #category : #updating }
WDGF3DPointerDevice >> updatePointerActionWithWorldRay: ray [
	| worldPoint oldPointedScreenComponents newPointedScreenComponents |
	worldPoint := ray origin.
	
	oldPointedScreenComponents := currentPointedScreenComponents.
	newPointedScreenComponents := #().
	self isActive ifTrue: [
		newPointedScreenComponents := (owner rayCast: ray forFirstActorSuchThat: [ :actor |
			actor hasSolidCollision
		]) ifNotNil: [ :hitResult |
			worldPoint := ray pointAtDistance: hitResult distance.
			hitResult actor components select: [ :each |
			each isInteractiveScreenComponent and: [ each containsPointInWorld: worldPoint ]
		]
		] ifNil: [ #() ].
	].

	"Leave"
	oldPointedScreenComponents do: [ :each |
		(newPointedScreenComponents includes: each) ifFalse: [
			each dispatchPointerLeave: self atWorld: worldPoint withPressedButtons: pointerButtonPressedMask
		]
	].

	"Enter"
	newPointedScreenComponents do: [ :each |
		(oldPointedScreenComponents includes: each) ifFalse: [
			each dispatchPointerEnter: self atWorld: worldPoint withPressedButtons: pointerButtonPressedMask
		]
	].

	currentPointedScreenComponents := newPointedScreenComponents.
	currentPointedScreenComponents do: [ :each |
		each dispatchPointer: self atWorld: worldPoint withPressedButtons: pointerButtonPressedMask
	].
]

{ #category : #updating }
WDGF3DPointerDevice >> updatePointerActionWithWorldRay: ray mouseButtonMask: mouseButtonState [
	pointerButtonTouchMask := pointerButtonPressedMask := mouseButtonState asMask.
	^ self updatePointerActionWithWorldRay: ray
]
