//
//  RootScope.swift
//  ASwiftUIApp
//
//  Created by Eric Liu on 7/14/25.
//  Copyright © 2025 Apple. All rights reserved.
//

import Foundation

final class RootScope: ContactScope.Parent {
    let rootRouter = Router()
    
    lazy var contactRouter: ContactRouter = rootRouter
    lazy var chatRouter: ChatRouter = rootRouter
    
    lazy var contactScope: ContactScope = .init(parent: self)
    lazy var chatScope: ChatScope = .init()
}
