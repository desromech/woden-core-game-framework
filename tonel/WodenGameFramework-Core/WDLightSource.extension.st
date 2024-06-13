Extension { #name : 'WDLightSource' }

{ #category : '*WodenGameFramework-Core' }
WDLightSource >> asGameFrameworkActor [
	^ self asGameFrameworkComponent asGameFrameworkActor
]

{ #category : '*WodenGameFramework-Core' }
WDLightSource >> asGameFrameworkComponent [
	^ WDGFActorLightSourceSceneComponent with: self
]
