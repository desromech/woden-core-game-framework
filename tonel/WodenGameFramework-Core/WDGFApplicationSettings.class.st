"
I hold the settings for a specific game framework application.
"
Class {
	#name : #WDGFApplicationSettings,
	#superclass : #Object,
	#category : #'WodenGameFramework-Core-Actor'
}

{ #category : #converting }
WDGFApplicationSettings class >> asApplicationSettings [
	^ self new
]

{ #category : #converting }
WDGFApplicationSettings >> asApplicationSettings [
	^ self
]

{ #category : #'accessing - ui' }
WDGFApplicationSettings >> assetsLocations [
	^	self projectLocation
			ifNotNil: [ :location | { location / 'assets' } ]
			ifNil: [ #() ]
]

{ #category : #'accessing - ui' }
WDGFApplicationSettings >> projectLocation [
	^ FileLocator imageDirectory
]
