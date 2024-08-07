"
I am a component that has a corresponding scene node.
"
Class {
	#name : 'WDGFActorSceneComponent',
	#superclass : 'WDGFActorComponent',
	#instVars : [
		'transform',
		'children',
		'parent',
		'sceneNode',
		'sceneBackground',
		'visible'
	],
	#category : 'WodenGameFramework-Core-Components-Scene',
	#package : 'WodenGameFramework-Core',
	#tag : 'Components-Scene'
}

{ #category : 'adding' }
WDGFActorSceneComponent >> addChildSceneComponent: childComponent [
	self assert: childComponent parent isNil.

	children ifNil: [ children := OrderedCollection new. ].
	children add: childComponent.
	childComponent addedToParent: self.
	(owner notNil and: [childComponent owner isNil]) ifTrue: [
		owner addComponent: childComponent
	].
	^ childComponent
]

{ #category : 'notifications' }
WDGFActorSceneComponent >> addedDirectlyToActor: anActor [
	super addedDirectlyToActor: anActor.
	parent ifNil: [ 
		anActor rootSceneComponent ifNotNil: [ :rootComponent |
			rootComponent addChildSceneComponent: self
		] ifNil: [ 
			anActor rootSceneComponent: self
		].
	].

]

{ #category : 'notifications' }
WDGFActorSceneComponent >> addedToActor: anActor [
	super addedToActor: anActor.
	self children do: [ :each | anActor addComponent: each ].
]

{ #category : 'notifications' }
WDGFActorSceneComponent >> addedToParent: aParent [
	self assert: parent isNil.
	parent := aParent.
]

{ #category : 'accessing' }
WDGFActorSceneComponent >> angularVelocity [
	^ owner angularVelocity
]

{ #category : 'accessing' }
WDGFActorSceneComponent >> beSceneBackground [
	self sceneBackground: true
]

{ #category : 'accessing' }
WDGFActorSceneComponent >> children [
	^ children ifNil: [ #() ]
]

{ #category : 'initialization' }
WDGFActorSceneComponent >> initialize [
	super initialize.
	transform := TRSTransform3D identity.
	sceneBackground := false.
	visible := true.
]

{ #category : 'accessing' }
WDGFActorSceneComponent >> linearVelocity [
	^ owner linearVelocity
]

{ #category : 'accessing' }
WDGFActorSceneComponent >> orientation [
	^ transform orientation
]

{ #category : 'accessing' }
WDGFActorSceneComponent >> orientation: newOrientation [
	transform rotation: newOrientation.
	self transformChanged.
]

{ #category : 'accessing' }
WDGFActorSceneComponent >> parent [
	^ parent
]

{ #category : 'accessing' }
WDGFActorSceneComponent >> position [
	^ transform position
]

{ #category : 'accessing' }
WDGFActorSceneComponent >> position: newPosition [
	transform translation: newPosition.
	self transformChanged.
]

{ #category : 'copying' }
WDGFActorSceneComponent >> postCopy [
	super postCopy.
	sceneNode := nil.
]

{ #category : 'hooks' }
WDGFActorSceneComponent >> privateConstructSceneNode [
	^ WDSceneNode new
]

{ #category : 'hooks' }
WDGFActorSceneComponent >> privateRegisterInWorld [
	| sceneSubsystem |
	sceneSubsystem := ownerWorld sceneSubsystem.
	sceneNode := self privateConstructSceneNode.
	sceneNode transform: transform.
	sceneNode visible: visible.
	
	parent ifNil: [
		sceneBackground ifTrue: [ 
			sceneSubsystem scene addBackground: sceneNode.
		] ifFalse: [ 
			sceneSubsystem scene add: sceneNode.		
		].
	] ifNotNil: [
		parent sceneNode add: sceneNode
	].

]

{ #category : 'hooks' }
WDGFActorSceneComponent >> privateUnregisterFromWorld [
	sceneNode removeFromScene.
	sceneNode := nil.
]

{ #category : 'accessing' }
WDGFActorSceneComponent >> scale [
	^ transform scale
]

{ #category : 'accessing' }
WDGFActorSceneComponent >> scale: newScale [
	transform scale: newScale.
	self transformChanged.
]

{ #category : 'accessing' }
WDGFActorSceneComponent >> sceneBackground [

	^ sceneBackground
]

{ #category : 'accessing' }
WDGFActorSceneComponent >> sceneBackground: anObject [

	sceneBackground := anObject
]

{ #category : 'accessing' }
WDGFActorSceneComponent >> sceneNode [
	^ sceneNode
]

{ #category : 'accessing' }
WDGFActorSceneComponent >> transform [

	^ transform
]

{ #category : 'accessing' }
WDGFActorSceneComponent >> transform: aTransform [
	transform := aTransform asTRSTransform3D.
	self transformChanged.
]

{ #category : 'notifications' }
WDGFActorSceneComponent >> transformChanged [
	sceneNode ifNotNil: [
		sceneNode transform: transform.
		ownerWorld sceneSubsystem sceneChanged
	]
]

{ #category : 'transforms' }
WDGFActorSceneComponent >> transformNormalVectorToWorld: normalVector [
	| parentNormalVector |
	parentNormalVector := transform transformNormalVector: normalVector.
	^ parent
		ifNil: [parentNormalVector]
		ifNotNil: [parent transformNormalVector: parentNormalVector]
]

{ #category : 'transforms' }
WDGFActorSceneComponent >> transformOrientationToWorld: orientation [
	| parentOrientation |
	parentOrientation := transform rotation * orientation.
	^ parent
		ifNil: [parentOrientation]
		ifNotNil: [parent transformOrientationToWorld: parentOrientation]
]

{ #category : 'transforms' }
WDGFActorSceneComponent >> transformPositionToActorLocal: position [
	parent ifNil: [ ^ position ].
	^ parent transformPositionToActorLocal: (transform transformPosition: position)
]

{ #category : 'transforms' }
WDGFActorSceneComponent >> transformPositionToWorld: position [
	| parentPosition |
	parentPosition := transform transformPosition: position.
	^ parent
		ifNil: [parentPosition]
		ifNotNil: [parent transformPositionToWorld: parentPosition]
]

{ #category : 'transforms' }
WDGFActorSceneComponent >> transformVectorToWorld: vector [
	| parentVector |
	parentVector := transform transformVector3: vector.
	^ parent
		ifNil: [parentVector]
		ifNotNil: [parent transformVectorToWorld: parentVector]
]

{ #category : 'transforms' }
WDGFActorSceneComponent >> transformWorldOrientationToLocal: orientation [
	| parentOrientation |
	parentOrientation := parent
		ifNil: [orientation]
		ifNotNil: [parent transformWorldOrientationToLocal: orientation].
	
	^ transform inverseRotation * parentOrientation
]

{ #category : 'transforms' }
WDGFActorSceneComponent >> transformWorldPositionToLocal: position [
	| parentPosition |
	parentPosition := parent
		ifNil: [position]
		ifNotNil: [parent transformWorldPositionToLocal: position].
	^ transform inverseTransformPosition: parentPosition.

]

{ #category : 'accessing' }
WDGFActorSceneComponent >> visible [

	^ visible
]

{ #category : 'accessing' }
WDGFActorSceneComponent >> visible: aBoolean [
	visible := aBoolean.
	sceneNode ifNotNil: [ sceneNode visible: visible ].
]

{ #category : 'transforms' }
WDGFActorSceneComponent >> worldRayFrom: localStartPoint to: localEndPoint [
	^ Ray3D from: (self transformPositionToWorld: localStartPoint) to: (self transformPositionToWorld: localEndPoint)
]
