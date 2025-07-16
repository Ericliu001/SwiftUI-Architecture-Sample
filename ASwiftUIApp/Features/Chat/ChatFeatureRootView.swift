//
//  HomeScreen.swift
//  ASwiftUIApp
//
//  Created by Eric Liu on 6/23/25.
//  Copyright © 2025 Apple. All rights reserved.
//

import SwiftUI

struct ChatFeatureRootView: View {
    let scope: ChatScope

    init(scope: ChatScope) {
        self.scope = scope
    }

    var body: some View {
        VStack{
            scope.chatListView()
        }
        .navigationTitle("Chats")
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button(
                    action: {
                        scope.chatRouter.gotoContactList()
                    }
                ) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title)
                        .foregroundColor(.blue)
                }
                .buttonStyle(.plain)
            }
        }
    }
}

#Preview {
    ChatFeatureRootView(scope: ChatScope.mock)
}
