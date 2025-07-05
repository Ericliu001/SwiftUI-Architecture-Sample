//
//  Router.swift
//  ASwiftUIApp
//
//  Created by Eric Liu on 7/1/25.
//  Copyright © 2025 Apple. All rights reserved.
//

import Foundation
import SwiftUI

@Observable
final class Router: ContactRouter, ChatRouter {
    var navigationPath : [Destination] = []
    
    func gotoConversation(recipient: Contact) {
        navigationPath = [.conversation(recipient)]
    }
    
    func gotoContactDetail(_ contact: Contact){
        navigationPath.append(.contactDetail(contact))
    }
    
    func gotoContactsList(){
        navigationPath.append(.contactList)
    }
}
