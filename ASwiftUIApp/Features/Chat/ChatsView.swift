//
//  ChatsView.swift
//  ASwiftUIApp
//
//  Created by Eric Liu on 6/24/25.
//  Copyright © 2025 Apple. All rights reserved.
//

import SwiftUI

struct ChatsView: View {
    @State private var chats = Chat.mock
    
    let router: ChatRouter
    
    var body: some View {
        VStack(alignment: .leading){
            List {
                ForEach(chats) { chat in
                    Button(action: {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                            router.gotoConversation(recipient: chat.recipient)
                        }
                    })
                    {
                        ChatListItemView(chat: chat)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .contentShape(Rectangle())
                            .scaleEffect(1.0)
                            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: chat.id)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}

#Preview {
    ChatsView(router: MockChatRouter.shared)
}


