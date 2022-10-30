"
I am a component that has a corresponding scene node.
"
Class {
	#name : #WDGFActorSceneComponent,
	#superclass : #WDGFActorComponent,
	#instVars : [
		'transform',
		'children',
		'parent',
		'sceneNode'
	],
	#category : #'WodenGameFramework-Core'
}

{ #category : #adding }
WDGFActorSceneComponent >> addChildSceneComponent: childComponent [
	self assert: childComponent parent isNil.

	children ifNil: [ children := OrderedCollection new. ].
	children add: childComponent.
	childComponent addedToParent: self.
	^ childComponent
]

{ #category : #notifications }
WDGFActorSceneComponent >> addedToActor: anActor [
	super addedToActor: anActor.
	anActor rootSceneComponent ifNotNil: [ :rootComponent |
		rootComponent addChildSceneComponent: self
	] ifNil: [ 
		anActor rootSceneComponent: self
	]
]

{ #category : #notifications }
WDGFActorSceneComponent >> addedToParent: aParent [
	self assert: parent isNil.
	parent := aParent.
]

{ #category : #accessing }
WDGFActorSceneComponent >> children [
	^ children ifNil: [ #() ]
]

{ #category : #initialization }
WDGFActorSceneComponent >> initialize [
	super initialize.
	transform := TRSTransform3D identity.
]

{ #category : #testing }
WDGFActorSceneComponent >> isBackgroundSceneComponent [
	^ false
]

{ #category : #accessing }
WDGFActorSceneComponent >> orientation [
	^ transform orientation
]

{ #category : #accessing }
WDGFActorSceneComponent >> orientation: newOrientation [
	transform rotation: newOrientation.
	self transformChanged.
]

{ #category : #accessing }
WDGFActorSceneComponent >> parent [
	^ parent
]

{ #category : #accessing }
WDGFActorSceneComponent >> position [
	^ transform position
]

{ #category : #accessing }
WDGFActorSceneComponent >> position: newPosition [
	transform translation: newPosition.
	self transformChanged.
]

{ #category : #copying }
WDGFActorSceneComponent >> postCopy [
	super postCopy.
	sceneNode := nil.
]

{ #category : #hooks }
WDGFActorSceneComponent >> privateRegisterInWorld [
	| sceneSubsystem |
	sceneSubsystem := ownerWorld getOrCreateSubsystemWithClass: WDGFSceneSubsystem.
	sceneNode := WDSceneNode new.
	sceneNode transform: transform.
	
	parent ifNil: [
		self isBackgroundSceneComponent ifTrue: [ 
			sceneSubsystem scene addBackground: sceneNode.
		] ifFalse: [ 
			sceneSubsystem scene add: sceneNode.		
		].
	] ifNotNil: [
		parent sceneNode add: sceneNode
	].

]

{ #category : #accessing }
WDGFActorSceneComponent >> scale [
	^ transform scale
]

{ #category : #accessing }
WDGFActorSceneComponent >> scale: newScale [
	transform scale: newScale.
	self transformChanged.
]

{ #category : #accessing }
WDGFActorSceneComponent >> sceneNode [
	^ sceneNode
]

{ #category : #accessing }
WDGFActorSceneComponent >> transform [

	^ transform
]

{ #category : #accessing }
WDGFActorSceneComponent >> transform: aTransform [
	transform := aTransform asTRSTransform3D.
	self transformChanged.
]

{ #category : #notifications }
WDGFActorSceneComponent >> transformChanged [
	sceneNode ifNotNil: [
		sceneNode transform: transform.
		(ownerWorld getOrCreateSubsystemWithClass: WDGFSceneSubsystem) sceneChanged
	]
]
