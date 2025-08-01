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
            scope.chatScope.value.conversationScope.value.conversationView(contact: recipient)
                .toolbar(.hidden, for: .tabBar)
        case .contactDetail(let contact):
            scope.contactScope.value.contactDetailView(contact: contact)
                .toolbar(.hidden, for: .tabBar)
        case .contactList:
            scope.contactScope.value.contactFeatureRootView()
                .toolbar(.hidden, for: .tabBar)
        case .profile_settings:
            scope.settingsScope.value.profileSettingsView()
                .toolbar(.hidden, for: .tabBar)
        case .privacy_settings:
            scope.settingsScope.value.privacySettingsView()
                .toolbar(.hidden, for: .tabBar)
        }
    }
}

#Preview {
    RouterView(scope: RootScope.mock ,destination: .contactList)
}
