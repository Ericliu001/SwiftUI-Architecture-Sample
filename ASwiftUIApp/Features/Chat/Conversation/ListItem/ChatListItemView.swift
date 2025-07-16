//
//  ChatListItemView.swift
//  ASwiftUIApp
//
//  Created by Eric Liu on 6/24/25.
//  Copyright © 2025 Apple. All rights reserved.
//


import SwiftUI

struct ChatListItemView: View {
    private let chat: Chat

    init(chat: Chat) {
        self.chat = chat
    }

    var body: some View {
        HStack {
            ThumbnailView(contact: chat.recipient)
                .frame(width: 60, height: 60)

            VStack(alignment: .leading) {
                Text(chat.recipient.fullName)
                Text(chat.name)
                    .foregroundStyle(.secondary)
            }
        }
    }
}
