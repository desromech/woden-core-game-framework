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
			baseline: #'WodenSceneGraph' with: [ spec repository: 'github://desromech/woden-core-scene-graph' ];
			baseline: #'WodenCorePhysics' with: [ spec repository: 'github://desromech/woden-core-physics' ];
			package: #'WodenGameFramework-Core' with: [
				spec requires: #( #'WodenSceneGraph' #'WodenCorePhysics').
			];
			package: #'WodenGameFramework-Core-Tests' with: [
				spec requires: #( #'WodenGameFramework-Core' ).
			];
			package: #'WodenGameFramework-Morphic' with: [];
			package: #'WodenGameFramework-Examples' with: []
	].

	spec for: #pharo do: [
		spec
			package: #'WodenGameFramework-OSWindow' with: [
				spec requires: #( #'WodenGameFramework-Core')
			];
			package: #'WodenGameFramework-Spec' with: [
				spec requires: #( #'WodenGameFramework-Core' #'WodenGameFramework-Morphic').
			]
	].

]
