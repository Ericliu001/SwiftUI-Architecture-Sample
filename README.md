# SwiftUI Navigation Sample - Dual Architecture Design

A comprehensive demonstration of modern SwiftUI navigation patterns combined with scope-based dependency injection architecture. This project showcases two complementary architectural approaches: **Navigation Architecture** (TabView, multiple NavigationStacks, programmatic navigation, and type-safe routing) and **Scope Architecture** (hierarchical dependency injection with protocol-based isolation). Together, they create a scalable foundation for building complex SwiftUI applications.


## Overview
![Screenshot1](https://private-user-images.githubusercontent.com/3691022/463651883-0cb7d068-08c6-44ad-94ed-e80b9b987644.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTI1MDEzMTAsIm5iZiI6MTc1MjUwMTAxMCwicGF0aCI6Ii8zNjkxMDIyLzQ2MzY1MTg4My0wY2I3ZDA2OC0wOGM2LTQ0YWQtOTRlZC1lODBiOWI5ODc2NDQucG5nP1gtQW16LUFsZ29yaXRobT1BV1M0LUhNQUMtU0hBMjU2JlgtQW16LUNyZWRlbnRpYWw9QUtJQVZDT0RZTFNBNTNQUUs0WkElMkYyMDI1MDcxNCUyRnVzLWVhc3QtMSUyRnMzJTJGYXdzNF9yZXF1ZXN0JlgtQW16LURhdGU9MjAyNTA3MTRUMTM1MDEwWiZYLUFtei1FeHBpcmVzPTMwMCZYLUFtei1TaWduYXR1cmU9ODc1NzI2Yzg2ZmNhMmMyNWMzOWYyMDZhOTJmZTAxZDIzMjAyMjQzZDk2OTJkZmRiZWQ3OTlmYjkwZTUyNjE4OSZYLUFtei1TaWduZWRIZWFkZXJzPWhvc3QifQ.r60cydyvVUfV8OHqRkIGUbDzv1EkSal4RupbBG4bkO4)
![Screenshot2](https://private-user-images.githubusercontent.com/3691022/463651885-edfca4fe-bd05-4609-ad13-249ad08899de.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTI1MDEzMTAsIm5iZiI6MTc1MjUwMTAxMCwicGF0aCI6Ii8zNjkxMDIyLzQ2MzY1MTg4NS1lZGZjYTRmZS1iZDA1LTQ2MDktYWQxMy0yNDlhZDA4ODk5ZGUucG5nP1gtQW16LUFsZ29yaXRobT1BV1M0LUhNQUMtU0hBMjU2JlgtQW16LUNyZWRlbnRpYWw9QUtJQVZDT0RZTFNBNTNQUUs0WkElMkYyMDI1MDcxNCUyRnVzLWVhc3QtMSUyRnMzJTJGYXdzNF9yZXF1ZXN0JlgtQW16LURhdGU9MjAyNTA3MTRUMTM1MDEwWiZYLUFtei1FeHBpcmVzPTMwMCZYLUFtei1TaWduYXR1cmU9MGY0ZWU5NzE4MWY3NTI4ZjcwNTM2YjJlZDJkNTA3ZDIwYzY0MTU3ZWUyYzQ5MWIyMzE1M2M2YWRjZTQ5ZDcwMiZYLUFtei1TaWduZWRIZWFkZXJzPWhvc3QifQ.Gr-cMjVgIgLNalj3io0Y_8zrXBXQCUClEvuMfM316Cc)
![Screenshot3](https://private-user-images.githubusercontent.com/3691022/463651884-b7716b24-b050-488f-90d4-350cee51acb7.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTE5NzI4NjQsIm5iZiI6MTc1MTk3MjU2NCwicGF0aCI6Ii8zNjkxMDIyLzQ2MzY1MTg4NC1iNzcxNmIyNC1iMDUwLTQ4OGYtOTBkNC0zNTBjZWU1MWFjYjcucG5nP1gtQW16LUFsZ29yaXRobT1BV1M0LUhNQUMtU0hBMjU2JlgtQW16LUNyZWRlbnRpYWw9QUtJQVZDT0RZTFNBNTNQUUs0WkElMkYyMDI1MDcwOCUyRnVzLWVhc3QtMSUyRnMzJTJGYXdzNF9yZXF1ZXN0JlgtQW16LURhdGU9MjAyNTA3MDhUMTEwMjQ0WiZYLUFtei1FeHBpcmVzPTMwMCZYLUFtei1TaWduYXR1cmU9YzM1ZTE2OGYyYTI1N2M5YjM1NDE2MDdhMzYxZjk4NGNlNTgyY2E5NzdlZmFhM2FkOTllOTdjNGE4MjcwNGE5MCZYLUFtei1TaWduZWRIZWFkZXJzPWhvc3QifQ.2BuchI9L0zi2aNpHDahkj3rHEiC92FAi3p-lPxm-Vs0)

This sample project demonstrates two complementary architectural approaches that together solve complex challenges in building scalable SwiftUI applications:

**Navigation Architecture ([Wiki](https://github.com/Ericliu001/SwiftUI-Navigation-Sample/wiki/Navigation)):**
- **TabView with Multiple NavigationStacks** - Each tab has its own independent NavigationStack and navigation state
- **Type-safe Navigation** with enum-based destinations
- **Programmatic Navigation** using a centralized router
- **Protocol-based Routing** for feature isolation and testability

**Scope Architecture ([Wiki](https://github.com/Ericliu001/SwiftUI-Navigation-Sample/wiki/Scope-Architecture-Design)):**
- **Hierarchical Dependency Injection** - Scope tree manages dependencies independently of view hierarchy
- **Protocol-based Parent Contracts** - Child scopes define required dependencies through protocols
- **Feature Isolation** - Each scope owns its domain-specific dependencies and state
- **Testability** - Easy mocking through scope hierarchies and protocol abstractions


#### How They Work Together

The two architectures complement each other:

1. **Scope Architecture** manages dependency injection and feature isolation
2. **Navigation Architecture** handles routing and navigation state
3. Scopes inject routers into views through the dependency tree
4. Views trigger navigation through injected router protocols
5. Router manages navigation state centrally while scopes provide the dependencies

This combination enables building complex applications with clear separation of concerns, excellent testability, and maintainable feature boundaries.

## Navigation Architecture Details

### 1. Destination Enum

```swift
enum Destination: Hashable {
    case home
    case contactList
    case conversation(Contact)
    case contactDetail(Contact)
    case profile_settings
    case privacy_settings
}
```

The `Destination` enum defines all possible navigation states in a type-safe manner. Each case can carry associated data (like `Contact` objects) and conforms to `Hashable` for use with `NavigationStack`.

**Key Benefits:**
- Compile-time safety for navigation destinations
- Associated values for passing data through navigation
- Hashable conformance enables use with NavigationStack's path binding

### 2. Centralized Router and Protocol-Based Routing

```swift
@Observable
final class Router: ContactRouter, ChatRouter, SettingsRouter {
    var selectedTab: Tabs = .chats
    var chatTabPath: [Destination] = []
    var settingsTabPath: [Destination] = []
    // ... navigation methods for each tab ...
}
```

The `Router` class serves as the single source of truth for navigation state. It manages a separate navigation path for each tab (e.g., `chatTabPath`, `settingsTabPath`) and provides methods for programmatic navigation. While the implementation of routing logic is centralized, the interfaces for routing are defined by features, improving feature isolation.

#### Feature-Specific Router Protocols

```swift
protocol ContactRouter {
    func gotoConversation(recipient: Contact)
    func gotoContactDetail(_ contact: Contact)
}
```

Each feature defines its own routing protocol, allowing for:

- **Feature Isolation**: Features don't depend on concrete router implementation
- **Testability**: Easy to mock routers for unit tests
- **Dependency Inversion**: Features depend on abstractions, not concretions

**Key Features:**
- Single source of truth for navigation state
- Programmatic control over navigation stack
- Protocol conformance for feature-specific routing

### 3. TabView and Multiple NavigationStacks Setup

```swift
struct ContentView: View {
    @Environment(Router.self) var router
    var body: some View {
        @Bindable var router = router
        TabView(selection: $router.selectedTab) {
            Tab(
                Tabs.chats.name,
                systemImage: Tabs.chats.systemImageName,
                value: Tabs.chats
            ) {
                NavigationStack(path: $router.chatTabPath) {
                    HomeScreen(router: router)
                        .navigationDestination(for: Destination.self) { dest in
                            RouterView(router: router, destination: dest)
                        }
                }
            }
            Tab(
                Tabs.settings.name,
                systemImage: Tabs.settings.systemImageName,
                value: Tabs.settings
            ) {
                NavigationStack(path: $router.settingsTabPath) {
                    SettingsHomeView(router: router)
                        .navigationDestination(for: Destination.self) { dest in
                            RouterView(router: router, destination: dest)
                        }
                }
            }
        }
    }
}
```

The main navigation container uses a `TabView` with a separate `NavigationStack` for each tab, each bound to its own navigation path in the router. This allows each tab to maintain its own navigation history independently.

**Key Benefits:**
- Independent navigation stacks for each tab
- Type-safe navigation with `navigationDestination`
- Automatic state synchronization and retention when switching tabs

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
        case .profile_settings:
            ProfileSettingsView()
        case .privacy_settings:
            PrivacySettingsView()
        }
    }
}
```

The `RouterView` acts as a switch statement that maps destinations to their corresponding views, passing the router and any associated data.

**Key Benefits:**
- Clean separation of navigation logic from view logic
- Centralized view routing
- Easy to maintain and extend

## Programmatic Navigation

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

## Scope Architecture Details

The Scope Architecture implements a hierarchical dependency injection system that manages application dependencies independently of the view hierarchy. This provides clean feature isolation, excellent testability, and scalable dependency management.

### 1. Scope Hierarchy

The application uses a tree structure of scopes:

```
RootScope
├── ContactScope
├── ChatScope
│   └── ChatListItemScope
└── SettingsScope
```

Each scope manages its own dependencies and can provide dependencies to child scopes.

### 2. Scope Implementation Pattern

A scope is a dependency container that manages resources for a specific feature or domain. Here's what constitutes a scope using ChatScope as an example:

```swift
final class ChatScope {
    // Parent Reference - connection to parent scope
    private let parent: Parent
    
    // Dependencies from Parent - accessing shared resources
    lazy var router: ChatRouter = parent.chatRouter
    
    // Local Dependencies - feature-specific state and resources
    lazy var messages: [Message] = Message.sampleData
    
    // Child Scopes - using Weak<> wrapper for memory efficiency
    lazy var chatListItemScope: Weak<ChatListItemScope> = Weak({ ChatListItemScope(parent: self) })

    // Initialization
    init(parent: Parent) {
        self.parent = parent
    }

    // View Factory Methods - centralized view creation
    func chatFeatureRootview() -> some View {
        ChatFeatureRootView(scope: self)
    }
    
    func conversationView(contact: Contact) -> some View {
        ConversationView(scope: self, contact: contact)
    }
}

extension ChatScope {
    // Parent Protocol - defines required dependencies
    protocol Parent {
        var chatRouter: ChatRouter { get }
    }
}
```

**Key Components of a Scope:**
- **Parent Reference**: Receives dependencies from parent through protocols
- **Local Dependencies**: Manages feature-specific state and resources
- **Child Scopes**: Can contain other scopes for sub-features (using `Weak<>` wrapper)
- **View Factory Methods**: Creates views with proper dependency injection
- **Parent Protocol**: Defines contract for required dependencies
- **Lazy Loading**: Dependencies are created only when needed

### 3. Scope Tree Structure

The application organizes scopes in a hierarchical tree, where each scope can contain child scopes and receives dependencies from its parent:

```swift
// Parent scope providing shared dependencies
final class RootScope: ChatScope.Parent, ContactScope.Parent, SettingsScope.Parent {
    lazy var rootRouter = Router()
    lazy var dataModel = DataModel()
    
    // Protocol implementations for child scopes
    lazy var chatRouter: ChatRouter = rootRouter
    lazy var contactRouter: ContactRouter = rootRouter
    
    // Child scopes - using Weak<> wrapper for consistent memory management
    lazy var contactScope: Weak<ContactScope> = Weak({ ContactScope(parent: self) })
    lazy var chatScope: Weak<ChatScope> = Weak({ ChatScope(parent: self) })
    lazy var settingsScope: Weak<SettingsScope> = Weak({ SettingsScope(parent: self) })
}

// Child scope within the chat domain
final class ChatListItemScope {
    private let parent: Parent
    
    init(parent: Parent) {
        self.parent = parent
    }
    
    func listItemView(chat: Chat) -> some View {
        ChatListItemView(chat: chat)
    }
}

extension ChatListItemScope {
    protocol Parent {
        // No parent dependencies needed currently
    }
}
```

**Tree Benefits:**
- **Dependency Flow Control**: Dependencies flow down from parent to child
- **Feature Isolation**: Each scope manages its own domain
- **Lazy Creation**: Scopes are created only when needed
- **Clean Boundaries**: Clear separation between different app areas

### 4. Weak<> Utility for Memory Management

All child scope references use a `Weak<>` wrapper that provides lazy instantiation with weak reference management:

```swift
// Consistent pattern for all child scopes
lazy var childScope: Weak<ChildScope> = Weak({ ChildScope(parent: self) })

// Access child scopes via .value property
childScope.value.someMethod()
```

The `Weak<T>` utility class offers several benefits:

**Memory Efficiency:**
- Holds weak references to child scopes to prevent unnecessary memory usage
- Allows child scopes to be deallocated when not actively used
- Recreates instances automatically when needed using the provider closure

**Consistent Pattern:**
- All child scope references follow the same `Weak<>` wrapper pattern
- Uniform access via `.value` property across the codebase
- Lazy instantiation - scopes created only when first accessed

**Implementation:**
```swift
class Weak<T: AnyObject> {
    private weak var _value: T?
    private let provider: () -> T
    
    init(_ provider: @escaping () -> T) {
        self.provider = provider
    }
    
    var value: T {
        if let value = _value {
            return value
        }
        let newValue = provider()
        _value = newValue
        return newValue
    }
}
```

This approach ensures consistent memory management across all child scopes while maintaining the lazy instantiation benefits that are crucial for performance in large scope hierarchies.

### 5. Dependency Injection in Views

```swift
struct ChatFeatureRootView: View {
    let scope: ChatScope

    var body: some View {
        VStack {
            scope.chatListView()  // Using scope as view factory
        }
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button(action: {
                    scope.router.gotoContactList()  // Using injected router
                }) {
                    Image(systemName: "plus.circle.fill")
                }
            }
        }
    }
}

// Example of accessing child scopes with .value
struct ChatListView: View {
    let scope: ChatScope
    
    var body: some View {
        List(chats) { chat in
            scope.chatListItemScope.value.listItemView(chat: chat)  // Access via .value
        }
    }
}
```

Views receive their dependencies through scopes, enabling clean separation and easy testing.

### 6. Testing with Mock Scopes

```swift
#if DEBUG
extension ChatScope {
    private class MockParent: Parent {
        var chatRouter: ChatRouter = MockChatRouter.shared
    }

    static let mock = ChatScope(parent: MockParent())
}
#endif
```

The scope architecture enables comprehensive testing through:
- **Mock Parent Implementations**: Easy to create test doubles for parent dependencies
- **Isolated Testing**: Each scope can be tested independently
- **Protocol Abstractions**: Mock routers and dependencies through protocol conformance

### 7. Integration with Navigation Architecture

The scope architecture integrates seamlessly with the navigation architecture:

1. **Parent scopes** create and provide access to the central `Router`
2. **Feature scopes** receive router protocols through parent dependencies
3. **Views** trigger navigation through scope-injected router protocols
4. **Router** manages navigation state centrally while scopes provide structure

This integration ensures that dependency management and navigation concerns remain properly separated while working together effectively.


---

*This sample demonstrates an opinionated approach to SwiftUI navigation that prioritizes type safety, testability, and scalability. For more details on the design philosophy, see the accompanying blog post: [Building Scalable SwiftUI Navigation](https://eric-liu-developer.medium.com/building-scalable-navigation-in-swiftui-wip-45ff2845e4e2).*
