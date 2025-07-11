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
                .transition(.asymmetric(
                    insertion: .move(edge: .trailing).combined(with: .opacity),
                    removal: .move(edge: .leading).combined(with: .opacity)
                ))
        case .contactDetail(let contact):
            ContactDetailView(router: router, contact: contact)
                .toolbar(.hidden, for: .tabBar)
                .transition(.scale(scale: 0.8).combined(with: .opacity))
        case .contactList:
            ContactFeatureRootView(router: router)
                .toolbar(.hidden, for: .tabBar)
                .transition(.move(edge: .bottom))
        case .profile_settings:
            ProfileSettingsView()
                .toolbar(.hidden, for: .tabBar)
                .transition(.move(edge: .trailing))
        case .privacy_settings:
            PrivacySettingsView()
                .toolbar(.hidden, for: .tabBar)
                .transition(.move(edge: .trailing))
        }
    }
}

#Preview {
    RouterView(router: Router() ,destination: .contactList)
}
