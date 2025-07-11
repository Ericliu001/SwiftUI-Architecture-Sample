//
//  HomeScreen.swift
//  ASwiftUIApp
//
//  Created by Eric Liu on 6/23/25.
//  Copyright © 2025 Apple. All rights reserved.
//

import SwiftUI

struct ChatFeatureRootView: View {
    @Environment(DataModel.self) private var dataModel
    let router: ChatRouter
    
    var body: some View {
        VStack{
            ChatsView(router: router)
        }
        .navigationTitle("Chats")
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button(
                    action: {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                            router.gotoContactList()
                        }
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
    ChatFeatureRootView(router: Router())
        .environment(DataModel())
}
