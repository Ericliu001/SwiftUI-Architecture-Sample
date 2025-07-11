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
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing).combined(with: .opacity),
                        removal: .move(edge: .leading).combined(with: .opacity)
                    ))
            case .list:
                ContactList(router: router)
                    .transition(.asymmetric(
                        insertion: .move(edge: .leading).combined(with: .opacity),
                        removal: .move(edge: .trailing).combined(with: .opacity)
                    ))
            }
        }
        .animation(.easeInOut(duration: 0.3), value: dataModel.displayMode)
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
