Class {
	#name : #BaselineOfWodenGameFramework,
	#superclass : #BaselineOf,
	#category : #BaselineOfWodenGameFramework
}

{ #category : #baselines }
BaselineOfWodenGameFramework >> baseline: spec [
    <baseline>
	spec for: #'common' do: [
		spec
			baseline: #'WodenSceneGraph' with: [ spec repository: 'github://ronsaldo/woden-core-scene-graph' ];
			package: #'WodenGameFramework-Core' with: [
				spec requires: #( #'WodenSceneGraph').
			];
			package: #'WodenGameFramework-Core-Tests' with: [
				spec requires: #( #'WodenGameFramework-Core' ).
			];
			package: #'WodenGameFramework-Spec' with: [
				spec requires: #( #'WodenGameFramework-Core').
			];
			package: #'WodenGameFramework-Morphic' with: [
				spec requires: #( #'WodenGameFramework-Spec').
			];
			package: #'WodenGameFramework-Examples' with: [
				spec requires: #( #'WodenGameFramework-Spec').
			]

	].

]
