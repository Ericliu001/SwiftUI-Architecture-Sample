//
//  ContactRouter.swift
//  ASwiftUIApp
//
//  Created by Eric Liu on 7/5/25.
//  Copyright © 2025 Apple. All rights reserved.
//

import Foundation

protocol ContactRouter {
    func gotoConversation(recipient: Contact)
    
    func gotoContactDetail(_ contact: Contact)
}


#if DEBUG
class MockContactRouter: ContactRouter {
    func gotoContactDetail(_ contact: Contact) {
        // no-op
    }
    
    func gotoConversation(recipient: Contact) {
        // no-op
    }
    
    static var shared: MockContactRouter = MockContactRouter()
    private init() {}
}

#endif
