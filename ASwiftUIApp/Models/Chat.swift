//
//  Chat.swift
//  ASwiftUIApp
//
//  Created by Eric Liu on 6/24/25.
//  Copyright © 2025 Apple. All rights reserved.
//

import Foundation
import SwiftData
import SwiftUI
import UniformTypeIdentifiers

@Model
class Chat: Identifiable {
    var id: UUID
    var name: String
    var messages: [Message] = []
    var recipient : Contact

    init(id: UUID = .init(), name: String = "", recipient: Contact) {
        self.id = id
        self.name = name
        self.recipient = recipient
    }
}

extension Chat: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        ProxyRepresentation(exporting: \.name)
    }
}

#if DEBUG
extension Chat {
    static var mock = [
        Chat(name: "Hi, good morning!", recipient: Contact.mock[0]),
        Chat(name: "Happy birthday!", recipient: Contact.mock[1]),
        Chat(name: "Long time no see!", recipient: Contact.mock[2]),
        Chat(name: "How are you!", recipient: Contact.mock[3]),
        Chat(name: "Friend!", recipient: Contact.mock[4]),
        Chat(name: "Miss you!", recipient: Contact.mock[5]),
        Chat(name: "Got your message!", recipient: Contact.mock[6]),
    ]
}

#endif
