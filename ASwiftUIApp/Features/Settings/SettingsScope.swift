//
//  SettingsScope.swift
//  ASwiftUIApp
//
//  Created by Eric Liu on 7/14/25.
//  Copyright © 2025 Apple. All rights reserved.
//

import Foundation
import SwiftUI

final class SettingsScope {
    // Parent Reference
    // Connection to parent scope through protocol-defined interface
    private let parent: Parent

    init(parent: Parent) {
        self.parent = parent
        print("🟢 SettingsScope created")
    }
    
    deinit {
        print("🔴 SettingsScope deallocated")
    }
    

    // Dependencies from Parent
    // Accessing parent-provided resources through lazy properties
    lazy var router: SettingsRouter = parent.settingsRouter

    // View Factory Methods
    // Creating views with proper dependency injection
    func settingsHomeView() -> some View {
        SettingsHomeView(scope: self)
    }

    func profileSettingsView() -> some View {
        ProfileSettingsView(scope: self)
    }

    func privacySettingsView() -> some View {
        PrivacySettingsView(scope: self)
    }
}

extension SettingsScope {
    protocol Parent {
        var settingsRouter: SettingsRouter { get }
    }
}

#if DEBUG
extension SettingsScope {
    private class MockParent: Parent {
        var settingsRouter: SettingsRouter = MockSettingsRouter.shared
    }

    static let mock = SettingsScope(parent: MockParent())
}
#endif
