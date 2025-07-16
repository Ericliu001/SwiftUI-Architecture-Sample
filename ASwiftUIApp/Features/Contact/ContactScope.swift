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
    // Parent Reference
    // Connection to parent scope through protocol-defined interface
    private let parent: Parent

    init(parent: Parent) {
        self.parent = parent
        print("🟢 ContactScope created")
    }
    
    deinit {
        print("🔴 ContactScope deallocated")
    }

    // Dependencies from Parent
    // Accessing parent-provided resources through lazy properties
    lazy var router: ContactRouter = parent.contactRouter
    lazy var dataModel = parent.dataModel

    // View Factory Methods
    // Creating views with proper dependency injection
    func contactTableView() -> some View {
        ContactTable(scope: self)
    }

    func contactListView() -> some View {
        ContactList(scope: self)
    }
    
    func contactInfoView(contact: Contact) -> some View {
        ContactInfoView(scope: self, contact: contact)
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
