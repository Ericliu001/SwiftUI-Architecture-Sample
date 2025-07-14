//
//  ContactFeatureRootView.swift
//  ASwiftUIApp
//
//  Created by Eric Liu on 6/23/25.
//  Copyright © 2025 Apple. All rights reserved.
//

import SwiftUI

struct ContactFeatureRootView: View {
    @Environment(DataModel.self) private var dataModel
    
    let scope: ContactScope
    
    init(scope: ContactScope) {
        self.scope = scope
    }
    
    var body: some View {
        Group {
            switch dataModel.displayMode {
            case .table:
                scope.contactTableView()
            case .list:
                scope.contactListView()
            }
        }
        .environment(dataModel)
        .navigationTitle("Contacts")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                @Bindable var dataModel = dataModel
                DisplayModePicker(mode: $dataModel.displayMode)
            }
        }
    }
}

#Preview {
    ContactFeatureRootView(scope:  ContactScope.mock)
        .environment(DataModel())
}
