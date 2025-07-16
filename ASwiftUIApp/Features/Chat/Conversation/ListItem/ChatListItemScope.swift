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
    
    private let parent: Parent
    
    init(parent: Parent) {
        self.parent = parent
    }
    
    func listItemView(chat: Chat) -> some View {
        ChatListItemView(chat: chat)
    }
}

extension ChatListItemScope {
    protocol Parent {
        // No parent dependencies needed currently
    }
}
