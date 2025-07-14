# SwiftUI Navigation Sample

A comprehensive demonstration of modern SwiftUI navigation patterns using TabView, multiple NavigationStacks, programmatic navigation, and type-safe routing. This project showcases an opinionated approach to building scalable navigation in SwiftUI applications.


## Overview
![Screenshot1](https://private-user-images.githubusercontent.com/3691022/463651883-0cb7d068-08c6-44ad-94ed-e80b9b987644.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTI1MDEzMTAsIm5iZiI6MTc1MjUwMTAxMCwicGF0aCI6Ii8zNjkxMDIyLzQ2MzY1MTg4My0wY2I3ZDA2OC0wOGM2LTQ0YWQtOTRlZC1lODBiOWI5ODc2NDQucG5nP1gtQW16LUFsZ29yaXRobT1BV1M0LUhNQUMtU0hBMjU2JlgtQW16LUNyZWRlbnRpYWw9QUtJQVZDT0RZTFNBNTNQUUs0WkElMkYyMDI1MDcxNCUyRnVzLWVhc3QtMSUyRnMzJTJGYXdzNF9yZXF1ZXN0JlgtQW16LURhdGU9MjAyNTA3MTRUMTM1MDEwWiZYLUFtei1FeHBpcmVzPTMwMCZYLUFtei1TaWduYXR1cmU9ODc1NzI2Yzg2ZmNhMmMyNWMzOWYyMDZhOTJmZTAxZDIzMjAyMjQzZDk2OTJkZmRiZWQ3OTlmYjkwZTUyNjE4OSZYLUFtei1TaWduZWRIZWFkZXJzPWhvc3QifQ.r60cydyvVUfV8OHqRkIGUbDzv1EkSal4RupbBG4bkO4)
![Screenshot2](https://private-user-images.githubusercontent.com/3691022/463651885-edfca4fe-bd05-4609-ad13-249ad08899de.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTI1MDEzMTAsIm5iZiI6MTc1MjUwMTAxMCwicGF0aCI6Ii8zNjkxMDIyLzQ2MzY1MTg4NS1lZGZjYTRmZS1iZDA1LTQ2MDktYWQxMy0yNDlhZDA4ODk5ZGUucG5nP1gtQW16LUFsZ29yaXRobT1BV1M0LUhNQUMtU0hBMjU2JlgtQW16LUNyZWRlbnRpYWw9QUtJQVZDT0RZTFNBNTNQUUs0WkElMkYyMDI1MDcxNCUyRnVzLWVhc3QtMSUyRnMzJTJGYXdzNF9yZXF1ZXN0JlgtQW16LURhdGU9MjAyNTA3MTRUMTM1MDEwWiZYLUFtei1FeHBpcmVzPTMwMCZYLUFtei1TaWduYXR1cmU9MGY0ZWU5NzE4MWY3NTI4ZjcwNTM2YjJlZDJkNTA3ZDIwYzY0MTU3ZWUyYzQ5MWIyMzE1M2M2YWRjZTQ5ZDcwMiZYLUFtei1TaWduZWRIZWFkZXJzPWhvc3QifQ.Gr-cMjVgIgLNalj3io0Y_8zrXBXQCUClEvuMfM316Cc)
![Screenshot3](https://private-user-images.githubusercontent.com/3691022/463651884-b7716b24-b050-488f-90d4-350cee51acb7.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTE5NzI4NjQsIm5iZiI6MTc1MTk3MjU2NCwicGF0aCI6Ii8zNjkxMDIyLzQ2MzY1MTg4NC1iNzcxNmIyNC1iMDUwLTQ4OGYtOTBkNC0zNTBjZWU1MWFjYjcucG5nP1gtQW16LUFsZ29yaXRobT1BV1M0LUhNQUMtU0hBMjU2JlgtQW16LUNyZWRlbnRpYWw9QUtJQVZDT0RZTFNBNTNQUUs0WkElMkYyMDI1MDcwOCUyRnVzLWVhc3QtMSUyRnMzJTJGYXdzNF9yZXF1ZXN0JlgtQW16LURhdGU9MjAyNTA3MDhUMTEwMjQ0WiZYLUFtei1FeHBpcmVzPTMwMCZYLUFtei1TaWduYXR1cmU9YzM1ZTE2OGYyYTI1N2M5YjM1NDE2MDdhMzYxZjk4NGNlNTgyY2E5NzdlZmFhM2FkOTllOTdjNGE4MjcwNGE5MCZYLUFtei1TaWduZWRIZWFkZXJzPWhvc3QifQ.2BuchI9L0zi2aNpHDahkj3rHEiC92FAi3p-lPxm-Vs0)

This sample project demonstrates advanced SwiftUI navigation techniques that solve common navigation challenges in complex applications:

- **TabView with Multiple NavigationStacks** - Each tab has its own independent NavigationStack and navigation state
- **Type-safe Navigation** with enum-based destinations
- **Programmatic Navigation** using a centralized router
- **Protocol-based Routing** for feature isolation and testability

## Design Philosophy

### Core Principles

1. **Single Source of Truth**: The Router manages all navigation state for each tab
2. **Type Safety**: Compile-time checking of navigation destinations
3. **Dependency Inversion**: Features depend on routing protocols, not concrete implementations
4. **Testability**: Easy mocking and unit testing of navigation logic
5. **Scalability**: Clean separation of concerns for large applications
6. **State Retention**: Each tab retains its navigation stack when switching tabs

### Why This Approach?

SwiftUI navigation with multiple `NavigationLink`s scattered throughout the view hierarchy can become difficult to manage as applications grow. This approach provides:

- **Centralized Control**: All navigation logic in one place
- **Predictable State**: Clear navigation state management
- **Better Testing**: Isolated navigation logic for unit tests
- **Feature Isolation**: Each feature defines its own routing needs
- **Independent Tab Navigation**: Each tab maintains its own navigation history, improving user experience

## Navigation Architecture

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

## App Structure

### Sample App Features

The sample app demonstrates a chat application with the following navigation flows:

1. **Home Screen** → Shows chat list with navigation to contacts
2. **Contact List** → Displays contacts in table or list format  
3. **Contact Detail** → Shows detailed contact information
4. **Conversation** → Chat interface with the selected contact
5. **Settings** → Profile and privacy settings, each with their own navigation stack

### Navigation Flows

**Flow 1: Enter Existing Conversation**
```
Chats Tab → Home → Conversation → Contact Detail 
```

**Flow 2: Start New Conversation**
```
Chats Tab → Home → Contact List → Contact Detail → Conversation
```

**Flow 3: Settings Navigation**
```
Settings Tab → Settings Home → Profile Settings / Privacy Settings
```

Each tab maintains its own navigation stack, allowing users to switch tabs and return to their previous navigation state within each tab.


## Best Practices

1. **TabView with Multiple NavigationStacks**: Use a TabView at the root, with a separate NavigationStack for each tab
2. **Type Safety**: Always use enum-based destinations
3. **Protocol Dependencies**: Features should depend on protocols, not concrete types
4. **Centralized Router**: Keep all navigation logic in one place
5. **Testability**: Design for easy testing with mock implementations
6. **State Retention**: Let each tab maintain its own navigation history for a better user experience

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
router.chatTabPath = []
```

### Adding New Destinations

1. Add a new case to the `Destination` enum
2. Add navigation methods to the `Router` class
3. Update the `RouterView` switch statement
4. Create the corresponding view

## Contributing

This sample demonstrates modern SwiftUI navigation best practices that can be adapted for your own applications. Feel free to use this as a reference for implementing scalable navigation in your SwiftUI projects.


---

*This sample demonstrates an opinionated approach to SwiftUI navigation that prioritizes type safety, testability, and scalability. For more details on the design philosophy, see the accompanying blog post: [Building Scalable SwiftUI Navigation](https://eric-liu-developer.medium.com/building-scalable-navigation-in-swiftui-wip-45ff2845e4e2).*
