//
//  RootScope.swift
//  ASwiftUIApp
//
//  Created by Eric Liu on 7/14/25.
//  Copyright © 2025 Apple. All rights reserved.
//

import Foundation
import SwiftUI

final class RootScope: ContactScope.Parent, ChatScope.Parent, SettingsScope.Parent {
    
    init() {
        print("🟢 RootScope created")
    }
    
    deinit {
        print("🔴 RootScope deallocated")
    }
    
    // Local Dependencies
    // Root-level resources shared across the application
    lazy var rootRouter = Router()
    lazy var dataModel = DataModel()

    // Router protocol implementations for child scopes
    lazy var contactRouter: ContactRouter = rootRouter
    lazy var chatRouter: ChatRouter = rootRouter
    lazy var settingsRouter: SettingsRouter = rootRouter

    // Child Scopes
    // Managing feature domains at the top level
    lazy var contactScope: Weak<ContactScope> = Weak({ ContactScope(parent: self) })
    lazy var chatScope: Weak<ChatScope> = Weak( {ChatScope(parent: self)})
    lazy var settingsScope: Weak<SettingsScope> = Weak({ SettingsScope(parent: self) })

    // View Factory Methods
    // Creating root-level views with proper dependency injection
    func routerView(dest: Destination) -> some View {
        RouterView(scope: self, destination: dest)
    }
}


#if DEBUG
extension RootScope {
    static var mock: RootScope = RootScope()
}

#endif
