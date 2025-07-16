//
//  ChatScope.swift
//  ASwiftUIApp
//
//  Created by Eric Liu on 7/14/25.
//  Copyright © 2025 Apple. All rights reserved.
//

import Foundation
import SwiftUI

final class ChatScope {
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
    lazy var router: ChatRouter = parent.chatRouter
    
    // Local Dependencies
    // Scope-specific state and resources that belong to the chat feature
    lazy var messages: [Message] = Message.sampleData

    // Child Scopes
    // Managing child feature domains within the chat scope
    lazy var chatListItemScope: Weak<ChatListItemScope> = Weak({ ChatListItemScope(parent: self) })

    // View Factory Methods
    // Creating views with proper dependency injection
    func chatFeatureRootview() -> some View {
        ChatFeatureRootView(scope: self)
    }

    func chatListView() -> some View {
        ChatListView(scope: self)
    }

    func conversationView(contact: Contact) -> some View {
        ConversationView(scope: self, contact: contact)
    }
}

extension ChatScope {
    protocol Parent {
        var chatRouter: ChatRouter { get }
    }
}

extension ChatScope: ChatListItemScope.Parent {
    // No specific implementations needed for ChatListItemScope.Parent
}

#if DEBUG
extension ChatScope {
    private class MockParent: Parent {
        var chatRouter: ChatRouter = MockChatRouter.shared
    }

    static let mock = ChatScope(parent: MockParent())
}

#endif
