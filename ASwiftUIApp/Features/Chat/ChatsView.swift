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
                        router.gotoConversation(recipient: chat.recipient)
                    })
                    {
                        ChatListItemView(chat: chat)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .contentShape(Rectangle())
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


