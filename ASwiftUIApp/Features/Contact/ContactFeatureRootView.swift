//
//  ContactFeatureRootView.swift
//  ASwiftUIApp
//
//  Created by Eric Liu on 6/23/25.
//  Copyright © 2025 Apple. All rights reserved.
//

import SwiftUI

struct ContactFeatureRootView: View {
    let scope: ContactScope

    init(scope: ContactScope) {
        self.scope = scope
    }

    var body: some View {
        Group {
            switch scope.dataModel.displayMode {
            case .table:
                scope.contactTableView()
            case .list:
                scope.contactListView()
            }
        }
        .navigationTitle("Contacts")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                @Bindable var dataModel = scope.dataModel
                DisplayModePicker(mode: $dataModel.displayMode)
            }
        }
    }
}

#Preview {
    ContactFeatureRootView(scope:  ContactScope.mock)
}
