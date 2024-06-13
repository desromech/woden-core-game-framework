"
I provide a set of actor templates that are commonly used.
"
Class {
	#name : 'WDGFActorTemplates',
	#superclass : 'Object',
	#category : 'WodenGameFramework-Core-Templates',
	#package : 'WodenGameFramework-Core',
	#tag : 'Templates'
}

{ #category : 'templates' }
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

{ #category : 'templates' }
WDGFActorTemplates class >> staticCameraWithPosition: position [
	^ WDGFActor new
		addComponent: (WDGFCameraComponent new
			position: position;
			isActive: true;
			yourself);
		yourself
]

{ #category : 'see class side' }
WDGFActorTemplates >> seeClassSide [
]
