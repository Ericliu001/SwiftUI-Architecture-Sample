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
    private let parent: Parent
    
    init(parent: Parent) {
        self.parent = parent
    }
    
    
    lazy var router: ChatRouter = parent.chatRouter
    
    
    func chatFeatureRootview() -> some View {
        ChatFeatureRootView(scope: self)
    }
    
    func chatListView() -> some View {
        ChatListView(scope: self)
    }
    
    func chatListItemView(chat: Chat) -> some View {
        ChatListItemView(chat: chat)
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
