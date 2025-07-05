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
    let router: ContactRouter
    
    var body: some View {
        Group {
            switch dataModel.displayMode {
            case .table:
                ContactTable(router: router)
            case .list:
                ContactList(router: router)
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
    ContactFeatureRootView(router:  MockContactRouter.shared)
        .environment(DataModel())
}
