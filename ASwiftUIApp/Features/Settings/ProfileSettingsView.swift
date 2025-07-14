//
//  ProfileSettingsView.swift
//  ASwiftUIApp
//
//  Created by Eric Liu on 7/8/25.
//  Copyright © 2025 Apple. All rights reserved.
//

import SwiftUI

struct ProfileSettingsView: View {
    let scope: SettingsScope

    init(scope: SettingsScope) {
        self.scope = scope
    }

    var body: some View {
        Form {
            Section(header: Text("User")) {
                HStack {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.blue)
                    VStack(alignment: .leading) {
                        Text("Ann")
                            .font(.headline)
                        Text("Ann@example.com")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }

            Section(header: Text("Details")) {
                HStack {
                    Text("Location")
                    Spacer()
                    Text("San Francisco, CA")
                        .foregroundColor(.secondary)
                }
                HStack {
                    Text("Member Since")
                    Spacer()
                    Text("2020")
                        .foregroundColor(.secondary)
                }
            }

            Section {
                Button("Edit Profile") {
                    // Handle edit profile action
                }
            }
        }
        .navigationTitle("Profile")
    }
}

#Preview {
    ProfileSettingsView(scope: SettingsScope.mock)
}
