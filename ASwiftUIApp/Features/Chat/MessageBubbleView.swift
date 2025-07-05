//
//  ChatMessageView.swift
//  BuddyGo
//
//  Created by Eric Liu on 6/24/24.
//

import SwiftUI

struct MessageBubbleView: View {
    let message: Message
    let isSentByCurrentUser: Bool
    
    
    var body: some View {
        HStack{
            if isSentByCurrentUser {
                Spacer()
                VStack(alignment: .trailing) {
                    if !message.text.isEmpty {
                        
                        Text(message.text)
                            .padding(10)
                            .background(.green.gradient)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.leading, 20)
                
            } else {
                Text(message.text)
                    .padding(10)
                    .background(Color.gray.tertiary)
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.trailing, 20)
                Spacer()
            }
        }
    }
}

#Preview("light") {
    List {
        MessageBubbleView(message: Message.sampleData[0], isSentByCurrentUser: false)
        MessageBubbleView(message: Message.sampleData[1], isSentByCurrentUser: true)
        MessageBubbleView(message: Message.sampleData[2], isSentByCurrentUser: false)
        MessageBubbleView(message: Message.sampleData[3], isSentByCurrentUser: true)
    }
}

#Preview("dark") {
    List {
        MessageBubbleView(message: Message.sampleData[0], isSentByCurrentUser: false)
        MessageBubbleView(message: Message.sampleData[1], isSentByCurrentUser: true)
        MessageBubbleView(message: Message.sampleData[2], isSentByCurrentUser: false)
        MessageBubbleView(message: Message.sampleData[3], isSentByCurrentUser: true)
    }.preferredColorScheme(.dark)
}
