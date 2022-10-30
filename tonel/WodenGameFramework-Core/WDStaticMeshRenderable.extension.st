Extension { #name : #WDStaticMeshRenderable }

{ #category : #'*WodenGameFramework-Core' }
WDStaticMeshRenderable >> asGameFrameworkActor [
	^ self asGameFrameworkComponent asGameFrameworkActor
]

{ #category : #'*WodenGameFramework-Core' }
WDStaticMeshRenderable >> asGameFrameworkComponent [
	^ WDGFActorStaticMeshSceneComponent with: self
]
