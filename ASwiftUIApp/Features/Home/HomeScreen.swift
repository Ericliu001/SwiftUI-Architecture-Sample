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
    @Environment(Router.self) var router
    
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
                }
                .buttonStyle(.plain)
            }
        }
        #endif
        
    }
}

#Preview {
    HomeScreen()
        .environment(DataModel())
        .environment(Router())
}
