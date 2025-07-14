//
//  Tab.swift
//  ASwiftUIApp
//
//  Created by Eric Liu on 7/8/25.
//  Copyright © 2025 Apple. All rights reserved.
//

enum Tabs {
    case chats
    case settings

    var name: String {
        switch self {
        case .chats:
            return "Chats"
        case .settings:
            return "Settings"
        }
    }

    var systemImageName: String {
        switch self {
        case .chats:
            return "message.circle.fill"
        case .settings:
            return "gear"
        }
    }
}
