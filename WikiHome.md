# SwiftUI Navigation Sample - Architectural Guide

## What is This Project?

This SwiftUI Navigation Sample is a comprehensive demonstration of modern iOS application architecture that combines two powerful complementary patterns:

- **Real-world chat application** showcasing advanced SwiftUI navigation and dependency injection
- **Educational resource** for understanding scalable iOS architecture patterns
- **Production-ready patterns** that prioritize type safety, testability, and maintainability

## Dual Architecture Overview

This project uniquely demonstrates how two architectural patterns work together to create a robust, scalable foundation:

### [Navigation Architecture](https://github.com/Ericliu001/SwiftUI-Navigation-Sample/wiki/Navigation) 
- **Type-safe, centralized routing** using enum-based destinations
- **TabView with independent NavigationStacks** for complex navigation flows
- **Protocol-based routing** that enables feature isolation and testing
- **Programmatic navigation control** through a centralized Router

### [Scope Architecture](https://github.com/Ericliu001/SwiftUI-Navigation-Sample/wiki/Scope-Architecture-Design)
- **Hierarchical dependency injection** organized as a tree structure
- **Feature-based modularity** with clear domain boundaries
- **Protocol-driven parent-child relationships** for flexible dependency management
- **View factory pattern** ensuring consistent dependency provision

### Why Both Architectures?

The combination addresses different architectural concerns:
- **Navigation Architecture** manages UI flow and routing logic
- **Scope Architecture** manages resource dependencies and feature organization
- **Together** they provide a complete foundation for complex SwiftUI applications
