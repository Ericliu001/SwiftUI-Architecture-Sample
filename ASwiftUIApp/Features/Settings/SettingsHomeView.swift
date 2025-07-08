//
//  SettingsHome.swift
//  ASwiftUIApp
//
//  Created by Eric Liu on 7/8/25.
//  Copyright © 2025 Apple. All rights reserved.
//

import SwiftUI

struct SettingsHomeView: View {
    let router: SettingsRouter
    
    var body: some View {
        Form {
            Section(header: Text("Account")) {
                Button("Profile") {
                    router.goToProfile()
                }
                Button("Privacy") {
                    router.gotoPrivacy()
                }
            }

            Section(header: Text("App Settings")) {
                Toggle("Enable Notifications", isOn: .constant(true))
                Toggle("Dark Mode", isOn: .constant(false))
            }
            
            Section {
                Button("Back to Chats") {
                    router.gotoChats()
                }
            }

            Section {
                Button(role: .destructive) {
                    print("User tapped Sign Out")
                } label: {
                    Text("Sign Out")
                }
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    SettingsHomeView(router: MockSettingsRouter.shared)
}
