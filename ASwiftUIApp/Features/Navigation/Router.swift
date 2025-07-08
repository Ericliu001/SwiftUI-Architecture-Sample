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
    var chatTabPath : [Destination] = []
    var settingsTabPath: [Destination] = []
    
    func gotoConversation(recipient: Contact) {
        chatTabPath = [.conversation(recipient)]
    }
    
    func gotoContactDetail(_ contact: Contact){
        chatTabPath.append(.contactDetail(contact))
    }
    
    func gotoContactsList(){
        chatTabPath.append(.contactList)
    }
}
