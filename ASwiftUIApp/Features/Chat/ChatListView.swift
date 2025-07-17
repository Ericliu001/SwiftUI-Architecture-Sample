//
//  ChatsView.swift
//  ASwiftUIApp
//
//  Created by Eric Liu on 6/24/25.
//  Copyright © 2025 Apple. All rights reserved.
//

import SwiftUI

struct ChatListView: View {
    let scope: ChatScope

    var body: some View {
        VStack(alignment: .leading){
            List {
                ForEach(scope.chats) { chat in
                    Button(action: {
                        scope.chatRouter.gotoConversation(recipient: chat.recipient)
                    })
                    {
                        scope.chatListItemScope.value.listItemView(chat: chat)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                    .draggable(chat)
                }
                .dropDestination(for: Chat.self) { droppedChats, index in
                    dropChat(index, droppedChats)
                }
                .onMove { fromOffsets, toOffset in
                    scope.chats.move(fromOffsets: fromOffsets, toOffset: toOffset)
                }
            }
        }
    }
    
    private func dropChat(_ index: Int, _ droppedChats: [Chat]) {
        guard let firstDroppedChat = droppedChats.first else { return }
        
        if let existingIndex = scope.chats.firstIndex(where: { $0.id == firstDroppedChat.id}) {
            let indexSet = IndexSet(integer: existingIndex)
            scope.chats.move(fromOffsets: indexSet, toOffset: index)
        } else {
            scope.chats.insert(firstDroppedChat, at: index)
        }
    }
}

#Preview {
    ChatListView(scope: ChatScope.mock)
}


