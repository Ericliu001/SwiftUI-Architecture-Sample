# Scope Architecture Design

## Overview

This SwiftUI application implements a **Scope-based Dependency Injection** architecture that organizes application dependencies into a hierarchical tree structure. Scopes serve as dependency containers that manage feature-specific resources and provide a clean separation of concerns across different parts of the application.

The scope tree structure is conceptually similar to SwiftUI's view tree hierarchy, but operates independently. While the view tree represents the UI structure, the scope tree represents the dependency injection structure, allowing for flexible dependency management that doesn't need to mirror the UI layout.

## Scope Tree Structure

Scopes are organized in a tree hierarchy where:
- Each scope can have one or more child scopes
- Parent scopes provide dependencies to their children
- Child scopes access parent dependencies through protocol contracts
- The tree structure enables feature isolation and dependency flow control

```
RootScope
├── ContactScope
├── ChatScope
│   └── ChatListItemScope
└── SettingsScope
```

**Key Principle**: The scope tree hierarchy is independent of the view tree. A parent scope doesn't need to correspond to a parent view, and child scopes can be accessed from any part of the view hierarchy that has access to the appropriate scope reference.

## Core Components

### Individual Scopes

Each scope in the tree serves as a dependency container for a specific domain or feature. Let's examine the ChatScope as a comprehensive example that demonstrates all the key parts of a scope:

**ChatScope**:
```swift
final class ChatScope {
    // 1. Parent Reference - Connection to parent scope
    private let parent: Parent
    
    init(parent: Parent) {
        self.parent = parent
    }
    
    // 2. Dependencies from Parent - Accessing parent-provided resources
    lazy var router: ChatRouter = parent.chatRouter
    
    // 3. Local Dependencies - Scope-specific resources
    lazy var messages: [Message] = Message.sampleData
    
    // 4. Child Scopes - Managing child feature domains using Weak<> wrapper
    lazy var chatListItemScope: Weak<ChatListItemScope> = Weak({ ChatListItemScope(parent: self) })
    
    // 5. View Factory Methods - Creating views with proper dependency injection
    func chatFeatureRootview() -> some View {
        ChatFeatureRootView(scope: self)
    }
    
    func chatListView() -> some View {
        ChatListView(scope: self)
    }
    
    func conversationView(contact: Contact) -> some View {
        ConversationView(scope: self, contact: contact)
    }
}
```

**Scope Anatomy Explained:**

1. **Parent Reference**: Every scope (except the root) maintains a reference to its parent scope through a protocol-defined interface

2. **Dependencies from Parent**: Properties that forward access to parent-provided dependencies, creating a clean dependency chain down the scope tree

3. **Local Dependencies**: Scope-specific state and resources that belong to this particular feature domain

4. **Child Scopes**: References to child scopes using `Weak<>` wrapper for memory efficiency, demonstrating the hierarchical nature of the scope tree

5. **View Factory Methods**: Functions that create views with the scope properly injected, ensuring consistent dependency provision

**RootScope Example** (`ASwiftUIApp/Features/Root/RootScope.swift:1`) - showing child scopes:
```swift
final class RootScope: ContactScope.Parent, ChatScope.Parent, SettingsScope.Parent {
    // Local dependencies - root-level resources
    lazy var rootRouter = Router()
    lazy var dataModel = DataModel()
    
    // Child scopes - managed feature domains using Weak<> wrapper for memory efficiency
    lazy var contactScope: Weak<ContactScope> = Weak({ ContactScope(parent: self) })
    lazy var chatScope: Weak<ChatScope> = Weak({ ChatScope(parent: self) })
    lazy var settingsScope: Weak<SettingsScope> = Weak({ SettingsScope(parent: self) })
}
```

### Parent Protocol Pattern

Each scope defines a `Parent` protocol that specifies the dependencies it requires from its parent:

```swift
extension ContactScope {
    protocol Parent {
        var contactRouter: ContactRouter { get }
        var dataModel: DataModel { get }
    }
}

extension ChatScope {
    protocol Parent {
        var chatRouter: ChatRouter { get }
    }
}

extension SettingsScope {
    protocol Parent {
        var settingsRouter: SettingsRouter { get }
    }
}

extension ChatListItemScope {
    protocol Parent {
        // No parent dependencies needed currently
        // Demonstrates that even simple scopes follow the parent protocol pattern
    }
}
```

**Design Rationale**: Parent protocols enforce dependency contracts at compile time and enable dependency inversion, making the architecture testable and flexible.

## Architecture Patterns

### Hierarchical Dependency Injection

Dependencies flow down the scope tree from parent to child:

1. **Parent Provides**: Parent scopes expose dependencies through their interface
2. **Child Accesses**: Child scopes access parent dependencies via protocol contracts
3. **Lazy Initialization**: Dependencies are created only when first accessed
4. **Scope Isolation**: Each scope manages its own domain-specific state and dependencies

### Protocol-Oriented Design

The architecture heavily leverages Swift protocols to define contracts:

- **Parent Protocols**: Define what dependencies a scope expects from its parent
- **Dependency Inversion**: Scopes depend on abstractions (protocols) rather than concrete implementations
- **Interface Segregation**: Each scope only exposes the dependencies its children need

### Feature Modularity

Scopes enable feature-based organization:

- **Domain Boundaries**: Each scope represents a logical feature or domain
- **Independent Development**: Features can be developed and tested in isolation
- **Controlled Access**: Features only access dependencies they explicitly require
- **Scalable Growth**: New features are added as new scopes in the tree

## Implementation Details

### Scope Creation and Lifecycle

Scopes are created lazily and maintain references to their parents:

```swift
// In RootScope - using Weak<> wrapper
lazy var contactScope: Weak<ContactScope> = Weak({ ContactScope(parent: self) })

// Access child scopes via .value property
contactScope.value.someMethod()
```

This pattern ensures:
- Memory efficiency through lazy initialization
- Strong parent-child relationships
- Proper dependency resolution

### View Factory Pattern

Scopes act as factories for creating views with proper dependency injection:

```swift
// In ContactScope
func contactListView() -> some View {
    ContactListView(scope: self)
}

func contactInfoView(contact: Contact) -> some View {
    ContactInfoView(scope: self, contact: contact)
}
```

**Benefits**:
- **Centralized View Creation**: All view instantiation happens through scopes
- **Consistent Dependency Injection**: Views always receive the correct scope
- **Type Safety**: Compile-time verification of view dependencies

### Dependency Access

Child scopes access parent dependencies through protocol requirements:

```swift
// In ContactScope
var dataModel: DataModel { parent.dataModel }
var contactRouter: ContactRouter { parent.contactRouter }
```

This creates a clean dependency flow where:
- Dependencies are explicitly declared
- Access is controlled and trackable
- Testing is simplified through protocol mocking

### Memory Management with Weak<> Utility

All child scope references use a `Weak<>` wrapper that provides lazy instantiation with weak reference management:

```swift
// Consistent pattern for all child scopes
lazy var childScope: Weak<ChildScope> = Weak({ ChildScope(parent: self) })

// Access child scopes via .value property
childScope.value.someMethod()
```

**The Weak<T> Utility Class:**

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

**Memory Management Benefits:**

1. **Weak References**: Child scopes are held weakly, allowing them to be deallocated when not actively used
2. **Lazy Recreation**: If a child scope is deallocated, it's automatically recreated when next accessed
3. **Memory Efficiency**: Reduces memory footprint by allowing unused scopes to be cleaned up
4. **Consistent Pattern**: All child scope references follow the same `Weak<>` wrapper pattern

**Access Pattern:**

```swift
// In views accessing child scopes
struct ChatListView: View {
    let scope: ChatScope
    
    var body: some View {
        List(chats) { chat in
            // Access via .value property
            scope.chatListItemScope.value.listItemView(chat: chat)
        }
    }
}
```

This approach ensures efficient memory usage while maintaining the lazy instantiation benefits crucial for performance in large scope hierarchies.

## Benefits & Design Rationale

### Scalability
The tree structure grows naturally with application complexity. New features are added as new scopes without affecting existing code. The `Weak<>` wrapper ensures that scope hierarchies remain memory-efficient even as they grow larger.

### Testability
Protocol-based parent contracts enable easy mocking:
```swift
#if DEBUG
extension ContactScope {
    private class MockParent: Parent {
        var contactRouter: ContactRouter = MockContactRouter()
        var dataModel: DataModel = MockDataModel()
    }
    
    static let mock = ContactScope(parent: MockParent())
}
#endif
```

### Maintainability
- **Clear Boundaries**: Each scope has well-defined responsibilities
- **Dependency Tracking**: Parent protocols make dependencies explicit
- **Feature Isolation**: Changes to one scope don't affect others

### Type Safety
The Swift type system enforces:
- Correct dependency injection at compile time
- Protocol conformance for parent relationships
- Proper view creation through scope factories

### Flexibility
- **Independent Hierarchies**: Scope tree doesn't need to match view tree
- **Selective Access**: Features only access needed dependencies
- **Easy Refactoring**: Protocol contracts make dependency changes safe

## Testing Strategy

### Mock Implementations

Each scope provides mock implementations for testing:

```swift
class MockChatScope: ChatScope {
    init() {
        super.init(parent: MockParent())
        self.messages = MockData.sampleMessages
    }
}
```

### Unit Testing Benefits

1. **Isolated Testing**: Each scope can be tested independently
2. **Dependency Mocking**: Parent protocols enable easy mock injection
3. **View Testing**: Scope factories ensure consistent test setup
4. **State Verification**: Scope-contained state is easily accessible for assertions

### Integration Testing

The scope tree enables testing of feature interactions:
- Mock parent scopes for integration tests
- Verify dependency flow between scopes
- Test feature boundaries and contracts

## Conclusion

The scope architecture provides a robust foundation for building scalable SwiftUI applications. By organizing dependencies into a tree structure with clear protocols and contracts, the architecture achieves excellent separation of concerns while maintaining type safety and testability. The independence of the scope tree from the view tree provides flexibility in how features are organized and accessed, making it easier to evolve the application architecture over time.