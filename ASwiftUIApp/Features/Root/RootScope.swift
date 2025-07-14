//
//  RootScope.swift
//  ASwiftUIApp
//
//  Created by Eric Liu on 7/14/25.
//  Copyright © 2025 Apple. All rights reserved.
//

import Foundation
import SwiftUI

final class RootScope: ContactScope.Parent, ChatScope.Parent, SettingsScope.Parent {
    let rootRouter = Router()
    
    lazy var contactRouter: ContactRouter = rootRouter
    lazy var chatRouter: ChatRouter = rootRouter
    lazy var settingsRouter: SettingsRouter = rootRouter
    
    lazy var dataModel = DataModel()
    
    lazy var contactScope: ContactScope = .init(parent: self)
    lazy var chatScope: ChatScope = .init(parent: self)
    lazy var settingsScope: SettingsScope = .init(parent: self)
    
    func routerView(dest: Destination) -> some View {
        RouterView(scope: self, destination: dest)
    }
}


#if DEBUG
extension RootScope {
    static var mock: RootScope = RootScope()
}

#endif
