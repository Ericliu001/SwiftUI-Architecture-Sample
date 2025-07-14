//
//  RootNavigationView.swift
//  ASwiftUIApp
//
//  Created by Eric Liu on 7/1/25.
//  Copyright © 2025 Apple. All rights reserved.
//

import SwiftUI

struct RouterView: View {
    private let scope: RootScope
    private let destination: Destination
    
    init(scope: RootScope, destination: Destination) {
        self.scope = scope
        self.destination = destination
    }
    
    var body: some View {
        switch destination {
        case .conversation(let recipient):
            ConversationView(router: scope.chatRouter, contact: recipient)
                .toolbar(.hidden, for: .tabBar)
        case .contactDetail(let contact):
            ContactDetailView(router: scope.contactRouter, contact: contact)
                .toolbar(.hidden, for: .tabBar)
        case .contactList:
            ContactFeatureRootView(scope: scope.contactScope)
                .toolbar(.hidden, for: .tabBar)
        case .profile_settings:
            ProfileSettingsView()
                .toolbar(.hidden, for: .tabBar)
        case .privacy_settings:
            PrivacySettingsView()
                .toolbar(.hidden, for: .tabBar)
        }
    }
}

#Preview {
    RouterView(scope: RootScope() ,destination: .contactList)
}
