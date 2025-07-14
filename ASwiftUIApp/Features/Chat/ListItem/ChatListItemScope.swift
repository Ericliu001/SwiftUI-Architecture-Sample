//
//  ChatListItemScope.swift
//  ASwiftUIApp
//
//  Created by Eric Liu on 7/15/25.
//  Copyright © 2025 Apple. All rights reserved.
//

import Foundation
import SwiftUI
final class ChatListItemScope {
    func listItemView(chat: Chat) -> some View {
        ChatListItemView(chat: chat)
    }
}
