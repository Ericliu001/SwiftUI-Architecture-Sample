//
//  Destination.swift
//  ASwiftUIApp
//
//  Created by Eric Liu on 7/1/25.
//  Copyright © 2025 Apple. All rights reserved.
//

import Foundation


enum Destination: Hashable {
    case home
    case contactList
    case conversation(Contact)
    case contactDetail(Contact)
}
