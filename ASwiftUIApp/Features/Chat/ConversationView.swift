//
//  ConversationView.swift
//  ASwiftUIApp
//
//  Created by Eric Liu on 6/29/25.
//  Copyright © 2025 Apple. All rights reserved.
//

import SwiftUI

struct ConversationView: View {
    private let router: ChatRouter
    private let contact: Contact
    
    init(router: ChatRouter, contact: Contact) {
        self.router = router
        self.contact = contact
    }
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    router.gotoContactDetail(contact)
                }){
                    Group {
                        ThumbnailView(contact: contact)
                            .frame(width: 60, height: 60)
                        
                        Text("\(contact.fullName)")
                    }
                }
                .buttonStyle(.plain)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.1))
            
            Spacer()
            
            List {
                ForEach(
                    Array(Message.sampleData.enumerated()),
                    id: \.element
                ) {
                    index,
                    message in
                    MessageBubbleView(
                        message: message,
                        isSentByCurrentUser: index % 2 == 0
                    )
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(PlainListStyle()) // Remove the default list style
            .background(Color.clear)
        }
        #if !os(macOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

#Preview {
    ConversationView(router: MockChatRouter.shared,contact: Contact.mock[0])
}
