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
    lazy var dataModel = parent.dataModel
    
    
    
    func contactTableView() -> some View {
        ContactTable(scope: self)
    }
    
    func contactListView() -> some View {
        ContactList(scope: self)
    }
    
    func contactDetailView(contact: Contact) -> some View {
        ContactDetailView(scope: self, contact: contact)
    }
    
    func contactFeatureRootView() -> some View {
        ContactFeatureRootView(scope: self)
    }
}


extension ContactScope {
    protocol Parent {
        var contactRouter: ContactRouter { get }
        
        var dataModel: DataModel { get }
    }
}


#if DEBUG


extension ContactScope {
    class MockParent: ContactScope.Parent {
        var dataModel: DataModel = DataModel()
        
        var contactRouter: ContactRouter = MockContactRouter.shared
    }
    
    static var mock: ContactScope = ContactScope(parent: MockParent())
}
#endif
