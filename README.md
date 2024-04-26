# Woden Core - Game Framework
## Loading in Pharo:

The minimalistic Woden Core Game Framework built on top of the different Woden components with a heavy inspiration from the Unreal Engine 4/5 Game Framework API:

```smalltalk
EpMonitor disableDuring: [
    Author useAuthor: 'Load' during: [
        Metacello new
           baseline: 'WodenGameFramework';
           repository: 'github://ronsaldo/woden-core-game-framework';
           onConflictUseIncoming;
           load
    ]
]
```

See the **WDGFExamples** class for examples on how to use this API.

## Loading in Squeak:

The game framework component can be loaded on Squeak by doing the following in a Workspace:

```smalltalk
Metacello new
    baseline: 'WodenGameFramework';
    repository: 'github://ronsaldo/woden-core-game-framework';
    onConflictUseIncoming;
    load
```

On Squeak the AbstractGPU library must be installed manually, look for the latest release on https://github.com/desromech/abstract-gpu for find the binary library. Download the release for your platform in a folder that can be found by the Squeak VM, and perform a save and quit of the image.
