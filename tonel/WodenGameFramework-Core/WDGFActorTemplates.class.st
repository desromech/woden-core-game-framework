"
I provide a set of actor templates that are commonly used.
"
Class {
	#name : #WDGFActorTemplates,
	#superclass : #Object,
	#category : #'WodenGameFramework-Core-Templates'
}

{ #category : #templates }
WDGFActorTemplates class >> fpsCharacterActor [
	| actor cameraComponent bodyComponent cameraAngles updateOrientationFunction walkingDirection walkingSpeed updateWalkingVelocityFunction |
	cameraComponent := WDGFCameraComponent new
		isActive: true;
		position: (Vector3 y: 0.8);
		yourself.
		
	bodyComponent := WDGFCharacterBodyObjectComponent new
		mass: 70.0;
		withoutTorque;
		jumpVelocity: (Vector3 y: 2.0);
		yourself.

	actor := WDGFActor new
		addComponent: (WDGFActorSceneComponent new
			addChildSceneComponent: cameraComponent;
			yourself);
		addComponent: (WDGFCapsuleYCollisionShapeComponent height: 1.6 - 0.6 radius: 0.3);
		addComponent: bodyComponent;
		addComponent: WDGFInputListenerComponent new;
		yourself.

	cameraAngles := Vector3 zeros.
	walkingDirection := Vector3 zeros.
	walkingSpeed := 3.0.

	updateOrientationFunction := [
		cameraAngles x: (cameraAngles x clampBetween: Float halfPi negated and: Float halfPi).
		cameraComponent orientation: (Quaternion xRotation: cameraAngles x).
		actor orientation: (Quaternion yRotation: cameraAngles y).
	].
	updateWalkingVelocityFunction := [ 
		| walkingVelocity |
		walkingVelocity := walkingDirection normalized * walkingSpeed.
		bodyComponent walkingVelocity: walkingVelocity
	].

	actor
		onMouseMoveEventDo: [ :event |
			| delta |
			delta := event delta.

			event buttons leftButton ifTrue: [ 
				cameraAngles := cameraAngles + (Vector3 x: delta y negated degreesToRadians y: delta x negated degreesToRadians z: 0.0).
				updateOrientationFunction value.
			].
		];
		onKeyDownEventDo: [ :event |
			event symbol = KeyboardKey W ifTrue: [
				walkingDirection z: -1.
				updateWalkingVelocityFunction value
			].
			event symbol = KeyboardKey A ifTrue: [
				walkingDirection x: -1.
				updateWalkingVelocityFunction value
			].
			event symbol = KeyboardKey S ifTrue: [
				walkingDirection z: 1.
				updateWalkingVelocityFunction value
			].
			event symbol = KeyboardKey D ifTrue: [
				walkingDirection x: 1.
				updateWalkingVelocityFunction value
			].
			event symbol = KeyboardKey space ifTrue: [
				Transcript show: 'TODO: Jump'; cr.
			].
		];
		onKeyUpEventDo: [ :event |
			event symbol = KeyboardKey W ifTrue: [
				walkingDirection < 0 ifTrue: [
					walkingDirection z: 0.
					updateWalkingVelocityFunction value
				].
			].

			event symbol = KeyboardKey A ifTrue: [
				walkingDirection < 0 ifTrue: [
					walkingDirection x: 0.
					updateWalkingVelocityFunction value
				].
			].
		
			event symbol = KeyboardKey S ifTrue: [
				walkingDirection > 0 ifTrue: [
					walkingDirection z: 0.
					updateWalkingVelocityFunction value
				].
			].
			
			event symbol = KeyboardKey D ifTrue: [
				walkingDirection > 0 ifTrue: [
					walkingDirection x: 0.
					updateWalkingVelocityFunction value
				].
			].
		].

	^ actor
	
]

{ #category : #templates }
WDGFActorTemplates class >> noclipCameraActor [
	| actor cameraAngles cameraOrientationFunction |
	actor := WDGFActor new
		addComponent: (WDGFActorSceneComponent new
			position: (Vector3 z: 3);
			addChildSceneComponent: (WDGFCameraComponent new isActive: true; yourself);
			yourself);
		addComponent: WDGFInputListenerComponent new;
		yourself.

	cameraAngles := Vector3 zeros.
	cameraOrientationFunction := [ (Quaternion yRotation: cameraAngles y) * (Quaternion xRotation: cameraAngles x) ].
	
	actor
		onMouseMoveEventDo: [ :event |
			| delta |
			delta := event delta.

			event buttons leftButton ifTrue: [ 
				cameraAngles := cameraAngles + (Vector3 x: delta y negated degreesToRadians y: delta x negated degreesToRadians z: 0.0).
				actor orientation: cameraOrientationFunction value.
			].

			event buttons rightButton ifTrue: [ 
				actor position: actor position + (actor orientation transformVector3: (Vector3 x: delta x y: delta y negated z: 0.0) * 0.01).
			].
		];
		onMouseWheelEventDo: [ :event |
			actor position: actor position + (actor orientation transformVector3: (Vector3 z: event scrollVertical) * -0.2)
		].

	^ actor
	
]

{ #category : #templates }
WDGFActorTemplates class >> staticCameraWithPosition: position [
	^ WDGFActor new
		addComponent: (WDGFCameraComponent new
			position: position;
			isActive: true;
			yourself);
		yourself
]

{ #category : #'see class side' }
WDGFActorTemplates >> seeClassSide [
]
