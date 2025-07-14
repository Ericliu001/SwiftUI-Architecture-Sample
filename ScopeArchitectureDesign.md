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
└── SettingsScope
```

**Key Principle**: The scope tree hierarchy is independent of the view tree. A parent scope doesn't need to correspond to a parent view, and child scopes can be accessed from any part of the view hierarchy that has access to the appropriate scope reference.

## Core Components

### Individual Scopes

Each scope in the tree serves as a dependency container for a specific domain or feature. Let's examine the ChatScope as a comprehensive example that demonstrates all the key parts of a scope:

**ChatScope** (`ASwiftUIApp/Features/Chat/ChatScope.swift:1`):
```swift
final class ChatScope {
    // 1. Parent Reference - Connection to parent scope
    private let parent: Parent
    
    init(parent: Parent) {
        self.parent = parent
    }
    
    // 2. Dependencies from Parent - Accessing parent-provided resources
    var chatRouter: ChatRouter { parent.chatRouter }
    
    // 3. Local Dependencies - Scope-specific resources
    lazy var messages: [Message] = []
    
    // 4. View Factory Methods - Creating views with proper dependency injection
    func conversationView(contact: Contact) -> some View {
        ConversationView(scope: self, contact: contact)
    }
    
    func chatListView() -> some View {
        ChatListView(scope: self)
    }
    
    // 5. Child Scopes - None in this example
    // (ChatScope doesn't manage child scopes)
}
```

**Scope Anatomy Explained:**

1. **Parent Reference**: Every scope (except the root) maintains a reference to its parent scope through a protocol-defined interface

2. **Dependencies from Parent**: Properties that forward access to parent-provided dependencies, creating a clean dependency chain down the scope tree

3. **Local Dependencies**: Scope-specific state and resources that belong to this particular feature domain

4. **View Factory Methods**: Functions that create views with the scope properly injected, ensuring consistent dependency provision

5. **Child Scopes**: References to child scopes that this scope manages (when applicable)

**RootScope Example** (`ASwiftUIApp/Features/Root/RootScope.swift:1`) - showing child scopes:
```swift
final class RootScope: ContactScope.Parent, ChatScope.Parent, SettingsScope.Parent {
    // Local dependencies - root-level resources
    lazy var rootRouter = Router()
    lazy var dataModel = DataModel()
    
    // Child scopes - managed feature domains
    lazy var contactScope: ContactScope = .init(parent: self)
    lazy var chatScope: ChatScope = .init(parent: self)
    lazy var settingsScope: SettingsScope = .init(parent: self)
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
// In RootScope
lazy var contactScope: ContactScope = .init(parent: self)
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

## Benefits & Design Rationale

### Scalability
The tree structure grows naturally with application complexity. New features are added as new scopes without affecting existing code.

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