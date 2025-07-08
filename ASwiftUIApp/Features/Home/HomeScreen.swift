//
//  HomeScreen.swift
//  ASwiftUIApp
//
//  Created by Eric Liu on 6/23/25.
//  Copyright © 2025 Apple. All rights reserved.
//

import SwiftUI

struct HomeScreen: View {
    @Environment(DataModel.self) private var dataModel
    let router: Router
    
    var body: some View {
        VStack{
            ChatsView(router: router)
        }
        .navigationTitle("Chats")
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button(
                    action: {
                        router.gotoContactsList()
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
    HomeScreen(router: Router())
        .environment(DataModel())
}
