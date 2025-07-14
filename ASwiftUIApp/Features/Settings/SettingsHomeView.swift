//
//  SettingsHome.swift
//  ASwiftUIApp
//
//  Created by Eric Liu on 7/8/25.
//  Copyright © 2025 Apple. All rights reserved.
//

import SwiftUI

struct SettingsHomeView: View {
    let scope: SettingsScope
    
    @State private var notificationsEnabled = true
    @State private var darkModeEnabled = false
    
    init(scope: SettingsScope) {
        self.scope = scope
    }
    
    var body: some View {
        Form {
            Section(header: Text("Account")) {
                Button("Profile") {
                    scope.router.goToProfile()
                }
                Button("Privacy") {
                    scope.router.gotoPrivacy()
                }
            }

            Section(header: Text("App Settings")) {
                Toggle("Enable Notifications", isOn: $notificationsEnabled)
                Toggle("Dark Mode", isOn: $darkModeEnabled)
            }
            
            Section {
                Button("Back to Chats") {
                    scope.router.gotoChats()
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
    SettingsHomeView(scope: SettingsScope.mock)
}
