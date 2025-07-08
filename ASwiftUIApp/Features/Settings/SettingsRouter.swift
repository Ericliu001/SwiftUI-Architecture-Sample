//
//  SettingsRouter.swift
//  ASwiftUIApp
//
//  Created by Eric Liu on 7/8/25.
//  Copyright © 2025 Apple. All rights reserved.
//

import Foundation

protocol SettingsRouter {
    func goToProfile()
    
    func gotoPrivacy()
    
    func gotoChats()
}

#if DEBUG
class MockSettingsRouter: SettingsRouter {
    static let shared = MockSettingsRouter()
    
    func gotoChats() {
        // No-op
    }
    
    func gotoPrivacy() {
        // No-op
    }
    
    
    func goToProfile() {
        // No-op
    }
}
#endif
