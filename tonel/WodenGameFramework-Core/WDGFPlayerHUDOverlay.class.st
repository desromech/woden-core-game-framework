"
I am a basic player HUD overlay.
"
Class {
	#name : 'WDGFPlayerHUDOverlay',
	#superclass : 'WDOverlay',
	#instVars : [
		'player'
	],
	#category : 'WodenGameFramework-Core-Actor-Character',
	#package : 'WodenGameFramework-Core',
	#tag : 'Actor-Character'
}

{ #category : 'drawing' }
WDGFPlayerHUDOverlay >> buildSceneGraphWith: builder [

	| crosshairExtent crosshairOrigin |
	crosshairExtent := 5@5.
	crosshairOrigin := (builder clippingBounds extent / 2) - (crosshairExtent / 2).
	^ builder rectangle: (crosshairOrigin extent: crosshairExtent) color: (Color orange alpha: 0.6)
]
