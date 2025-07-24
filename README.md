# SolUI

A lightweight collection of SwiftUI components for iOS, currently featuring a customizable button and a simple haptics utility.

---

## Features

### SolButton

`SolButton` is a highly customizable, environment-aware SwiftUI button for iOS. It supports both synchronous and asynchronous actions, loading state management, icon support, and haptic feedback. Use environment modifiers to configure style, shape, content hugging, and haptic behavior globally or per-instance.

```swift
SolButton("Save", systemImage: "tray.and.arrow.down", action: {
    action()
})
.solButtonStyle(.primary)

SolButton("Load Data", systemImage: "arrow.down.circle", action: {
    await fetchData()
})
.solButtonStyle(.secondary)
```
    
### Haptics

A lightweight, type-safe Swift utility for triggering haptic feedback on supported Apple devices. `Haptics` wraps UIKit’s haptic feedback generators with a simple API. Use impact feedback to simulate physical touches, taps, or collisions with different intensity levels.

```swift
// Trigger a medium impact haptic
Haptics.impact(.medium)

// Trigger a soft impact haptic
Haptics.impact(.soft)
```

---

## Installation

### Swift Package Manager

Add the following to your `Package.swift` dependencies:

```swift
.package(url: "https://github.com/andygandara/SolUI.git", from: "1.0.0")
```

---

## Contact

Andy Gandara
[andygandara.com](https://andygandara.com)
[x.com/andygandarasoma](https://x.com/andygandarasoma)
