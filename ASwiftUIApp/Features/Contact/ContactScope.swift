//
//  ContactScope.swift
//  ASwiftUIApp
//
//  Created by Eric Liu on 7/14/25.
//  Copyright © 2025 Apple. All rights reserved.
//

import Foundation
import SwiftUI

final class ContactScope {
    private let parent: Parent
    
    init(parent: Parent) {
        self.parent = parent
    }
    
    lazy var router: ContactRouter = parent.contactRouter
    
    
    
    func contactTableView() -> some View {
        ContactTable(scope: self)
    }
    
    func contactListView() -> some View {
        ContactList(scope: self)
    }
}


extension ContactScope {
    protocol Parent {
        var contactRouter: ContactRouter { get }
    }
}


#if DEBUG


extension ContactScope {
    class MockParent: ContactScope.Parent {
        var contactRouter: ContactRouter = MockContactRouter.shared
    }
    
    static var mock: ContactScope = ContactScope(parent: MockParent())
}
#endif
