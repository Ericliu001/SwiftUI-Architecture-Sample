//
//  PrivacySettingsView.swift
//  ASwiftUIApp
//
//  Created by Eric Liu on 7/8/25.
//  Copyright © 2025 Apple. All rights reserved.
//

import SwiftUI

struct PrivacySettingsView: View {
    @State private var enableLocationServices = false
    @State private var cameraAccess = false
    @State private var microphoneAccess = false
    @State private var shareUsageData = true

    var body: some View {
        Form {
            Section(header: Text("Permissions")) {
                Toggle("Location Services", isOn: $enableLocationServices)
                Toggle("Camera Access", isOn: $cameraAccess)
                Toggle("Microphone Access", isOn: $microphoneAccess)
            }

            Section(header: Text("Data")) {
                Toggle("Share Usage Data", isOn: $shareUsageData)
            }

            Section {
                Button("Manage App Permissions") {
                    // Insert action to open system settings if desired
                    print("Manage App Permissions tapped")
                }
            }
        }
        .navigationTitle("Privacy")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    PrivacySettingsView()
}
