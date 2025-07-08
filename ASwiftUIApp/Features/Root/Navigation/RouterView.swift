//
//  RootNavigationView.swift
//  ASwiftUIApp
//
//  Created by Eric Liu on 7/1/25.
//  Copyright © 2025 Apple. All rights reserved.
//

import SwiftUI

struct RouterView: View {
    let router: Router
    let destination: Destination
    
    var body: some View {
        switch destination {
        case .conversation(let recipient):
            ConversationView(router: router, contact: recipient)
                .toolbar(.hidden, for: .tabBar)
        case .contactDetail(let contact):
            ContactDetailView(router: router, contact: contact)
                .toolbar(.hidden, for: .tabBar)
        case .contactList:
            ContactFeatureRootView(router: router)
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
    RouterView(router: Router() ,destination: .contactList)
}
