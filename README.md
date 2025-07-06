# SwiftUI Navigation Sample

A comprehensive demonstration of modern SwiftUI navigation patterns using NavigationStack, programmatic navigation, and type-safe routing. This project showcases an opinionated approach to building scalable navigation in SwiftUI applications.

Blog post: [Building Scalable SwiftUI Navigation](https://eric-liu-developer.medium.com/building-scalable-navigation-in-swiftui-wip-45ff2845e4e2)

## Overview
![Screenshot1](https://private-user-images.githubusercontent.com/3691022/462885743-473a45fb-14f5-4442-b103-7fac23e09b50.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTE3ODY2ODgsIm5iZiI6MTc1MTc4NjM4OCwicGF0aCI6Ii8zNjkxMDIyLzQ2Mjg4NTc0My00NzNhNDVmYi0xNGY1LTQ0NDItYjEwMy03ZmFjMjNlMDliNTAucG5nP1gtQW16LUFsZ29yaXRobT1BV1M0LUhNQUMtU0hBMjU2JlgtQW16LUNyZWRlbnRpYWw9QUtJQVZDT0RZTFNBNTNQUUs0WkElMkYyMDI1MDcwNiUyRnVzLWVhc3QtMSUyRnMzJTJGYXdzNF9yZXF1ZXN0JlgtQW16LURhdGU9MjAyNTA3MDZUMDcxOTQ4WiZYLUFtei1FeHBpcmVzPTMwMCZYLUFtei1TaWduYXR1cmU9NTYxODhjM2QxNDhhZWVkZGU1NWQxNTVhNmZiOWNkNjkxNWFjMWZjMTBjOWU1YjkzNWI3ZGQyN2YzY2UxZmJlMiZYLUFtei1TaWduZWRIZWFkZXJzPWhvc3QifQ.o45sOt66BgnXdwsp8MGq1eSWKF3-UXwvxEqmutTTmUI)
![Screenshot2](https://private-user-images.githubusercontent.com/3691022/462885700-92f25517-860d-4521-9688-8c53aaec209d.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTE3ODY1MzAsIm5iZiI6MTc1MTc4NjIzMCwicGF0aCI6Ii8zNjkxMDIyLzQ2Mjg4NTcwMC05MmYyNTUxNy04NjBkLTQ1MjEtOTY4OC04YzUzYWFlYzIwOWQucG5nP1gtQW16LUFsZ29yaXRobT1BV1M0LUhNQUMtU0hBMjU2JlgtQW16LUNyZWRlbnRpYWw9QUtJQVZDT0RZTFNBNTNQUUs0WkElMkYyMDI1MDcwNiUyRnVzLWVhc3QtMSUyRnMzJTJGYXdzNF9yZXF1ZXN0JlgtQW16LURhdGU9MjAyNTA3MDZUMDcxNzEwWiZYLUFtei1FeHBpcmVzPTMwMCZYLUFtei1TaWduYXR1cmU9M2QyYzc0MTg4ODViODRkZjFmMDkzY2UxOGIyZTNlYjk4OGIwOGZjMjA5ZmIwNTViOTY1YTE1YjYxMTliOTNjMCZYLUFtei1TaWduZWRIZWFkZXJzPWhvc3QifQ.vgtT_n5GjN134DI6luhGlfHljsCSLdr1rQ94X9igTjE)

This sample project demonstrates advanced SwiftUI navigation techniques that solve common navigation challenges in complex applications:

- **Single NavigationStack Architecture** - One and only NavigationStack at the root
- **Type-safe Navigation** with enum-based destinations
- **Programmatic Navigation** using a centralized router
- **Protocol-based Routing** for feature isolation and testability
- **Cross-platform Navigation** (iOS, macOS, visionOS)
- **Deep Linking Support** with NavigationStack

## Design Philosophy

### Core Principles

1. **Single Source of Truth**: One NavigationStack manages all navigation state
2. **Type Safety**: Compile-time checking of navigation destinations
3. **Dependency Inversion**: Features depend on protocols, not concrete implementations
4. **Testability**: Easy mocking and unit testing of navigation logic
5. **Scalability**: Clean separation of concerns for large applications

### Why This Approach?

Traditional SwiftUI navigation with multiple `NavigationLink`s scattered throughout the view hierarchy can become difficult to manage as applications grow. This approach provides:

- **Centralized Control**: All navigation logic in one place
- **Predictable State**: Clear navigation state management
- **Better Testing**: Isolated navigation logic for unit tests
- **Feature Isolation**: Each feature defines its own routing needs

## Navigation Architecture

### 1. Destination Enum

```swift
enum Destination: Hashable {
    case home
    case contactList
    case conversation(Contact)
    case contactDetail(Contact)
}
```

The `Destination` enum defines all possible navigation states in a type-safe manner. Each case can carry associated data (like `Contact` objects) and conforms to `Hashable` for use with `NavigationStack`.

**Key Benefits:**
- Compile-time safety for navigation destinations
- Associated values for passing data through navigation
- Hashable conformance enables use with NavigationStack's path binding

### 2. Centralized Router

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

The `Router` class serves as the single source of truth for navigation state. It manages the `navigationPath` array and provides methods for programmatic navigation.

**Key Features:**
- Single source of truth for navigation state
- Programmatic control over navigation stack
- Protocol conformance for feature-specific routing
- Observable for automatic UI updates

### 3. NavigationStack Setup

```swift
struct ContentView: View {
    @Environment(Router.self) var router
    
    var body: some View {
        @Bindable var router = router
        NavigationStack(path: $router.navigationPath) {
            HomeScreen(router: router)
                .navigationDestination(for: Destination.self) { dest in
                    RouterView(router: router, destination: dest)
                }
        }
    }
}
```

The main navigation container uses `NavigationStack` with a binding to the router's `navigationPath`. This creates a single navigation stack that manages all navigation state.

**Key Benefits:**
- Single NavigationStack for the entire app
- Type-safe navigation with `navigationDestination`
- Automatic state synchronization

### 4. Router View

```swift
struct RouterView: View {
    let router: Router
    let destination: Destination
    
    var body: some View {
        switch destination {
        case .home:
            HomeScreen(router: router)
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

**Key Benefits:**
- Clean separation of navigation logic from view logic
- Centralized view routing
- Easy to maintain and extend

## Protocol-Based Routing

### Feature-Specific Router Protocols

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

Each feature defines its own routing protocol, allowing for:

- **Feature Isolation**: Features don't depend on concrete router implementation
- **Testability**: Easy to mock routers for unit tests
- **Dependency Inversion**: Features depend on abstractions, not concretions

### Mock Implementations

```swift
#if DEBUG
class MockContactRouter: ContactRouter {
    func gotoContactDetail(_ contact: Contact) {
        // no-op for testing
    }
    
    func gotoConversation(recipient: Contact) {
        // no-op for testing
    }
    
    static var shared: MockContactRouter = MockContactRouter()
    private init() {}
}
#endif
```

Mock implementations are provided for testing and preview purposes.

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

// Navigate to contacts list
Button("Add Contact") {
    router.gotoContactsList()
}
```

### 2. Deep Linking Support

The navigation system supports deep linking through the `navigationPath` array:

```swift
// Set a specific navigation path
router.navigationPath = [.contactList, .contactDetail(contact)]

// Reset to home
router.navigationPath = []
```

### 3. Cross-Platform Navigation

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

## App Structure

### Sample App Features

The sample app demonstrates a chat application with the following navigation flows:

1. **Home Screen** → Shows chat list with navigation to contacts
2. **Contact List** → Displays contacts in table or list format  
3. **Contact Detail** → Shows detailed contact information
4. **Conversation** → Chat interface with the selected contact

### Navigation Flows

**Flow 1: Enter Existing Conversation**
```
Home → Conversation → Contact Detail 
```

**Flow 2: Start New Conversation**
```
Home → Contact List → Contact Detail → Conversation
```

The navigation stack maintains the proper state for each flow, allowing users to navigate back through the stack naturally.

## Project Structure

```
ASwiftUIApp/
├── Features/
│   ├── Navigation/
│   │   ├── Destination.swift      # Navigation destinations enum
│   │   ├── Router.swift          # Central navigation router
│   │   └── RouterView.swift      # View router
│   ├── Contact/
│   │   ├── ContactRouter.swift   # Contact-specific routing protocol
│   │   ├── ContactDetailView.swift
│   │   ├── ContactFeatureRootView.swift
│   │   ├── ContactInfoView.swift
│   │   ├── ContactList.swift
│   │   └── ContactsTable.swift
│   ├── Chat/
│   │   ├── ChatRouter.swift      # Chat-specific routing protocol
│   │   ├── ChatListItemView.swift
│   │   ├── ChatsView.swift
│   │   ├── ConversationView.swift
│   │   └── MessageBubbleView.swift
│   ├── Home/
│   │   └── HomeScreen.swift      # Main home screen
│   └── Root/
│       ├── ASwiftUIAppApp.swift  # App entry point
│       └── ContentView.swift     # Main navigation container
├── Models/
│   ├── Chat.swift
│   ├── Contact.swift
│   ├── DataModel.swift
│   └── Message.swift
└── Views/
    ├── DisplayModePicker.swift
    ├── HeaderView.swift
    └── ThumbnailView.swift
```

## Key Benefits

### 1. Type Safety
- Compile-time checking of navigation destinations
- Associated values ensure data integrity
- No runtime crashes from invalid navigation states

### 2. Centralized Control
- All navigation logic in one place
- Easy to debug and maintain
- Predictable navigation behavior

### 3. Testability
- Easy to mock routers for unit tests
- Isolated navigation logic
- Protocol-based dependencies

### 4. Scalability
- Clean separation of concerns
- Feature isolation
- Easy to add new navigation destinations

### 5. Cross-Platform
- Works on iOS, macOS, and visionOS
- Platform-specific UI adaptations
- Consistent navigation behavior

## Requirements

- iOS 17.0+ / macOS 14.0+ / visionOS 1.0+
- Xcode 15.0+
- Swift 5.9+

## Getting Started

1. Clone the repository
2. Open `SwiftUINavigationSample.xcodeproj` in Xcode
3. Build and run on your target platform
4. Explore the navigation patterns by tapping through the app
5. Examine the code to understand the implementation

## Usage Examples

### Basic Navigation

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

### Adding New Destinations

1. Add a new case to the `Destination` enum
2. Add navigation methods to the `Router` class
3. Update the `RouterView` switch statement
4. Create the corresponding view

### Testing Navigation

```swift
// Use mock router for testing
let mockRouter = MockContactRouter.shared
let view = ContactDetailView(router: mockRouter, contact: testContact)

// Test navigation calls
// Verify that router methods are called with correct parameters
```

## Best Practices

1. **Single NavigationStack**: Use only one NavigationStack at the root
2. **Type Safety**: Always use enum-based destinations
3. **Protocol Dependencies**: Features should depend on protocols, not concrete types
4. **Centralized Router**: Keep all navigation logic in one place
5. **Testability**: Design for easy testing with mock implementations

## Contributing

This sample demonstrates modern SwiftUI navigation best practices that can be adapted for your own applications. Feel free to use this as a reference for implementing scalable navigation in your SwiftUI projects.

## License

This project is licensed under the same terms as the original Apple sample code.

---

*This sample demonstrates an opinionated approach to SwiftUI navigation that prioritizes type safety, testability, and scalability. For more details on the design philosophy, see the accompanying [blog post](https://eric-liu-developer.medium.com/building-scalable-navigation-in-swiftui-wip-45ff2845e4e2).*
