//
//  ChatMessage.swift
//  BuddyGo
//
//  Created by Eric Liu on 6/5/24.
//

import Foundation
import SwiftData

@Model
final class Message {
    var id: UUID
    var senderId: String
    var text: String
    var imageIds: [UUID]
    var timestamp: Date
    var errorMessage: String?
    
    init(id: UUID = UUID(), senderId: String, text: String, imageIds: [UUID] = [], timestamp: Date = Date(), errorMessage: String? = nil) {
        self.id = id
        self.text = text
        self.imageIds = imageIds
        self.senderId = senderId
        self.timestamp = timestamp
        self.errorMessage = errorMessage
    }
}

#if DEBUG
extension Message {
    static let sampleData = [
        Message(senderId: "2", text: "Hi, this is Ann, how are you?"),
        Message(senderId: "1", text: "I'm good, and you?"),
        Message(senderId: "2", text: "Doing well, I'm reaching out regarding to the apartment you inpected last Saturday."),
        Message(senderId: "1", text: "Hi, thank you for reaching out. I'm not interested, bye."),
    ]
}
#endif
