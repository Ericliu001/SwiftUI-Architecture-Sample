//
//  RootNavigationView.swift
//  ASwiftUIApp
//
//  Created by Eric Liu on 7/1/25.
//  Copyright © 2025 Apple. All rights reserved.
//

import SwiftUI

struct RouterView: View {
    // In prduction, the Router instance should be provided by dependency injection.
    @Environment(Router.self) var router
    
    let destination: Destination
    
    var body: some View {
        switch destination {
        case .home:
            HomeScreen()
        case .conversation(let recipient):
            ConversationView(router: router, contact: recipient)
        case .contactDetail(let contact):
            ContactDetailView(router: router, contact: contact)
        case .contactList:
            ContactFeatureRootView(router: router)
        }
    }
}

#Preview {
    RouterView(destination: .home)
}
