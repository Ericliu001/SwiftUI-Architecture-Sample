//
//  ChatScope.swift
//  ASwiftUIApp
//
//  Created by Eric Liu on 7/14/25.
//  Copyright © 2025 Apple. All rights reserved.
//

import Foundation
import SwiftUI

final class ChatScope: ConversationScope.Parent, ChatListItemScope.Parent {
    // Parent Reference
    // Connection to parent scope through protocol-defined interface
    private let parent: Parent

    init(parent: Parent) {
        self.parent = parent
        print("🟢 ChatScope created")
    }
    
    deinit {
        print("🔴 ChatScope deallocated")
    }

    // Dependencies from Parent
    // Accessing parent-provided resources through lazy properties
    lazy var chatRouter: ChatRouter = parent.chatRouter
    
    lazy var chats: [Chat] = Chat.mock

    // Child Scopes
    // Managing child feature domains within the chat scope
    lazy var conversationScope: Weak<ConversationScope> = Weak({ ConversationScope(parent: self) })
    lazy var chatListItemScope: Weak<ChatListItemScope> = Weak({ ChatListItemScope(parent: self) })
    
    // View Factory Methods
    // Creating views with proper dependency injection
    func chatFeatureRootview() -> some View {
        ChatFeatureRootView(scope: self)
    }

    func chatListView() -> some View {
        ChatListView(scope: self)
    }
}

extension ChatScope {
    protocol Parent {
        var chatRouter: ChatRouter { get }
    }
}

#if DEBUG
extension ChatScope {
    private class MockParent: Parent {
        var chatRouter: ChatRouter = MockChatRouter.shared
    }

    static let mock = ChatScope(parent: MockParent())
}

#endif
