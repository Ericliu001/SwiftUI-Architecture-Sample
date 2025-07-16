//
//  Weak.swift
//  ASwiftUIApp
//
//  Created by Eric Liu on 7/16/25.
//  Copyright © 2025 Apple. All rights reserved.
//

import Foundation

/**
 * A utility class that provides lazy instantiation with weak reference management.
 * 
 * This class is designed to prevent retain cycles in parent-child scope relationships
 * while maintaining lazy initialization semantics. It holds a weak reference to the
 * created object and can recreate it using the provided closure if needed.
 *
 * Usage in scope architecture:
 * ```swift
 * lazy var childScope: Weak<ChildScope> = Weak({ ChildScope(parent: self) })
 * ```
 *
 * Access the wrapped object via the `value` property:
 * ```swift
 * childScope.value.someMethod()
 * ```
 */
class Weak<T: AnyObject> {
    /// Weak reference to the created object to prevent retain cycles
    private weak var _value: T?
    
    /// Closure that creates a new instance when needed
    private let provider: () -> T
    
    /**
     * Initializes the Weak wrapper with a provider closure.
     *
     * - Parameter provider: A closure that creates an instance of T when called.
     *                      This closure will be called lazily when `value` is first accessed
     *                      or when the weakly-held instance has been deallocated.
     */
    init(_ provider: @escaping () -> T) {
        self.provider = provider
    }
    
    /**
     * Lazily creates and returns the wrapped object.
     *
     * If the weakly-held instance still exists, it returns that instance.
     * If the instance has been deallocated or hasn't been created yet,
     * it creates a new instance using the provider closure.
     *
     * - Returns: The wrapped object of type T
     */
    var value: T {
        // Return existing instance if it's still alive
        if let value = _value {
            return value
        }
        
        // Create new instance and store weak reference
        let newValue = provider()
        _value = newValue
        return newValue
    }
}
