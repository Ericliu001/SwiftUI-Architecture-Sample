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
        #if !os(macOS)
        .navigationBarTitleDisplayMode(.inline) // ← This forces the title to be inline
        .navigationBarItems(
            trailing:
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
        
        )
        #elseif os(macOS)
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
        #endif
        
    }
}

#Preview {
    HomeScreen(router: Router())
        .environment(DataModel())
}
