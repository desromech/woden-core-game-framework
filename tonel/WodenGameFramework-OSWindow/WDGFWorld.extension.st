Extension { #name : #WDGFWorld }

{ #category : #'*WodenGameFramework-OSWindow' }
WDGFWorld >> openInOSWindow [
	^ WDGFWorldOSWindow new
		wodenWorld: self;
		open
]

{ #category : #'*WodenGameFramework-OSWindow' }
WDGFWorld >> playInOSWindow [
	self beginPlay.
	^ WDGFWorldOSWindow new
		wodenWorld: self;
		open
]

{ #category : #'*WodenGameFramework-OSWindow' }
WDGFWorld >> playInVR [
	self beginPlay.
	^ WDGFWorldOSWindow new
		vrEnabled: true;
		wodenWorld: self;
		open
]
