# SwiftUI Navigation Sample

A comprehensive demonstration of modern SwiftUI navigation patterns using NavigationStack, programmatic navigation, and type-safe routing.

## Overview

This sample project showcases advanced SwiftUI navigation techniques including:

- **Type-safe navigation** with enum-based destinations
- **Programmatic navigation** using a centralized router
- **Deep linking** support with NavigationStack
- **Protocol-based routing** for testability
- **Cross-platform navigation** (iOS, macOS)

## Navigation Architecture

### Core Navigation Components

#### 1. Destination Enum
```swift
enum Destination: Hashable {
    case home
    case contactList
    case conversation(Contact)
    case contactDetail(Contact)
}
```

The `Destination` enum defines all possible navigation states in a type-safe manner. Each case can carry associated data (like `Contact` objects) and conforms to `Hashable` for use with `NavigationStack`.

#### 2. Centralized Router
```swift
@Observable
final class Router: ContactRouter, ChatRouter {
    var navigationPath: [Destination] = []
    
    func gotoConversation(recipient: Contact) {
        navigationPath = [.conversation(recipient)]
    }
    
    func gotoContactDetail(_ contact: Contact) {
        navigationPath.append(.contactDetail(contact))
    }
    
    func gotoContactsList() {
        navigationPath.append(.contactList)
    }
}
```

The `Router` class manages navigation state using a `navigationPath` array and provides methods for programmatic navigation. It implements multiple router protocols for different features.

#### 3. NavigationStack Setup
```swift
struct ContentView: View {
    @Environment(Router.self) var router
    
    var body: some View {
        @Bindable var router = router
        NavigationStack(path: $router.navigationPath) {
            HomeScreen()
                .navigationDestination(for: Destination.self) { dest in
                    RouterView(destination: dest)
                }
        }
    }
}
```

The main navigation container uses `NavigationStack` with a binding to the router's `navigationPath`. The `navigationDestination` modifier handles type-safe navigation to different destinations.

#### 4. Router View
```swift
struct RouterView: View {
    @Environment(Router.self) var router
    let destination: Destination
    
    var body: some View {
        switch destination {
        case .home:
            HomeScreen()
        case .conversation(let recipient):
            ConversationView(router: router, contact: recipient)
        case .contactDetail(let contact):
            ContactDetailView(router: router, contact: contact)
        case .contactList:
            ContactFeatureRootView(router: router)
        }
    }
}
```

The `RouterView` acts as a switch statement that maps destinations to their corresponding views, passing the router and any associated data.

## Navigation Patterns

### 1. Programmatic Navigation

Views can trigger navigation programmatically by calling router methods:

```swift
// Navigate to contact detail
Button("View Contact") {
    router.gotoContactDetail(contact)
}

// Navigate to conversation
Button("Start Chat") {
    router.gotoConversation(recipient: contact)
}
```

### 2. Deep Linking Support

The navigation system supports deep linking through the `navigationPath` array:

```swift
// Set a specific navigation path
router.navigationPath = [.contactList, .contactDetail(contact)]
```

### 3. Protocol-Based Routing

Different features implement their own router protocols for better testability:

```swift
protocol ContactRouter {
    func gotoConversation(recipient: Contact)
    func gotoContactDetail(_ contact: Contact)
}

protocol ChatRouter {
    func gotoConversation(recipient: Contact)
    func gotoContactDetail(_ contact: Contact)
}
```

This allows for easy mocking in tests and dependency injection.

### 4. Cross-Platform Navigation

The navigation adapts to different platforms:

```swift
#if !os(macOS)
.navigationBarTitleDisplayMode(.inline)
.navigationBarItems(trailing: addButton)
#elseif os(macOS)
.toolbar {
    ToolbarItem(placement: .automatic) {
        addButton
    }
}
#endif
```

## Usage Examples

### Basic Navigation Flow

1. **Home Screen** → Shows chat list with navigation to contacts
2. **Contact List** → Displays contacts in table or list format
3. **Contact Detail** → Shows detailed contact information
4. **Conversation** → Chat interface with the selected contact

### Navigation Methods

```swift
// Navigate to contacts list
router.gotoContactsList()

// Navigate to specific contact detail
router.gotoContactDetail(contact)

// Navigate to conversation with contact
router.gotoConversation(recipient: contact)

// Reset navigation to home
router.navigationPath = []
```

## Key Benefits

1. **Type Safety**: Compile-time checking of navigation destinations
2. **Centralized Control**: All navigation logic in one place
3. **Testability**: Easy to mock routers for unit tests
4. **Deep Linking**: Support for complex navigation states
5. **Cross-Platform**: Works on iOS and macOS
6. **Maintainable**: Clear separation of concerns

## Project Structure

```
Features/
├── Navigation/
│   ├── Destination.swift      # Navigation destinations
│   ├── Router.swift          # Central navigation router
│   └── RouterView.swift      # View router
├── Contact/
│   ├── ContactRouter.swift   # Contact-specific routing
│   └── ContactDetailView.swift
├── Chat/
│   ├── ChatRouter.swift      # Chat-specific routing
│   └── ConversationView.swift
└── Root/
    └── ContentView.swift     # Main navigation container
```

## Requirements

- iOS 17.0+ / macOS 14.0+
- Xcode 15.0+
- Swift 5.9+

## Getting Started

1. Open the project in Xcode
2. Build and run on your target platform
3. Explore the navigation patterns by tapping through the app
4. Examine the code to understand the implementation

This sample demonstrates modern SwiftUI navigation best practices that can be adapted for your own applications.
