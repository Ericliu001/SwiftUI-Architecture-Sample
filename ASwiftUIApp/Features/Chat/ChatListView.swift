//
//  ChatsView.swift
//  ASwiftUIApp
//
//  Created by Eric Liu on 6/24/25.
//  Copyright © 2025 Apple. All rights reserved.
//

import SwiftUI

struct ChatListView: View {
    @State private var chats = Chat.mock

    let scope: ChatScope

    var body: some View {
        VStack(alignment: .leading){
            List {
                ForEach(chats) { chat in
                    Button(action: {
                        scope.chatRouter.gotoConversation(recipient: chat.recipient)
                    })
                    {
                        scope.chatListItemScope.value.listItemView(chat: chat)
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
    ChatListView(scope: ChatScope.mock)
}


